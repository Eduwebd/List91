import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/all_billing_address/all_billing_address_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/order_id/order_id_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/checkout/component/billing_address_list/widgets/billing_address_box.dart';
import '../../../common/ps_button_widget_with_round_corner.dart';
import '../../../common/ps_ui_widget.dart';

class BillingAddressListView extends StatefulWidget {
  const BillingAddressListView({
    Key? key,
  }) : super(key: key);

  @override
  State<BillingAddressListView> createState() => _BillingAddressListViewState();
}

class _BillingAddressListViewState extends State<BillingAddressListView> {

  PsValueHolder? valueHolder;

  late AppLocalization langProvider;

  AllBillingAddressProvider? allBillingAddressProvider;
  OrderIdProvider? orderIdProvider;
  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    orderIdProvider = Provider.of(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          Navigator.pop(context, '2');
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('billing_address'.tr,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic900
                        : PsColors.achromatic50,
                    fontWeight: FontWeight.w500,
                    fontSize: PsDimens.space18)),
          ),
          body: MultiProvider(
            providers: <SingleChildWidget>[
              ChangeNotifierProvider<AllBillingAddressProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    allBillingAddressProvider =
                        AllBillingAddressProvider(context: context);
                    allBillingAddressProvider?.loadDataList(
                        requestPathHolder: RequestPathHolder(
                      loginUserId: Utils.checkUserLoginId(valueHolder),
                      languageCode: langProvider.currentLocale.languageCode,
                    ));
                    return allBillingAddressProvider;
                  }),
            ],
            child: Consumer<AllBillingAddressProvider>(builder:
                (BuildContext context, AllBillingAddressProvider value,
                    Widget? child) {
              return Stack(children: <Widget>[
                if (value.hasData)
                  ListView.builder(
                      itemCount: value.allBillingAddress.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomBillingAddressBox(
                          shippingDefault: value.allBillingAddress.data?[index]
                                  .isSaveShippingInfoForNextTime ==
                              '1',
                          billingDefault: value.allBillingAddress.data?[index]
                                  .isSaveBillingInfoForNextTime ==
                              '1',
                          onPressed: () async {
                            final dynamic result = await Navigator.of(context)
                                .pushNamed(RoutePaths.editBillingAddress,
                                    arguments: value.allBillingAddress
                                        .data?[index]) as String?;
                            if (result == '0') {
                              await allBillingAddressProvider?.loadDataList(
                                  requestPathHolder: RequestPathHolder(
                                loginUserId:
                                    Utils.checkUserLoginId(valueHolder),
                                languageCode:
                                    langProvider.currentLocale.languageCode,
                              ));
                            }
                          },
                          groupValue: int.tryParse(orderIdProvider
                                  ?.chooseBillingAddress?.id
                                  .toString() ??
                              '${value.allBillingAddress.data?[0].id}'),
                          billingAddressList:
                              value.allBillingAddress.data?[index],
                          values: int.parse(allBillingAddressProvider
                                  ?.allBillingAddress.data?[index].id
                                  .toString() ??
                              ''),
                          onChanged: (int? p) {
                            value.values = p;
                            orderIdProvider?.chooseBillingAddress =
                                allBillingAddressProvider
                                    ?.allBillingAddress.data?[index];
                          },
                        );
                      }),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: PsDimens.space16,
                          vertical: PsDimens.space6),
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: <Widget>[
                          PSButtonWidgetRoundCorner(
                            titleTextColor: PsColors.achromatic50,
                            onPressed: () async {
                              final dynamic result =
                                  await Navigator.of(context).pushNamed(
                                RoutePaths.billingAddress,
                              ) as String?;

                              if (result == '1') {
                                await allBillingAddressProvider?.loadDataList(
                                    requestPathHolder: RequestPathHolder(
                                  loginUserId:
                                      Utils.checkUserLoginId(valueHolder),
                                  languageCode:
                                      langProvider.currentLocale.languageCode,
                                ));
                              }
                            },
                            titleText: 'user_add_new_address'.tr,
                          ),
                          PSProgressIndicator(value.currentStatus),
                        ],
                      )),
                )
              ]);
            }),
          )),
    );
  }
}
