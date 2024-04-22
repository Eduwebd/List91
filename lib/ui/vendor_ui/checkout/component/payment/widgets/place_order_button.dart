import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../../../core/vendor/provider/default_billing_and_shipping/default_shipping_billing_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/order_id/get_orderId_provider.dart';
import '../../../../../../core/vendor/provider/order_id/order_id_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/provider/vendor_info/vendor_info_provider.dart';
import '../../../../../../core/vendor/provider/vendor_item_bought/vendor_item_bought_provider.dart';
import '../../../../../../core/vendor/provider/vendor_paypal_token/vendor_paypal_token_provider.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/order_and_billing_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/payment_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/vendor_item_bought_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/item_info.dart';
import '../../../../../../core/vendor/viewobject/order_id.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../core/vendor/viewobject/product_relation.dart';
import '../../../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../../../../core/vendor/viewobject/vendor_item_bought_status.dart';
import '../../../../../../core/vendor/viewobject/vendor_paypal_token.dart';
import '../../../../../../ui/vendor_ui/common/dialog/error_dialog.dart';
import '../../../../common/dialog/check_item_dialog.dart';
import '../../../../common/dialog/warning_dialog_view.dart';
import '../../order_place/widgets/order_place_button.dart';

class PlaceOrderButton extends StatefulWidget {
  const PlaceOrderButton({
    Key? key,
    required this.shoppingCartList,
    required this.defaultShippingAndBilling,
    required this.isSingleItemCheckout,
    required this.totalPrice,
    required this.currencySymbol,
    required this.vendorCurrencyShortForm,
    required this.vendorId,
    required this.vendorExpOrSoldOut,
    required this.color,
    this.titleTextColor
  }) : super(key: key);

  final List<ShoppingCartItem> shoppingCartList;
  final bool defaultShippingAndBilling;
  final bool isSingleItemCheckout;
  final String? totalPrice;
  final String? currencySymbol;
  final String? vendorCurrencyShortForm;
  final String? vendorId;
  final bool vendorExpOrSoldOut;
  final Color color;
  final Color? titleTextColor;
  @override
  State<PlaceOrderButton> createState() => _PlaceOrderButtonState();
}

class _PlaceOrderButtonState extends State<PlaceOrderButton> {
  late AddToCartProvider addToCartProvider;

  VendorInfoProvider? vendorInfoProvider;

  OrderIdProvider? orderIdProvider;

  DefaultBillingAndShippingProvider? defaultBillingAndShippingProvider;

  ItemDetailProvider? itemDetailProvider;

  GetOrderIdProvider? getOrderIdProvider;

  VendorPayPalTokenProvider? vendorPayPalTokenProvider;

  UserProvider? userProvider;

  VendorItemBoughtProvider? vendorItemBoughtProvider;

  PsValueHolder? psValueHolder;
  UserRepository? userRepository;
  late String isSingleCheckout;

  @override
  Widget build(BuildContext context) {
    addToCartProvider = Provider.of<AddToCartProvider>(context);
    vendorInfoProvider = Provider.of<VendorInfoProvider>(context);
    getOrderIdProvider = Provider.of<GetOrderIdProvider>(context);
    orderIdProvider = Provider.of<OrderIdProvider>(context);
    itemDetailProvider = Provider.of<ItemDetailProvider>(context);
    vendorPayPalTokenProvider = Provider.of<VendorPayPalTokenProvider>(context);
    vendorItemBoughtProvider = Provider.of<VendorItemBoughtProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    defaultBillingAndShippingProvider =
        Provider.of<DefaultBillingAndShippingProvider>(context);
    userRepository = Provider.of<UserRepository>(context);

    isSingleCheckout = widget.isSingleItemCheckout ? '1' : '0';

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<UserProvider?>(
          lazy: false,
          create: (BuildContext context) {
            userProvider = UserProvider(
                repo: userRepository, psValueHolder: psValueHolder);

            userProvider?.getUser(psValueHolder?.loginUserId,
                psValueHolder?.languageCode ?? 'en');

            return userProvider;
          },
        ),
      ],
      child: OrderPlaceButtonWidget(
        titleTextColor: widget.titleTextColor,
          color: widget.color,
          onPressed: !widget.vendorExpOrSoldOut
              ? () async {
                  int itemQuantity = 0;

                  /// Payment need
                  if (vendorInfoProvider?.selectedValue == 0) {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return WarningDialog(
                            message: 'check_out_need_payment_method'.tr,
                          );
                        });
                  }

                  /// Shipping need
                  else if (widget.defaultShippingAndBilling == true) {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return WarningDialog(
                              message: 'shipping_need_address'.tr);
                        });
                  } else {
                    PsProgressDialog.showDialog(context);

                    final List<ItemInfo> itemInfoList = <ItemInfo>[];
                    bool isNotSoldOut = false;

                    for (ShoppingCartItem item in widget.shoppingCartList) {
                      final PsResource<Product> product =
                          await itemDetailProvider!.onlyCheckItemBought(
                              requestPathHolder: RequestPathHolder(
                        loginUserId: psValueHolder?.loginUserId,
                        itemId: item.itemId,
                        languageCode: psValueHolder?.languageCode ?? 'en',
                      ));

                      /// Item Quantity
                        product.data?.productRelation
                            ?.forEach((ProductRelation element) {
                          if (element.coreKeyId == 'ps-itm00046') {
                            itemQuantity = int.parse(element.value.toString());
                          }
                        });

                      if (product.data!.isSoldOutItem) {
                        PsProgressDialog.dismissDialog();
                        isNotSoldOut = false;

                        showDialog<dynamic>(
                            context: context,
                            builder: (BuildContext context) {
                              return CheckOutDialog(
                                title: 'dashboard__sold_out'.tr,
                                message: 'check_out_sold_out_message'.tr,
                              );
                            });
                        break;
                      } else if (item.quantity != '0' &&
                          int.parse(item.quantity ?? '0') > itemQuantity) {
                        PsProgressDialog.dismissDialog();
                        isNotSoldOut = false;
                        showDialog<dynamic>(
                            context: context,
                            builder: (BuildContext context) {
                              return CheckOutDialog(
                                title: 'check_out_limt_item'.tr,
                                message: 'check_out_limit_item_message'.tr,
                              );
                            });
                        break;
                      } else {
                        PsProgressDialog.dismissDialog();
                        isNotSoldOut = true;
                        final ItemInfo itemInfo = ItemInfo(
                            itemId: item.itemId,
                            itemName: item.itemName,
                            quantity: item.quantity,
                            originalPrice: item.originalPrice,
                            salePrice: item.salePrice,
                            subTotal: item.subTotal,
                            discountPrice: item.discountPrice);

                        itemInfoList.add(itemInfo);
                      }
                    }
                    if (isNotSoldOut) {
                      _continueCheckout(
                          itemInfoList, widget.totalPrice ?? '0.00');
                    }
                  }
                }
              : null,
          totalPrice: '${widget.currencySymbol} ${widget.totalPrice}'),
    );
  }

  Future<void> _continueCheckout(
      List<ItemInfo> itemInfo, String totalPrice) async {
    final OrderAndBillingParameterHolder orderAndBillingParameterHolder = OrderAndBillingParameterHolder(
        vendorId: widget.vendorId,
        billingAddress: orderIdProvider?.chooseBillingAddress == null
            ? defaultBillingAndShippingProvider
                ?.defaultBillingAndShipping.data?.billingAddress
            : orderIdProvider?.chooseBillingAddress?.billingAddress,
        shippingAddress: orderIdProvider?.chooseShippingAddress == null
            ? defaultBillingAndShippingProvider
                ?.defaultBillingAndShipping.data?.shippingAddress
            : orderIdProvider?.chooseShippingAddress?.shippingAddress,
        billingCity: orderIdProvider?.chooseBillingAddress == null
            ? defaultBillingAndShippingProvider
                ?.defaultBillingAndShipping.data?.billingCity
            : orderIdProvider?.chooseBillingAddress?.billingCity,
        billingCountry: orderIdProvider?.chooseBillingAddress == null
            ? defaultBillingAndShippingProvider
                ?.defaultBillingAndShipping.data?.billingCountry
            : orderIdProvider?.chooseBillingAddress?.billingCountry,
        billingEmail: orderIdProvider?.chooseBillingAddress == null
            ? defaultBillingAndShippingProvider
                ?.defaultBillingAndShipping.data?.billingEmail
            : orderIdProvider?.chooseBillingAddress?.billingEmail,
        billingFirstName: orderIdProvider?.chooseBillingAddress == null
            ? defaultBillingAndShippingProvider
                ?.defaultBillingAndShipping.data?.billingFirstName
            : orderIdProvider?.chooseBillingAddress?.billingFirstName,
        billingLastName: orderIdProvider?.chooseBillingAddress == null
            ? defaultBillingAndShippingProvider
                ?.defaultBillingAndShipping.data?.billingLastName
            : orderIdProvider?.chooseBillingAddress?.billingLastName,
        billingPhoneNo: orderIdProvider?.chooseBillingAddress == null
            ? defaultBillingAndShippingProvider
                ?.defaultBillingAndShipping.data?.billingPhoneNo
            : orderIdProvider?.chooseBillingAddress?.billingPhoneNo,
        billingPostalCode: orderIdProvider?.chooseBillingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.billingPostalCode : orderIdProvider?.chooseBillingAddress?.billingPostalCode,
        billingState: orderIdProvider?.chooseBillingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.billingState : orderIdProvider?.chooseBillingAddress?.billingState,
        isSaveBillingInfoForNextTime: orderIdProvider?.chooseBillingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.isSaveBillingInfoForNextTime : orderIdProvider?.chooseBillingAddress?.isSaveBillingInfoForNextTime,
        isSaveShippingInfoForNextTime: orderIdProvider?.chooseShippingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.isSaveShippingInfoForNextTime : orderIdProvider?.chooseShippingAddress?.isSaveShippingInfoForNextTime,
        shippingCity: orderIdProvider?.chooseShippingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.shippingCity : orderIdProvider?.chooseShippingAddress?.shippingCity,
        shippingCountry: orderIdProvider?.chooseShippingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.shippingCountry : orderIdProvider?.chooseShippingAddress?.shippingCountry,
        shippingEmail: orderIdProvider?.chooseShippingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.shippingEmail : orderIdProvider?.chooseShippingAddress?.shippingEmail,
        shippingFirstName: orderIdProvider?.chooseShippingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.shippingFirstName : orderIdProvider?.chooseShippingAddress?.shippingFirstName,
        shippingLastName: orderIdProvider?.chooseShippingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.shippingLastName : orderIdProvider?.chooseShippingAddress?.shippingLastName,
        shippingPhoneNo: orderIdProvider?.chooseShippingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.shippingPhoneNo : orderIdProvider?.chooseShippingAddress?.shippingPhoneNo,
        shippingPostalCode: orderIdProvider?.chooseShippingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.shippingPostalCode : orderIdProvider?.chooseShippingAddress?.shippingPostalCode,
        shippingState: orderIdProvider?.chooseShippingAddress == null ? defaultBillingAndShippingProvider?.defaultBillingAndShipping.data?.shippingState : orderIdProvider?.chooseShippingAddress?.shippingState,
        totalPrice: totalPrice,
        itemInfo: itemInfo);

    final PsResource<OrderId> data = await getOrderIdProvider?.postData(
      requestBodyHolder: orderAndBillingParameterHolder,
      requestPathHolder: RequestPathHolder(
          loginUserId: psValueHolder!.loginUserId,
          languageCode: psValueHolder!.languageCode,
          headerToken: psValueHolder!.headerToken),
    );
    print('orderid=>${data.data?.orderId}');
    if (data.data?.orderId != null && vendorInfoProvider?.selectedValue == 1) {
      await payWithPaypal(
          context,
          vendorPayPalTokenProvider,
          psValueHolder,
          widget.vendorId,
          vendorInfoProvider?.vendorInfo.data?.vendorCurrencyId,
          totalPrice,
          userProvider,
          data.data!.orderId,
          vendorItemBoughtProvider,
          itemDetailProvider);
    } else if (data.data?.orderId != null &&
        vendorInfoProvider?.selectedValue == 2) {
      PsProgressDialog.dismissDialog();

      Stripe.publishableKey = vendorInfoProvider
                  ?.vendorInfo.data?.vendorStripePublishableKey ?? '';

      Navigator.of(context).pushNamed(RoutePaths.vendorCreditCard,
          arguments: PaymentHolder(
              currencyId: vendorInfoProvider?.vendorInfo.data?.vendorCurrencyId,
              vendorItemBoughtProvider: vendorItemBoughtProvider,
              orderId: data.data?.orderId,
              paymentAmount: totalPrice,
              userId: psValueHolder!.loginUserId,
              vendorId: widget.vendorId,
              paymentStripeKey: vendorInfoProvider
                  ?.vendorInfo.data?.vendorStripePublishableKey,
                  isSingleCheckout: isSingleCheckout));
    } else if (data.data?.orderId != null &&
        vendorInfoProvider?.selectedValue == 3) {
      PsProgressDialog.dismissDialog();

      await payWithRaZor(
          context,
          vendorInfoProvider?.vendorInfo.data?.vendorCurrencyId,
          widget.vendorId,
          data.data?.orderId,
          totalPrice,
          vendorItemBoughtProvider,
          userProvider,
          psValueHolder,
          itemDetailProvider,
          vendorInfoProvider);
    } else if (data.data?.orderId != null &&
        vendorInfoProvider?.selectedValue == 4) {
      PsProgressDialog.dismissDialog();

      Navigator.of(context).pushNamed(RoutePaths.vendorPayStack,
          arguments: PaymentHolder(
              currencyId: vendorInfoProvider?.vendorInfo.data?.vendorCurrencyId,
              vendorItemBoughtProvider: vendorItemBoughtProvider,
              orderId: data.data?.orderId,
              paymentAmount: totalPrice,
              userId: psValueHolder!.loginUserId,
              vendorId: widget.vendorId,
              paymentStripeKey:
                  vendorInfoProvider?.vendorInfo.data?.vendorPaystackKey,
              userProvider: userProvider,
              itemDetailProvider: itemDetailProvider,
              isSingleCheckout: isSingleCheckout));
    } else if (data.data?.orderId != null &&
        vendorInfoProvider?.selectedValue == 5) {
      PsProgressDialog.dismissDialog();

      await cashOnDelivery(
        context,
        psValueHolder,
        widget.vendorId,
        vendorInfoProvider?.vendorInfo.data?.vendorCurrencyId,
        totalPrice,
        data.data?.orderId,
        vendorItemBoughtProvider,
      );
    }
  }

  Future<void> payWithPaypal(
      BuildContext context,
      VendorPayPalTokenProvider? vendorPayPalTokenProvider,
      PsValueHolder? psValueHolder,
      String? vendorId,
      String? itemCurrencyId,
      String? totalPrice,
      UserProvider? userProvider,
      String? orderId,
      VendorItemBoughtProvider? vendorItemBoughtProvider,
      ItemDetailProvider? itemDetailProvider) async {
    final PsResource<VendorPaypalToken>? tokenResource =
        await vendorPayPalTokenProvider?.loadToken(
            psValueHolder!.loginUserId!, vendorId, psValueHolder.headerToken!);
    final String? message = tokenResource?.data?.message;

    PsProgressDialog.dismissDialog();

    final BraintreeDropInRequest request = BraintreeDropInRequest(
      clientToken: message,
      collectDeviceData: true,
      googlePaymentRequest: BraintreeGooglePaymentRequest(
        totalPrice: totalPrice ?? '',
        currencyCode: widget.vendorCurrencyShortForm ?? '',
        billingAddressRequired: false,
      ),
      paypalRequest: BraintreePayPalRequest(
        amount: totalPrice,
        displayName: userProvider?.user.data?.name,
      ),
    );
    final BraintreeDropInResult? result = await BraintreeDropIn.start(request);
    if (result != null) {
      print('Nonce: ${result.paymentMethodNonce.nonce}');
    } else {
      print('Selection was canceled.');
    }
    PsProgressDialog.showDialog(context);
    final VendorItemBoughtParameterHolder vendorItemBoughtParameterHolder =
        VendorItemBoughtParameterHolder(
            currencyId: itemCurrencyId,
            isPaystack: null,
            orderId: orderId,
            paymentAmount: totalPrice,
            paymentMethod: PsConst.PAYMENT_PAYPAL_METHOD,
            paymentMethodNonce: result!.paymentMethodNonce.nonce,
            razorId: '',
            userId: psValueHolder?.loginUserId,
            vendorId: vendorId,
            isSingleCheckout: isSingleCheckout);

    final PsResource<VendorItemBoughtApiStatus>? paidHistoryData =
        await vendorItemBoughtProvider?.vendorItemBought(
      requestBodyHolder: vendorItemBoughtParameterHolder,
      requestPathHolder: RequestPathHolder(
          loginUserId: Utils.checkUserLoginId(psValueHolder),
          headerToken: psValueHolder?.headerToken,
          languageCode: psValueHolder?.languageCode ?? 'en'),
    );

    PsProgressDialog.dismissDialog();

    if (paidHistoryData?.data?.status == 'success') {
      Navigator.of(context).pushReplacementNamed(RoutePaths.orderSuccessful,
          arguments: <String, dynamic>{
            'orderId': orderId,
            'vendorId': vendorId
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return CheckOutDialog(
              title: 'checkout__payment_fail'.tr,
              message: 'check_out_payment_fail_message'.tr,
            );
          });
    }
  }

  Future<void> cashOnDelivery(
      BuildContext context,
      PsValueHolder? psValueHolder,
      String? vendorId,
      String? itemCurrencyId,
      String? totalPrice,
      String? orderId,
      VendorItemBoughtProvider? vendorItemBoughtProvider) async {
    final VendorItemBoughtParameterHolder vendorItemBoughtParameterHolder =
        VendorItemBoughtParameterHolder(
            currencyId: itemCurrencyId,
            isPaystack: '',
            orderId: orderId,
            paymentAmount: totalPrice,
            paymentMethod: PsConst.CASH_ON_DELIVERY_METHOD,
            paymentMethodNonce: '',
            razorId: '',
            userId: psValueHolder?.loginUserId,
            vendorId: vendorId,
            isSingleCheckout: isSingleCheckout);

    await PsProgressDialog.showDialog(context);

    final PsResource<VendorItemBoughtApiStatus>? vendorItemBoughtData =
        await vendorItemBoughtProvider?.vendorItemBought(
            requestBodyHolder: vendorItemBoughtParameterHolder,
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(psValueHolder),
                headerToken: psValueHolder?.headerToken,
                languageCode: psValueHolder?.languageCode ?? 'en'));

    PsProgressDialog.dismissDialog();

    if (vendorItemBoughtData?.data?.status == 'success') {
      Navigator.of(context).pushReplacementNamed(RoutePaths.orderSuccessful,
          arguments: <String, dynamic>{
            'orderId': orderId,
            'vendorId': vendorId
          });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return CheckOutDialog(
              title: 'checkout__payment_fail'.tr,
              message: 'check_out_payment_fail_message'.tr,
            );
          });
      PsProgressDialog.dismissDialog();
    }
  }

  Future<void> payWithRaZor(
      BuildContext context,
      String? itemCurrencyId,
      String? vendorId,
      String? orderId,
      String? totalPrice,
      VendorItemBoughtProvider? vendorItemBoughtProvider,
      UserProvider? userProvider,
      PsValueHolder? psValueHolder,
      ItemDetailProvider? itemDetailProvider,
      VendorInfoProvider? vendorInfoProvider) async {
    Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
      final VendorItemBoughtParameterHolder vendorItemBoughtParameterHolder =
          VendorItemBoughtParameterHolder(
              currencyId: itemCurrencyId,
              isPaystack: null,
              orderId: orderId,
              paymentAmount: totalPrice,
              paymentMethod: PsConst.PAYMENT_RAZOR_METHOD,
              paymentMethodNonce: '',
              razorId: '',
              userId: psValueHolder?.loginUserId,
              vendorId: vendorId,
              isSingleCheckout: isSingleCheckout);

      await PsProgressDialog.showDialog(context);

      final PsResource<VendorItemBoughtApiStatus>? paidHistoryData =
          await vendorItemBoughtProvider?.vendorItemBought(
              requestBodyHolder: vendorItemBoughtParameterHolder,
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder),
                  headerToken: psValueHolder?.headerToken,
                  languageCode: psValueHolder?.languageCode ?? 'en'));

      PsProgressDialog.dismissDialog();

      if (paidHistoryData?.data?.status == 'success') {
        Navigator.of(context).pushReplacementNamed(RoutePaths.orderSuccessful,
            arguments: <String, dynamic>{
              'orderId': orderId,
              'vendorId': vendorId
            });
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return CheckOutDialog(
                title: 'checkout__payment_fail'.tr,
                message: 'check_out_payment_fail_message'.tr,
              );
            });
        PsProgressDialog.dismissDialog();
      }
    }

    void _handlePaymentError(PaymentFailureResponse response) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'checkout__payment_fail'.tr,
            );
          });
    }

    void _handleExternalWallet(ExternalWalletResponse response) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'checkout__payment_not_supported'.tr,
            );
          });
    }

    // ignore: unnecessary_null_comparison
    if (vendorItemBoughtProvider != null) {
      final Razorpay _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

      final Map<String, dynamic> options = <String, dynamic>{
        'key': '${vendorInfoProvider?.vendorInfo.data?.vendorRazorKey}',
        'amount': num.parse('$totalPrice') * 100,
        'name': '${userProvider!.user.data!.name}',
        'currency': '${widget.vendorCurrencyShortForm}',
        'description': '',
        'prefill': <String, String>{
          'contact': '${userProvider.user.data!.userPhone}',
          'email': '${userProvider.user.data!.userEmail}'
        }
      };

      if (await Utils.checkInternetConnectivity()) {
        _razorpay.open(options);
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'error_dialog__no_internet'.tr,
              );
            });
      }
    }
  }
}
