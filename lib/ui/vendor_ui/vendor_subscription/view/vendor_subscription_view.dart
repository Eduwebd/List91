import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/vendor_subscription_plan/vendor_subscription_plan_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';

import '../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../core/vendor/api/common/ps_status.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/vendor_subscription_bought_parameter_holder.dart';
import '../../../../core/vendor/viewobject/vendor_subscription_plan.dart';
import '../../../custom_ui/vendor_subscription/component/vendor_subscription_card.dart';
import '../../common/dialog/error_dialog.dart';
import '../../common/ps_app_bar_widget.dart';
import '../../common/ps_ui_widget.dart';

class VendorSubscriptionView extends StatefulWidget {
  const VendorSubscriptionView(
      {Key? key, this.androidKeyList, this.iosKeyList, required this.vendorId})
      : super(key: key);

  final String? androidKeyList;
  final String? iosKeyList;
  final String? vendorId;
  @override
  State<VendorSubscriptionView> createState() => _VendorSubscriptionViewState();
}

class _VendorSubscriptionViewState extends State<VendorSubscriptionView> {
  /// Is the API available on the device
  bool available = true;

  /// The In App Purchase plugin
  final InAppPurchase _iap = InAppPurchase.instance;

  /// Products for sale
  List<ProductDetails> _products = <ProductDetails>[];

  /// Updates to purchases
  late StreamSubscription<List<PurchaseDetails>>? _subscription;

  final String _kConsumableId = 'consumable';
  final bool _kAutoConsume = true;
  String? amount;

  /// Initialize data
  Future<void> _initialize() async {
    // Check availability of In App Purchases
    available = await _iap.isAvailable();

    if (available) {
      await _getProducts();

      // Listen to new purchases
      _subscription = _iap.purchaseStream.listen(
          (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      }, onDone: () {
        print('Done Purhcase');
        _subscription?.cancel();
      }, onError: (dynamic error) {
        print(error);
        print('Error Purchase');
        PsProgressDialog.dismissDialog();
        // handle error here.
      });
    }
  }

  Set<String> idListByPlatfrom() {
    String keyListString = '';

    if (Platform.isAndroid && widget.androidKeyList != null) {
      keyListString = widget.androidKeyList!;
    } else if (Platform.isIOS && widget.iosKeyList != null) {
      keyListString = widget.iosKeyList!;
    }
    // ignore: prefer_final_locals
    List<String> keyList = keyListString.split('##');
    keyList.removeLast();
    return keyList.toSet();
  }

  /// Get all products available for sale
  Future<void> _getProducts() async {
    ProductDetailsResponse response;
    response = await _iap.queryProductDetails(idListByPlatfrom());
    setState(() {
      _products = response.productDetails;
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (Platform.isAndroid) {
        if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
          final InAppPurchaseAndroidPlatformAddition androidAddition =
              _iap.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await PsProgressDialog.showDialog(context);
        await _iap.completePurchase(purchaseDetails);
      }

      if (purchaseDetails.status == PurchaseStatus.purchased) {
        //
        // Call PS Server
        //
        print('NEW PURCHASE');
        print(purchaseDetails.status);
        final VendorSubscriptionPlan package =
            getPackageByIAPKey(purchaseDetails.productID)!;
        final VendorSubScriptionBoughtParameterHolder
            packgageBoughtParameterHolder =
            VendorSubScriptionBoughtParameterHolder(
                userId: psValueHolder!.loginUserId,
                subscriptionPlanId: package.vendorSubscriptionId,
                paymentMethod: PsConst.PAYMENT_IN_APP_PURCHASE_METHOD,
                price: amount,
                razorId: '',
                isPaystack: PsConst.ZERO,
                vendorId: widget.vendorId);
        final PsResource<ApiStatus> packageBoughtStatus =
            await subscriptionPlanProvider!.postData(
                requestPathHolder: RequestPathHolder(
                  loginUserId: psValueHolder!.loginUserId,
                  headerToken: psValueHolder!.headerToken,
                ),
                requestBodyHolder: packgageBoughtParameterHolder);
        PsProgressDialog.dismissDialog();
        if (packageBoughtStatus.status == PsStatus.SUCCESS) {
          Navigator.pushNamed(context, RoutePaths.vendorRegisterationSuccess);

          // showDialog<dynamic>(
          //     context: context,
          //     builder: (BuildContext contet) {
          //       return SuccessDialog(
          //         message: 'item_entry__buy_package_success'.tr,
          //         onPressed: () {
          //            Navigator.(context,);
          //         },
          //       );
          //     });
        } else {
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                  message: packageBoughtStatus.message,
                );
              });
        }
      }
      PsProgressDialog.dismissDialog();
    }
  }

  /// Purchase a product
  Future<void> _buyProduct(ProductDetails prod) async {
    final ProductDetails productDetails = prod;

    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);

    if (Platform.isIOS) {
      //
    }

    try {
      // if (productDetails.id == _kConsumableId) {
      final bool status =
          await _iap.buyConsumable(purchaseParam: purchaseParam);
      print(status);
      // }
    } catch (e) {
      print('error');
      PsProgressDialog.dismissDialog();
      if (Platform.isIOS) {
        // }
      }
    }
  }

  VendorSubscriptionPlan? getPackageByIAPKey(String key) {
    print('key is $key');
    final int index = subscriptionPlanProvider!.dataList.data!.indexWhere(
        (VendorSubscriptionPlan package) => package.coreKey!.name == key);
    if (index == -1) {
      return null;
    }
    final VendorSubscriptionPlan package =
        subscriptionPlanProvider!.dataList.data!.elementAt(index);
    return package;
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  PsValueHolder? psValueHolder;
  VendorSubscriptionPlanProvider? subscriptionPlanProvider;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);
    return Scaffold(
      appBar: PsAppbarWidget(
        appBarTitle: 'vendor_application_fees'.tr,
      ),
      body: ChangeNotifierProvider<VendorSubscriptionPlanProvider?>(
        lazy: false,
        create: (BuildContext context) {
          subscriptionPlanProvider =
              VendorSubscriptionPlanProvider(context: context);
          subscriptionPlanProvider!.loadDataList(
            requestPathHolder: RequestPathHolder(
              loginUserId: psValueHolder?.loginUserId,
              languageCode: psValueHolder?.languageCode,
            ),
          );
          return subscriptionPlanProvider;
        },
        child: Consumer<VendorSubscriptionPlanProvider>(
          builder: (BuildContext context,
              VendorSubscriptionPlanProvider provider, Widget? child) {
            print(provider.dataLength);
            return Stack(children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'vendor_choose_a_subscription_title'.tr,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Utils.isLightMode(context)
                                ? PsColors.achromatic800
                                : PsColors.achromatic50,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PsDimens.space24, vertical: 20),
                      child: Text(
                        'vendor_subscription_desc'.tr,
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Utils.isLightMode(context)
                                      ? PsColors.achromatic800
                                      : PsColors.achromatic50,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (provider.hasData)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final VendorSubscriptionPlan? subscription =
                              getPackageByIAPKey(_products[index].id);
                          if (subscription == null) {
                            return const SizedBox();
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: PsDimens.space8),
                            child: CustomVendorSubscriptionCard(
                              priceWithCurrency: _products[index].price,
                              onTap: () {
                                amount = _products[index].price;
                                _buyProduct(_products[index]);
                              },
                              vendorSubscriptionPlan: subscription,
                            ),
                          );
                        },
                        itemCount: _products.length,
                      )
                    else
                      const SizedBox(),
                  ],
                ),
              ),
              PSProgressIndicator(provider.dataList.status),
            ]);
          },
        ),
      ),
    );
  }
}
