import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/db/common/ps_data_source_manager.dart';

import '../../../../config/ps_colors.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/api/common/ps_status.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../core/vendor/repository/add_to_cart_repository.dart';
import '../../../../core/vendor/repository/vendor_user_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../custom_ui/add_to_cart/components/avaliable_vertical_list_view.dart';
import '../../../custom_ui/add_to_cart/components/sold_out_vertical_list_view.dart';
import '../../../custom_ui/add_to_cart/components/widgets/shopping_cart_empty_box.dart';
import '../../../custom_ui/add_to_cart/components/widgets/shopping_cart_order_summary_widget.dart';
import '../../common/ps_button_widget_with_round_corner.dart';
import '../../common/ps_ui_widget.dart';


class AddToCartView extends StatefulWidget {
  const AddToCartView(
      {Key? key, required this.vendorName, required this.vendorId})
      : super(key: key);
  final String vendorName;
  final String vendorId;
  @override
  State<AddToCartView> createState() => _AddToCartViewState();
}

class _AddToCartViewState extends State<AddToCartView> {
  bool _isShowOrderSummary = false;
  VendorUserDetailProvider? vendorUserDetailProvider;
  VendorUserRepository? vendorUserRepository;
  @override
  Widget build(BuildContext context) {
    AddToCartProvider? addToCartProvider;
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final AddToCartRepository repo = Provider.of<AddToCartRepository>(context);
    final VendorUserRepository vendorUserRepository =
        Provider.of<VendorUserRepository>(context);

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<AddToCartProvider?>(
          lazy: false,
          create: (BuildContext context) {
            addToCartProvider = AddToCartProvider(repo: repo);

            addToCartProvider?.loadData(
                dataConfig: DataConfiguration(
                    dataSourceType: DataSourceType.SERVER_DIRECT),
                requestPathHolder: RequestPathHolder(
                    loginUserId: psValueHolder.loginUserId,
                    languageCode: psValueHolder.languageCode));
            return addToCartProvider;
          },
        ),
        ChangeNotifierProvider<VendorUserDetailProvider>(
            lazy: false,
            create: (BuildContext context) {
              vendorUserDetailProvider = VendorUserDetailProvider(
                  repo: vendorUserRepository, psValueHolder: psValueHolder);
              //  vendorUserProvider.getVendorById(psValueHolder!.loginUserId,'13',psValueHolder!.loginUserId!);
              vendorUserDetailProvider!.loadData(
                  requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(psValueHolder),
                vendorId: widget.vendorId,
                ownerUserId: Utils.checkUserLoginId(psValueHolder),
              ));
              return vendorUserDetailProvider!;
            }),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('shopping_cart'.tr),
        ),
        body: Consumer2<AddToCartProvider, VendorUserDetailProvider>(
          builder: (_, AddToCartProvider provider,
              VendorUserDetailProvider vendorUserDetailProvider, __) {
            final List<ShoppingCartItem> availableShoppingCartList =
                <ShoppingCartItem>[];
            final List<ShoppingCartItem> soldOutShoppingCartList =
                <ShoppingCartItem>[];
            final List<ShoppingCartItem> shoppingCartList =
                provider.shoppingCart.data?.items ?? <ShoppingCartItem>[];
            for (ShoppingCartItem item in shoppingCartList) {
              if (item.isSoldOut == '0') {
                availableShoppingCartList.add(item);
              } else if (item.isSoldOut == '1') {
                soldOutShoppingCartList.add(item);
              }
            }

            provider.addAvaliavleShoppingCartList(availableShoppingCartList);
            provider.addSoldOutShoppingCartList(soldOutShoppingCartList);
            bool vendorExpOrSoldOut() {
              return vendorUserDetailProvider
                          .vendorUserDetail.data?.expiredStatus ==
                      PsConst.EXPIRED_NOTI ||
                  (soldOutShoppingCartList.isNotEmpty &&
                      availableShoppingCartList.isEmpty);
            }

            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    if (provider.hasData)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: PsDimens.space10),

                              /// Available List View
                              if (provider.availableShoppingCartList.isNotEmpty)
                                CustomAvailableVerticalListView(
                                    isVedorExpired: vendorUserDetailProvider
                                            .vendorUserDetail
                                            .data
                                            ?.expiredStatus ??
                                        0,
                                    title: widget.vendorName,
                                    availableItemList:
                                        provider.availableShoppingCartList,
                                    vendorId:
                                        provider.shoppingCart.data?.vendorId ??
                                            ''),

                              /// Sold Out List View
                              if (provider.soldOutShoppingCartList.isNotEmpty)
                                CustomSoldOutVerticalListView(
                                  soldOutItemList:
                                      provider.soldOutShoppingCartList,
                                  vendorId:
                                      provider.shoppingCart.data?.vendorId ??
                                          '',
                                  isVedorExpired: vendorUserDetailProvider
                                          .vendorUserDetail
                                          .data
                                          ?.expiredStatus ??
                                      0,
                                )
                            ],
                          ),
                        ),
                      )
                    else if (provider.currentStatus == PsStatus.ERROR)
                      const CustomShoppingCartEmptyBox()
                  ],
                ),
                if (provider.hasData)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          if (_isShowOrderSummary)
                            CustomShoppingCartOrderSummaryWidget(
                              subTotal: vendorExpOrSoldOut()
                                  ? '0'
                                  : provider.shoppingCart.data?.subTotal ?? '',
                              discount: vendorExpOrSoldOut()
                                  ? '0'
                                  : provider.shoppingCart.data?.totalDiscount ??
                                      '',
                              deliveryCharges: vendorExpOrSoldOut()
                                  ? '0'
                                  : provider.shoppingCart.data?.deliveryFee ??
                                      '',
                              currency: provider.shoppingCart.data
                                      ?.vendorCurrencySymbol ??
                                  '',
                            ),
                          Container(
                            width: double.maxFinite,
                            height: 120,
                            padding: const EdgeInsets.all(16),
                            color: Utils.isLightMode(context)
                                ? PsColors.achromatic50
                                : PsColors.achromatic700,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        _isShowOrderSummary =
                                            !_isShowOrderSummary;
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'transaction_detail__total'.tr,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Utils.isLightMode(context)
                                                ? PsColors.text900
                                                : PsColors.text100),
                                      ),
                                      const Spacer(),
                                      if (vendorExpOrSoldOut())
                                        Text(
                                          '${provider.shoppingCart.data?.vendorCurrencySymbol} 0',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Utils.isLightMode(context)
                                                  ? PsColors.text900
                                                  : PsColors.text100),
                                        )
                                      else
                                        Text(
                                          '${provider.shoppingCart.data?.vendorCurrencySymbol}${provider.shoppingCart.data?.total}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Utils.isLightMode(context)
                                                  ? PsColors.text900
                                                  : PsColors.text100),
                                        ),
                                      Icon(
                                          _isShowOrderSummary
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          size: 30,
                                          color: Utils.isLightMode(context)
                                              ? PsColors.text900
                                              : PsColors.text100)
                                    ],
                                  ),
                                ),
                                PSButtonWidgetRoundCorner(
                                  colorData: vendorExpOrSoldOut()
                                      ? Utils.isLightMode(context)
                                          ? PsColors.achromatic100
                                          : PsColors.achromatic600
                                      : PsColors.primary500,
                                  titleText: 'check_out'.tr,
                                  titleTextColor: PsColors.text100,
                                  onPressed: !vendorExpOrSoldOut()
                                      ? () {
                                          Utils.navigateOnUserVerificationView(
                                              context, () {
                                            Navigator.pushNamed(
                                                context, RoutePaths.checkout,
                                                arguments: <String, dynamic>{
                                                  'vendorId': provider
                                                      .shoppingCart
                                                      .data
                                                      ?.vendorId,
                                                  'checkoutItemList': provider
                                                      .availableShoppingCartList,
                                                  'isSingleItemCheckout': false
                                                });
                                          });
                                        }
                                      : null,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                PSProgressIndicator(provider.currentStatus)
              ],
            );
          },
        ),
      ),
    );
  }
}
