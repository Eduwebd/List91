import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/order_detail/order_detail_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/order_summary_detail.dart';
import '../../../../config/ps_colors.dart';
import '../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../core/vendor/provider/vendor_info/vendor_info_provider.dart';
import '../../../../core/vendor/repository/product_repository.dart';
import '../../../../core/vendor/repository/vendor_info_repository.dart';
import '../../../../core/vendor/viewobject/item_info.dart';
import '../../../custom_ui/order_detail/component/order_detail_custom_divder.dart';
import '../../../custom_ui/order_detail/component/order_detail_list/order_detail_list.dart';
import '../../../custom_ui/order_detail/component/order_detail_summary.dart';
import '../../common/ps_ui_widget.dart';
import '../component/user_info/widgets/order_id_date_widget.dart';
import '../component/user_info/widgets/user_info_widget.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView(
      {Key? key, required this.orderId, required this.vendorId})
      : super(key: key);

  final String orderId;
  final String vendorId;

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  PsValueHolder? valueHolder;

  bool isConnectedToInternet = false;

  bool isSuccessfullyLoaded = true;

  late AppLocalization langProvider;

  ProductRepository? productRepository;
  OrderDetailProvider? orderDetailProvider;
  VendorInfoProvider? vendorInfoProvider;
  VendorInfoRepository? vendorInfoRepository;

  @override
  Widget build(BuildContext context) {
    productRepository = Provider.of<ProductRepository>(context);
    vendorInfoRepository = Provider.of<VendorInfoRepository>(context);

    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    // ignore: always_specify_types

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
        ),
        title: Text(
          'order_details'.tr,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic900
                  : PsColors.achromatic50,
              fontWeight: FontWeight.w500,
              fontSize: PsDimens.space18),
        ),
      ),
      body: MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<OrderDetailProvider?>(
              lazy: false,
              create: (BuildContext context) {
                orderDetailProvider = OrderDetailProvider(context: context);
                orderDetailProvider?.loadData(
                    dataConfig: DataConfiguration(
                        dataSourceType: DataSourceType.SERVER_DIRECT),
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(valueHolder),
                        languageCode: langProvider.currentLocale.languageCode,
                        orderId: widget.orderId));
                return orderDetailProvider;
              }),
          ChangeNotifierProvider<VendorInfoProvider?>(
              lazy: false,
              create: (BuildContext context) {
                vendorInfoProvider = VendorInfoProvider(
                  repo: vendorInfoRepository,
                );

                vendorInfoProvider?.loadData(
                    requestPathHolder: RequestPathHolder(
                        loginUserId: valueHolder?.loginUserId,
                        vendorId: widget.vendorId));
                return vendorInfoProvider;
              }),
        ],
        child: Consumer<OrderDetailProvider>(
          builder: (BuildContext context,
              OrderDetailProvider orderDetailProvider, Widget? child) {
            final OrderSummaryDetail? orderSummaryDetail =
                orderDetailProvider.orderSummaryModel.data?.orderSummaryDetail;
            return Stack(children: <Widget>[
              if (orderDetailProvider.hasData)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: <Widget>[
                      OrderIdAndDateWidget(
                        date: orderSummaryDetail?.paymentDate,
                        id: orderSummaryDetail?.orderCode,
                      ),
                      UserInfoWidget(
                        title: 'home_search__product_name_hint'.tr,
                        values:
                            '${orderSummaryDetail?.shippingFirstName.toString()} ${orderSummaryDetail?.shippingLastName}',
                      ),
                      const CustomOrderDetailCustomDivider(),
                      UserInfoWidget(
                        title: 'edit_profile__email'.tr,
                        values: orderSummaryDetail?.shippingEmail,
                      ),
                      const CustomOrderDetailCustomDivider(),
                      UserInfoWidget(
                        isPayment: true,
                        title: 'check_out_payment_method'.tr,
                        values: orderSummaryDetail?.paymentMethod,
                        paid: orderSummaryDetail?.paymentStatus,
                      ),
                      const CustomOrderDetailCustomDivider(),
                      UserInfoWidget(
                          title: 'transaction_detail__shipping_address'.tr,
                          values:
                              '${orderSummaryDetail?.shippingFirstName.toString()} ${orderSummaryDetail?.shippingLastName}, (${orderSummaryDetail?.shippingPhoneNo?.split('-').first})${orderSummaryDetail?.shippingPhoneNo?.split('-').last} , ${orderSummaryDetail?.shippingEmail}, ${orderSummaryDetail?.shippingAddress}, ${orderSummaryDetail?.shippingCountry}, ${orderSummaryDetail?.shippingState}, ${orderSummaryDetail?.shippingCity}, ${orderSummaryDetail?.shippingPostalCode}'),
                      const CustomOrderDetailCustomDivider(),

                      UserInfoWidget(
                          title: 'transaction_detail__billing_address'.tr,
                          values:
                              '${orderSummaryDetail?.billingFirstName.toString()} ${orderSummaryDetail?.billingLastName}, (${orderSummaryDetail?.billingPhoneNo?.split('-').first}) ${orderSummaryDetail?.billingPhoneNo?.split('-').last}, ${orderSummaryDetail?.billingEmail}, ${orderSummaryDetail?.billingAddress}, ${orderSummaryDetail?.billingCountry}, ${orderSummaryDetail?.billingState}, ${orderSummaryDetail?.billingCity}, ${orderSummaryDetail?.billingPostalCode}'),
                      const SizedBox(height: PsDimens.space16),

                      /// Order detail Items List
                      CustomOrderDetailList(
                          title: orderSummaryDetail?.vendorName ?? '',
                          itemInfoList:
                              orderSummaryDetail?.itemInfo ?? <ItemInfo>[]),

                      const CustomOrderDetailCustomDivider(),
                      const SizedBox(height: PsDimens.space8),

                      /// Sub Total
                      CustomOrderDetailSummary(
                          title: 'basket_list__sub_total'.tr,
                          value: orderSummaryDetail?.subTotal ?? '\$0.00'),

                      /// Discount
                      CustomOrderDetailSummary(
                        title: 'dashboard__is_discount'.tr,
                        value: orderSummaryDetail?.totalDiscount ?? '\$0.00',
                        isDiscount: true,
                      ),

                      /// Delivery Charges
                      CustomOrderDetailSummary(
                          title: 'delivery_charges'.tr,
                          value: orderSummaryDetail?.deliveryFee ?? '\$0.00'),
                      const CustomOrderDetailCustomDivider(),
                      const SizedBox(height: PsDimens.space6),

                      ///Total
                      Padding(
                        padding: const EdgeInsets.only(bottom: PsDimens.space6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('transaction_detail__total'.tr,
                                style: TextStyle(
                                    color: Utils.isLightMode(context)
                                        ? PsColors.achromatic900
                                        : PsColors.achromatic50,
                                    fontSize: 18)),
                            Text(orderSummaryDetail?.total ?? '\$0.00',
                                style: TextStyle(
                                    color: Utils.isLightMode(context)
                                        ? PsColors.achromatic900
                                        : PsColors.achromatic50,
                                    fontSize: 18)),
                          ],
                        ),
                      ),

                      const SizedBox(height: PsDimens.space6),
                    ],
                  ),
                ),
              PSProgressIndicator(orderDetailProvider.currentStatus)
            ]);
          },
        ),
      ),
    );
  }
}
