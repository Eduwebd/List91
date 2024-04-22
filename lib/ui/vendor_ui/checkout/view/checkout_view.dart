import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/order_id/order_id_provider.dart';
import '../../../../../core/vendor/provider/vendor_info/vendor_info_provider.dart';
import '../../../../../core/vendor/provider/vendor_item_bought/vendor_item_bought_provider.dart';
import '../../../../../core/vendor/provider/vendor_paypal_token/vendor_paypal_token_provider.dart';
import '../../../../../core/vendor/repository/order_id_repository.dart';
import '../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../core/vendor/repository/vendor_info_repository.dart';
import '../../../../../core/vendor/repository/vendor_item_bought_repository.dart';
import '../../../../../core/vendor/repository/vendor_paypal_token_repository.dart';
import '../../../../../core/vendor/repository/vendor_user_repository.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../core/vendor/provider/default_billing_and_shipping/default_shipping_billing_provider.dart';
import '../../../../core/vendor/provider/order_id/get_orderId_provider.dart';
import '../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../core/vendor/repository/add_to_cart_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../custom_ui/checkout/component/billing_address/widgets/address_tile_widget.dart';
import '../../../custom_ui/checkout/component/payment/widgets/place_order_button_widget.dart';
import '../../../custom_ui/checkout/item_vertical_list/checkout_avaliable_vertical_list_view.dart';
import '../../../custom_ui/checkout/item_vertical_list/checkout_sold_out_vertical_list_view.dart';
import '../../../custom_ui/checkout/item_vertical_list/widgets/empty_avaliable_shopping_cart.dart';
import '../component/order_summary/order_summary_widget.dart';
import '../component/payment/widgets/payment_role_widget.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView(
      {Key? key,
      required this.vendorId,
      required this.checkoutItemList,
      this.isSingleItemCheckout = false})
      : super(key: key);

  final List<ShoppingCartItem> checkoutItemList;
  final bool isSingleItemCheckout;
  final String vendorId;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  OrderIdRepository? orderIdRepository;

  VendorPaypalTokenRepository? vendorPaypalTokenRepository;

  VendorItemBoughtRepository? vendorItemBoughtRepository;

  VendorPayPalTokenProvider? vendorPayPalTokenProvider;

  VendorItemBoughtProvider? vendorItemBoughtProvider;

  ItemDetailProvider? itemDetailProvider;

  ProductRepository? productRepository;

  VendorUserDetailProvider? vendorUserDetailProvider;
  VendorUserRepository? vendorUserDetailRepository;

  late AddToCartProvider addToCartProvider;

  PsValueHolder? psValueHolder;

  GetOrderIdProvider? getOrderIdProvider;

  DefaultBillingAndShippingProvider? defaultBillingAndShippingProvider;
  VendorInfoProvider? vendorInfoProvider;

  VendorInfoRepository? vendorInfoRepository;

  @override
  Widget build(BuildContext context) {
    orderIdRepository = Provider.of<OrderIdRepository>(context);
    vendorUserDetailRepository = Provider.of<VendorUserRepository>(context);
    vendorInfoRepository = Provider.of<VendorInfoRepository>(context);

    vendorItemBoughtRepository =
        Provider.of<VendorItemBoughtRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    vendorPaypalTokenRepository =
        Provider.of<VendorPaypalTokenRepository>(context);
    productRepository = Provider.of<ProductRepository>(context);

    final AddToCartRepository repo = Provider.of<AddToCartRepository>(context);

    final OrderIdProvider orderIdProvider =
        Provider.of<OrderIdProvider>(context);
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
          title: Text('check_out'.tr,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic900
                      : PsColors.achromatic50,
                  fontWeight: FontWeight.w500,
                  fontSize: PsDimens.space18)),
        ),
        body: MultiProvider(
            providers: <SingleChildWidget>[
              ChangeNotifierProvider<DefaultBillingAndShippingProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    defaultBillingAndShippingProvider =
                        DefaultBillingAndShippingProvider(
                     context: context
                    );

                    defaultBillingAndShippingProvider?.loadData(
                        dataConfig: DataConfiguration(
                            dataSourceType: DataSourceType.SERVER_DIRECT),
                        requestPathHolder: RequestPathHolder(
                            loginUserId: psValueHolder?.loginUserId!,
                            languageCode: psValueHolder?.languageCode));

                    return defaultBillingAndShippingProvider;
                  }),
              ChangeNotifierProvider<GetOrderIdProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    getOrderIdProvider =
                        GetOrderIdProvider(repo: orderIdRepository);
                    return getOrderIdProvider;
                  }),
              ChangeNotifierProvider<VendorPayPalTokenProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    vendorPayPalTokenProvider = VendorPayPalTokenProvider(
                        repo: vendorPaypalTokenRepository);

                    return vendorPayPalTokenProvider;
                  }),
              ChangeNotifierProvider<VendorItemBoughtProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    vendorItemBoughtProvider = VendorItemBoughtProvider(
                        vendorItemBoughtRepository: vendorItemBoughtRepository);

                    return vendorItemBoughtProvider;
                  }),
              ChangeNotifierProvider<ItemDetailProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    itemDetailProvider = ItemDetailProvider(
                        repo: productRepository, psValueHolder: psValueHolder);
                    itemDetailProvider?.loadData(
                        requestPathHolder: RequestPathHolder(
                            loginUserId: psValueHolder?.loginUserId,
                            itemId: widget.checkoutItemList[0].itemId ?? '0',
                            languageCode: psValueHolder?.languageCode));

                    return itemDetailProvider;
                  }),
              ChangeNotifierProvider<VendorInfoProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    vendorInfoProvider = VendorInfoProvider(
                      repo: vendorInfoRepository,
                    );

                    vendorInfoProvider?.loadData(
                        requestPathHolder: RequestPathHolder(
                            loginUserId: psValueHolder?.loginUserId!,
                            vendorId: widget.vendorId));
                    return vendorInfoProvider;
                  }),
              ChangeNotifierProvider<AddToCartProvider>(
                  lazy: false,
                  create: (BuildContext context) {
                    addToCartProvider = AddToCartProvider(repo: repo);

                    addToCartProvider.loadData(
                        dataConfig: DataConfiguration(
                            dataSourceType: DataSourceType.SERVER_DIRECT),
                        requestPathHolder: RequestPathHolder(
                            loginUserId: psValueHolder?.loginUserId,
                            languageCode: psValueHolder?.languageCode));
                    addToCartProvider
                        .addSingleItemCheckoutItem(widget.checkoutItemList[0]);
                    return addToCartProvider;
                  }),
              ChangeNotifierProvider<VendorUserDetailProvider>(
                  lazy: false,
                  create: (BuildContext context) {
                    vendorUserDetailProvider = VendorUserDetailProvider(
                        repo: vendorUserDetailRepository,
                        psValueHolder: psValueHolder);
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
            child: Consumer5<
                    AddToCartProvider,
                    GetOrderIdProvider,
                    VendorInfoProvider,
                    VendorPayPalTokenProvider,
                    DefaultBillingAndShippingProvider>(
                builder: (BuildContext context,
                    AddToCartProvider addToCartProvider,
                    GetOrderIdProvider getOrderIdProvider,
                    VendorInfoProvider vendorInfoProvider,
                    VendorPayPalTokenProvider vendorPayPalTokenProvider,
                    DefaultBillingAndShippingProvider
                        defaultBillingAndShippingProvider,
                    Widget? child) {
              final List<ShoppingCartItem> availableShoppingCartList =
                  <ShoppingCartItem>[];
              final List<ShoppingCartItem> soldOutShoppingCartList =
                  <ShoppingCartItem>[];
              if (widget.isSingleItemCheckout) {
                availableShoppingCartList
                    .add(addToCartProvider.singleItemCheckoutItem);
              } else {
                final List<ShoppingCartItem> shoppingCartList =
                    addToCartProvider.shoppingCart.data?.items ??
                        <ShoppingCartItem>[];
                for (ShoppingCartItem item in shoppingCartList) {
                  if (item.isSoldOut == '0') {
                    availableShoppingCartList.add(item);
                  } else if (item.isSoldOut == '1') {
                    soldOutShoppingCartList.add(item);
                  }
                }

                addToCartProvider
                    .addAvaliavleShoppingCartList(availableShoppingCartList);
                addToCartProvider
                    .addSoldOutShoppingCartList(soldOutShoppingCartList);
              }

              bool vendorExpOrSoldOut() {
                return vendorUserDetailProvider
                            ?.vendorUserDetail.data?.expiredStatus ==
                        PsConst.EXPIRED_NOTI ||
                    (soldOutShoppingCartList.isNotEmpty &&
                        availableShoppingCartList.isEmpty);
              }

              double? originalPrice;
              double? currentPrice;
              String? currency;
              String? subTotal;
              String? discountPrice;
              String? singleItemTotalPrice;
              String? currencySymbol;
              final String? deliveryChargesPrice = double.tryParse(
                      vendorInfoProvider.vendorInfo.data?.vendorDeliverySetting
                                  ?.deliverySetting !=
                              PsConst.ONE
                          ? '0'
                          : vendorInfoProvider.vendorInfo.data
                                  ?.vendorDeliverySetting?.deliveryCharges ??
                              '0')
                  ?.toStringAsFixed(2);

              if (availableShoppingCartList.isNotEmpty) {
                originalPrice = double.parse(
                    availableShoppingCartList[0].originalPrice.toString());
                currentPrice = double.parse(
                    availableShoppingCartList[0].salePrice.toString());

                currency =
                    availableShoppingCartList[0].vendorCurrencySymbol ?? '\$';
                subTotal = (originalPrice *
                        double.parse(
                            availableShoppingCartList[0].quantity.toString()))
                    .toStringAsFixed(2);
                discountPrice = ((originalPrice - currentPrice) *
                        double.parse(
                            availableShoppingCartList[0].quantity.toString()))
                    .toStringAsFixed(2);

                singleItemTotalPrice = ((currentPrice *
                            double.parse(availableShoppingCartList[0]
                                .quantity
                                .toString())) +
                        double.parse(deliveryChargesPrice.toString()))
                    .toStringAsFixed(2);
                currencySymbol =
                    availableShoppingCartList[0].vendorCurrencySymbol;
              }

              final String basketItemTotalPrice =
                  addToCartProvider.shoppingCart.data?.total ?? '0.00';

              final String basketItemCurrencySymbol =
                  addToCartProvider.shoppingCart.data?.vendorCurrencySymbol ??
                      '\$';
              return Stack(children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: PsDimens.space16),
                  child: ListView(
                    children: <Widget>[
                      Text('check_out_deli_info'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                      CustomAddressTileWidget(
                          onTap: () async {
                            if (defaultBillingAndShippingProvider
                                    .defaultBillingAndShipping.data !=
                                null) {
                              final dynamic result =
                                  await Navigator.of(context).pushNamed(
                                RoutePaths.shippingAddressListView,
                              ) as String?;
                              if (result == '2') {
                                await defaultBillingAndShippingProvider
                                    .loadData(
                                        dataConfig: DataConfiguration(
                                            dataSourceType:
                                                DataSourceType.SERVER_DIRECT),
                                        requestPathHolder: RequestPathHolder(
                                            loginUserId:
                                                psValueHolder?.loginUserId!,
                                            languageCode:
                                                psValueHolder?.languageCode));
                              }
                            } else {
                              final dynamic result =
                                  await Navigator.of(context).pushNamed(
                                RoutePaths.shippingAddress,
                              ) as String?;

                              if (result == '1') {
                                await defaultBillingAndShippingProvider
                                    .loadData(
                                        requestPathHolder: RequestPathHolder(
                                            loginUserId:
                                                psValueHolder?.loginUserId!,
                                            languageCode:
                                                psValueHolder?.languageCode));
                              }
                            }
                          },
                          titleAddress: 'shipping_address'.tr,
                          subtitleAddress: defaultBillingAndShippingProvider
                                      .defaultBillingAndShipping.data ==
                                  null
                              ? 'add_shipping_address_details'.tr
                              : orderIdProvider.chooseShippingAddress == null
                                  ? '${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.shippingFirstName} ${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.shippingLastName},(${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.shippingPhoneNo?.split('-').first})${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.shippingPhoneNo?.split('-').last},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.shippingEmail},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.shippingAddress},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.shippingCountry},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.shippingState},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.shippingCity},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.shippingPostalCode}'
                                  : '${orderIdProvider.chooseShippingAddress?.shippingFirstName} ${orderIdProvider.chooseShippingAddress?.shippingLastName},(${orderIdProvider.chooseShippingAddress?.shippingPhoneNo?.split('-').first})${orderIdProvider.chooseShippingAddress?.shippingPhoneNo?.split('-').last},${orderIdProvider.chooseShippingAddress?.shippingEmail},${orderIdProvider.chooseShippingAddress?.shippingAddress},${orderIdProvider.chooseShippingAddress?.shippingCountry},${orderIdProvider.chooseShippingAddress?.shippingState},${orderIdProvider.chooseShippingAddress?.shippingCity},${orderIdProvider.chooseShippingAddress?.shippingPostalCode}'),
                      const Divider(),
                      CustomAddressTileWidget(
                          onTap: () async {
                            if (defaultBillingAndShippingProvider
                                    .defaultBillingAndShipping.data !=
                                null) {
                              final dynamic result =
                                  await Navigator.of(context).pushNamed(
                                RoutePaths.billingAddressListView,
                              ) as String?;
                              if (result == '2') {
                                await defaultBillingAndShippingProvider
                                    .loadData(
                                        dataConfig: DataConfiguration(
                                            dataSourceType:
                                                DataSourceType.SERVER_DIRECT),
                                        requestPathHolder: RequestPathHolder(
                                            loginUserId:
                                                psValueHolder?.loginUserId!,
                                            languageCode:
                                                psValueHolder?.languageCode));
                              }
                            } else {
                              // :
                              final dynamic result =
                                  await Navigator.of(context).pushNamed(
                                RoutePaths.billingAddress,
                              ) as String?;

                              if (result == '1') {
                                await defaultBillingAndShippingProvider
                                    .loadData(
                                        requestPathHolder: RequestPathHolder(
                                            loginUserId:
                                                psValueHolder?.loginUserId!,
                                            languageCode:
                                                psValueHolder?.languageCode));
                              }
                            }
                          },
                          titleAddress: 'billing_address'.tr,
                          subtitleAddress: defaultBillingAndShippingProvider
                                      .defaultBillingAndShipping.data ==
                                  null
                              ? 'add_billing_address_details'.tr
                              : orderIdProvider.chooseBillingAddress == null
                                  ? '${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.billingFirstName} ${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.billingLastName}(${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.billingPhoneNo?.split('-').first})${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.billingPhoneNo?.split('-').last},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.billingEmail},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.billingAddress},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.billingCountry},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.billingState},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.billingCity},${defaultBillingAndShippingProvider.defaultBillingAndShipping.data?.billingPostalCode}'
                                  : '${orderIdProvider.chooseBillingAddress?.billingFirstName} ${orderIdProvider.chooseBillingAddress?.billingLastName},(${orderIdProvider.chooseBillingAddress?.billingPhoneNo?.split('-').first})${orderIdProvider.chooseBillingAddress?.billingPhoneNo?.split('-').last},${orderIdProvider.chooseBillingAddress?.billingEmail},${orderIdProvider.chooseBillingAddress?.billingAddress},${orderIdProvider.chooseBillingAddress?.billingCountry},${orderIdProvider.chooseBillingAddress?.billingState},${orderIdProvider.chooseBillingAddress?.billingCity},${orderIdProvider.chooseBillingAddress?.billingPostalCode}'),
                      Text('check_out_payment_method'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                      if (vendorInfoProvider
                              .vendorInfo.data?.vendorPaypalEnabled ==
                          '1')
                        PaymentRoleWidget(
                            isSelected: vendorInfoProvider.selectedValue == 1,
                            value: 1,
                            groupValue: vendorInfoProvider.selectedValue,
                            onChanged: (int? a) {
                              vendorInfoProvider.updateSelectedValue(a!);
                            },
                            image:
                                Image.asset('assets/images/payment/paypal.png'),
                            paymentName: 'item_promote__paypal'.tr)
                      else
                        const SizedBox(),
                      if (vendorInfoProvider
                              .vendorInfo.data?.vendorStripeEnabled ==
                          '1')
                        PaymentRoleWidget(
                            isSelected: vendorInfoProvider.selectedValue == 2,
                            value: 2,
                            groupValue: vendorInfoProvider.selectedValue,
                            onChanged: (int? a) {
                              vendorInfoProvider.updateSelectedValue(a!);
                            },
                            image:
                                Image.asset('assets/images/payment/stripe.png'),
                            paymentName: 'item_promote__stripe'.tr)
                      else
                        const SizedBox(),
                      if (vendorInfoProvider
                              .vendorInfo.data?.vendorRazorEnabled ==
                          '1')
                        PaymentRoleWidget(
                            value: 3,
                            isSelected: vendorInfoProvider.selectedValue == 3,
                            groupValue: vendorInfoProvider.selectedValue,
                            onChanged: (int? a) {
                              vendorInfoProvider.updateSelectedValue(a!);
                            },
                            image:
                                Image.asset('assets/images/payment/razor.png'),
                            paymentName: 'item_promote__razor'.tr)
                      else
                        const SizedBox(),
                      if (vendorInfoProvider
                              .vendorInfo.data?.vendorPaystackEnabled ==
                          '1')
                        PaymentRoleWidget(
                            value: 4,
                            isSelected: vendorInfoProvider.selectedValue == 4,
                            groupValue: vendorInfoProvider.selectedValue,
                            onChanged: (int? a) {
                              vendorInfoProvider.updateSelectedValue(a!);
                            },
                            image: Image.asset(
                                'assets/images/payment/paystack.png'),
                            paymentName: 'vendor_paystack'.tr)
                      else
                        const SizedBox(),
                      if (vendorInfoProvider.vendorInfo.data
                              ?.vendorDeliverySetting?.deliverySetting ==
                          '1')
                        PaymentRoleWidget(
                            value: 5,
                            isSelected: vendorInfoProvider.selectedValue == 5,
                            groupValue: vendorInfoProvider.selectedValue,
                            onChanged: (int? a) {
                              vendorInfoProvider.updateSelectedValue(a!);
                            },
                            image: Image.asset(
                                'assets/images/payment/cash_on_delivery.png'),
                            paymentName: 'vendor_cash_on_delivery'.tr)
                      else
                        const SizedBox(),
                      const SizedBox(
                        height: PsDimens.space20,
                      ),

                      //=================================

                      /// Available List View
                      if (availableShoppingCartList.isNotEmpty)
                        CustomCheckOutAvailableVerticalListView(
                          isVendorExpired: vendorUserDetailProvider
                                  ?.vendorUserDetail.data?.expiredStatus ??
                              0,
                          title: vendorUserDetailProvider
                                  ?.vendorUserDetail.data?.name ??
                              '',
                          availableItemList: availableShoppingCartList,
                          vendorId: widget.vendorId,
                          isSingleItemCheckout: widget.isSingleItemCheckout,
                        ),

                      ///Empty available shopping cart

                      if (availableShoppingCartList.isEmpty)
                        CustomEmptyAvaliableShoppingCartWidget(
                            isVendorExpired: vendorUserDetailProvider
                                ?.vendorUserDetail.data?.expiredStatus,
                            vendorName: vendorUserDetailProvider
                                    ?.vendorUserDetail.data?.name ??
                                ''),

                      /// Sold Out List View
                      if (soldOutShoppingCartList.isNotEmpty)
                        CustomCheckOutSoldOutVerticalListView(
                          isVendorExpired: vendorUserDetailProvider
                                  ?.vendorUserDetail.data?.expiredStatus ??
                              0,
                          soldOutItemList: soldOutShoppingCartList,
                          vendorId: widget.vendorId,
                          isSingleItemCheckout: widget.isSingleItemCheckout,
                        ),

                      OrderSummaryWidget(
                        currency: (widget.isSingleItemCheckout)
                            ? currency ?? '\$'
                            : addToCartProvider
                                    .shoppingCart.data?.vendorCurrencySymbol ??
                                '\$',
                        deliveryCharges: vendorExpOrSoldOut() ||
                                vendorInfoProvider
                                        .vendorInfo
                                        .data
                                        ?.vendorDeliverySetting
                                        ?.deliverySetting !=
                                    PsConst.ONE
                            ? '0'
                            : (widget.isSingleItemCheckout)
                                ? deliveryChargesPrice.toString()
                                : addToCartProvider
                                        .shoppingCart.data?.deliveryFee ??
                                    '0.00',
                        discount: vendorExpOrSoldOut()
                            ? '0'
                            : (widget.isSingleItemCheckout)
                                ? discountPrice ?? '0.00'
                                : addToCartProvider
                                        .shoppingCart.data?.totalDiscount ??
                                    '0.00',
                        subTotal: vendorExpOrSoldOut()
                            ? '0'
                            : (widget.isSingleItemCheckout)
                                ? subTotal ?? '0.00'
                                : addToCartProvider
                                        .shoppingCart.data?.subTotal ??
                                    '0.00',
                      ),

                      // =================================

                      const SizedBox(height: 80)
                    ],
                  ),
                ),
                CustomPlaceOrderButtonWidget(
                    titleTextColor: vendorExpOrSoldOut()
                        ? PsColors.achromatic400
                        : Utils.isLightMode(context)
                            ? PsColors.achromatic50
                            : PsColors.achromatic50,
                    color: vendorExpOrSoldOut()
                        ? Utils.isLightMode(context)
                            ? PsColors.achromatic100
                            : PsColors.achromatic600
                        : PsColors.primary500,
                    vendorExpOrSoldOut: vendorExpOrSoldOut(),
                    shoppingCartList: availableShoppingCartList,
                    defaultShippingAndBilling: defaultBillingAndShippingProvider
                            .defaultBillingAndShipping.data ==
                        null,
                    isSingleItemCheckout: widget.isSingleItemCheckout,
                    totalPrice: vendorExpOrSoldOut()
                        ? '0'
                        : widget.isSingleItemCheckout
                            ? singleItemTotalPrice
                            : basketItemTotalPrice,
                    currencySymbol: widget.isSingleItemCheckout
                        ? currencySymbol
                        : basketItemCurrencySymbol,
                    vendorId: widget.isSingleItemCheckout
                        ? itemDetailProvider?.itemDetail.data?.vendorId
                        : addToCartProvider.shoppingCart.data?.vendorId,
                    vendorCurrencyShortForm: widget.isSingleItemCheckout
                        ? itemDetailProvider
                                ?.product.itemCurrency?.currencyShortForm ??
                            'USD'
                        : addToCartProvider
                            .shoppingCart.data?.vendorCurrencyShortForm),
              ]);
            })));
  }
}
