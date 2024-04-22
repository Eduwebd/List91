import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/ps_config.dart';
import '../../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../../core/vendor/viewobject/holder/widget_provider_dyanmic.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../common/ps_ui_widget.dart';
import '../../../common/search_bar_view.dart';
import '../../../sort_widget/ps_dynamic_provider.dart';
import '../../../sort_widget/ps_dynamic_widget.dart';

class ProductListWithFilterContainerView extends StatefulWidget {
  const ProductListWithFilterContainerView({
    required this.productParameterHolder,
    required this.appBarTitle,
  });
  final ProductParameterHolder productParameterHolder;
  final String? appBarTitle;

  @override
  _ProductListWithFilterContainerViewState createState() =>
      _ProductListWithFilterContainerViewState();
}

class _ProductListWithFilterContainerViewState
    extends State<ProductListWithFilterContainerView>
    with TickerProviderStateMixin {
  _ProductListWithFilterContainerViewState();

  AnimationController? animationController;
  late TextEditingController searchTextController = TextEditingController();
  late SearchBarView searchBar;
  PsValueHolder? valueHolder;
  late SearchProductProvider _searchProductProvider;

  late AppLocalization langProvider;
  late WidgetProviderDynamic widgetProviderDynamic;
  String? appBarName ;
  bool isGrid = true;

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);

    super.initState();
appBarName = widget.appBarTitle;
    searchBar = SearchBarView(
        inBar: true,
        controller: searchTextController,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print('cleared');
        },
        closeOnSubmit: false,
        onClosed: () {
          widget.productParameterHolder.searchTerm = '';
          _searchProductProvider.loadDataList(reset: true);
        });
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  AppBar buildAppBar(BuildContext context) {
    // appBarName = widget.appBarTitle;
    searchTextController.clear();
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
      ),
      backgroundColor: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
      iconTheme:
          Theme.of(context).iconTheme,
      title: Text(
        (widget.appBarTitle =='home__drawer_menu_discount_item'.tr || widget.appBarTitle =='home__drawer_menu_feature_item'.tr ||
        widget.appBarTitle =='home__drawer_menu_popular_item'.tr || widget.appBarTitle =='dashboard_nearest_product'.tr || 
        widget.appBarTitle =='dashboard_nearest_product'.tr ||widget.appBarTitle =='dashboard_recent_product'.tr )?
         widget.appBarTitle ?? '': appBarName ?? '',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold)
              .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic900 : PsColors.achromatic50)),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, size: 24),
          onPressed: () async {
            final dynamic result = await Navigator.pushNamed(
                context, RoutePaths.serachItemHistoryList,
                arguments: _searchProductProvider.productParameterHolder);

            if (result != null) {
              _searchProductProvider.productParameterHolder = result;
              _searchProductProvider.loadDataList(
                reset: true,
                requestBodyHolder:
                    _searchProductProvider.productParameterHolder,
                requestPathHolder: RequestPathHolder(
                    loginUserId: valueHolder!.loginUserId,
                    languageCode: langProvider.currentLocale.languageCode),
              );
            }
            // searchBar.beginSearch(context);
          },
        ),
        if (isGrid)
          IconButton(
            padding: const EdgeInsets.only(right: PsDimens.space16),
            icon: const Icon(Icons.grid_view, size: 20),
            onPressed: () async {
              setState(() {
                isGrid = false;

              });
            },
          )
        else
          IconButton(
            padding: const EdgeInsets.only(right: PsDimens.space16),
            icon: const Icon(Icons.list, size: 28),
            onPressed: () async {
              setState(() {
                isGrid = true;
              });
            },
          ),
      ],
      elevation: 0,
    );
  }

  void onSubmitted(String value) {
  
    if (!_searchProductProvider.needReset) {
      _searchProductProvider.needReset = true;
    }
    widget.productParameterHolder.searchTerm = value;
    _searchProductProvider.loadDataList(reset: true);
  }

  void resetDataList() {
    widget.productParameterHolder.searchTerm = '';
    _searchProductProvider.loadDataList(reset: true);
  }

  Future<bool> _requestPop() {
    animationController!.reverse().then<dynamic>(
      (void data) {
        if (!mounted) {
          return Future<bool>.value(false);
        }
        Navigator.pop(context, false);
        return Future<bool>.value(true);
      },
    );
    return Future<bool>.value(false);
  }

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context);

    langProvider = Provider.of<AppLocalization>(context);
    widgetProviderDynamic =
        Utils.psWidgetToProvider(PsConfig.productListWithFilterWidgetList);
    print(
        '............................Build UI Again ............................');
    animationController!.forward();
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        _requestPop();
      },
      child: MultiProvider(
        providers: psDynamicProvider(context, (Function f) {},
            categoryProvider: (CategoryProvider pro) {},
            mounted: mounted,
            providerList: widgetProviderDynamic.providerList!,
            searchProductProvider: (SearchProductProvider pro) {
          _searchProductProvider = pro;
        }, productParameterHolder: widget.productParameterHolder),
        child: Consumer<SearchProductProvider>(
          builder: (BuildContext context,SearchProductProvider pro,Widget? child){
            return Scaffold(
            appBar: searchBar.build(context,),
            body: RefreshIndicator(
              onRefresh: () {
              
                return _searchProductProvider.loadDataList(
                  reset: true,
                  requestBodyHolder:
                      _searchProductProvider.productParameterHolder,
                );
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: PsDimens.space4),
                    child: PsDynamicWidget(
                      onSubCategorySelected: (String? str){
                      
                          appBarName = str;
                      },
                      animationController: animationController!,
                      scrollController: scrollController,
                      widgetList: widgetProviderDynamic.widgetList,
                      isGrid: isGrid,
                    ),
                  ),
                  PSProgressIndicator(pro.currentStatus),
                ],
              ),
            ),
          );
          },
        ),
      ),
    );
  }
}
