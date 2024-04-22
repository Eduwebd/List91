import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_config.dart';
import '../../../../../core/vendor/constant/ps_provider_const.dart';
import '../../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../core/vendor/provider/order_id/order_id_provider.dart';
import '../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../core/vendor/provider/product/related_product_provider.dart';
import '../../../../../core/vendor/repository/add_to_cart_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/billing_address_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/holder/shipping_address_holder.dart';
import '../../../../../core/vendor/viewobject/holder/widget_provider_dyanmic.dart';
import '../../../../custom_ui/item/detail/component/sticky_bottom/sticky_bottom_widget.dart';
import '../../../sort_widget/ps_dynamic_provider.dart';
import '../../../sort_widget/ps_dynamic_widget.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView(
      {required this.productId,
      required this.heroTagImage,
      required this.heroTagTitle});

  final String? productId;
  final String? heroTagImage;
  final String? heroTagTitle;

  @override
  ProductDetailState<ProductDetailView> createState() =>
      ProductDetailState<ProductDetailView>();
}

class ProductDetailState<T extends ProductDetailView>
    extends State<ProductDetailView> with SingleTickerProviderStateMixin {
  RelatedProductProvider? relatedProductProvider;
  PsValueHolder? psValueHolder;
  AnimationController? animationController;
  bool isReadyToShowAppBarIcons = false;
  final ScrollController scrollController = ScrollController();

  AddToCartProvider? addToCartProvider;

  bool isFirstTime = true;
  WidgetProviderDynamic? widgetProviderDynamic = WidgetProviderDynamic(
      providerList: <String>[''], widgetList: <String>['']);

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OrderIdProvider orderIdProvider =
        Provider.of<OrderIdProvider>(context);
    final AddToCartRepository repo = Provider.of<AddToCartRepository>(context);
    if (!isReadyToShowAppBarIcons) {
      Timer(const Duration(milliseconds: 800), () {
        setState(() {
          isReadyToShowAppBarIcons = true;
        });
      });
    }
    psValueHolder = Provider.of<PsValueHolder>(context);
    animationController!.forward();

    if (isFirstTime) {
      final WidgetProviderDynamic widgetprovider =
          Utils.psWidgetToProvider(PsConfig.productDetailsWidgetList);
      widgetProviderDynamic!.widgetList!.addAll(widgetprovider.widgetList!);
      widgetProviderDynamic!.providerList!.addAll(widgetprovider.providerList!);
      widgetProviderDynamic!.widgetList!.add('sizedbox_80');
      widgetProviderDynamic!.providerList!.addAll(<String>[
        PsProviderConst.init_item_detail_provider,
        PsProviderConst.init_user_provider,
        PsProviderConst.init_history_provider,
        PsProviderConst.init_appinfo_provider,
        PsProviderConst.init_mark_soldout_item_provider,
        PsProviderConst.init_touch_count_provider,
        PsProviderConst.init_about_us_provider
      ]);
      //Don't Delete Those init providers adding those are the basic need for this page
      isFirstTime = false;
    }

    widgetProviderDynamic!.providerList =
        widgetProviderDynamic!.providerList!.toSet().toList();
    widgetProviderDynamic!.widgetList =
        widgetProviderDynamic!.widgetList!.toSet().toList();
    return Scaffold(
      body: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<AddToCartProvider>(
                lazy: false,
                create: (BuildContext context) {
                  addToCartProvider = AddToCartProvider(repo: repo);
                  addToCartProvider?.loadData(
                      dataConfig: DataConfiguration(
                          dataSourceType: DataSourceType.SERVER_DIRECT),
                      requestPathHolder: RequestPathHolder(
                          loginUserId: psValueHolder?.loginUserId ?? '',
                          languageCode: psValueHolder?.languageCode ?? ''));
                  return addToCartProvider!;
                }),
            ...psDynamicProvider(context, (Function fn) {},
                productId: widget.productId,
                categoryProvider: (CategoryProvider pro) {},
                providerList: widgetProviderDynamic!.providerList!)
          ],
          child: Consumer2<ItemDetailProvider, AboutUsProvider>(
            builder: (BuildContext context, ItemDetailProvider provider,
                AboutUsProvider aboutUsProvider, Widget? child) {
              if (provider.hasData) {
                /**
                   * UI Section is here 
                   * */
                return Stack(
                  children: <Widget>[
                    PsDynamicWidget(
                      animationController: animationController,
                      scrollController: scrollController,
                      widgetList: widgetProviderDynamic!.widgetList,
                      heroTagTitle: widget.heroTagTitle,
                      isReadyToShowAppBarIcons: isReadyToShowAppBarIcons,
                      itemDetailBackIconOnTap: () {
                        orderIdProvider.count = 1;
                        orderIdProvider.shippingAddressHolder =
                            ShippingAddressHolder();
                        orderIdProvider.billingAddressHolder =
                            BillingAddressHolder();
                        Navigator.pop(context);
                      },
                    ),
                    const CustomStickyBottomWidget(),
                  ],
                );
              } else
                return const SizedBox();
            },
          )),
    );
  }
}
