import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/repository/vendor_search_repository.dart';
import '../../../../../../core/vendor/viewobject/holder/vendor_search_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/vendor_product_relation.dart';

import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../common/ps_app_bar_widget.dart';
import '../../common/ps_textfield_widget_with_icon.dart';

class SearchVendorView extends StatefulWidget {
  const SearchVendorView();

  @override
  State<StatefulWidget> createState() => _SearchVendorViewContainerState();
}

class _SearchVendorViewContainerState extends State<SearchVendorView>
    with SingleTickerProviderStateMixin {
  VendorSearchRepository? repo1;
  late PsValueHolder psValueHolder;
  AnimationController? animationController;
  late AppLocalization langProvider;

  late VendorSearchParameterHolder vendorSearchParameterHolder;

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    repo1 = Provider.of<VendorSearchRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    final TextEditingController searchTextEditingController =
        TextEditingController();
    vendorSearchParameterHolder = VendorSearchParameterHolder();

    return Scaffold(
        appBar: PsAppbarWidget(
          appBarTitle: 'home__bottom_app_bar_search'.tr,
        ),
        body: Column(
          children: <Widget>[
            Container(
                child: PsTextFieldWidgetWithIcon(
                    hintText: 'Search'.tr,
                    textEditingController: searchTextEditingController,
                    clickSearchButton: () {
                      vendorSearchParameterHolder.searchterm =
                          searchTextEditingController.text;
                      vendorSearchParameterHolder.ownerUserId =
                          psValueHolder.loginUserId;
                      vendorSearchParameterHolder.orderBy =
                          PsConst.FILTERING__NAME;
                      vendorSearchParameterHolder.orderType =
                          PsConst.FILTERING__DESC;
                      vendorSearchParameterHolder.status = PsConst.TWO;
                      vendorSearchParameterHolder.productRelation =
                          <VendorProductRelation>[];

                      Navigator.pop(context, vendorSearchParameterHolder);
                      searchTextEditingController.clear();
                    },
                    clickEnterFunction: () {
                      vendorSearchParameterHolder.searchterm =
                          searchTextEditingController.text;
                      vendorSearchParameterHolder.ownerUserId =
                          psValueHolder.loginUserId;
                      vendorSearchParameterHolder.orderBy =
                          PsConst.FILTERING__NAME;
                      vendorSearchParameterHolder.orderType =
                          PsConst.FILTERING__DESC;
                      vendorSearchParameterHolder.status = PsConst.TWO;
                      vendorSearchParameterHolder.productRelation =
                          <VendorProductRelation>[];

                      Navigator.pop(context, vendorSearchParameterHolder);
                      searchTextEditingController.clear();
                    })),
          ],
        ));
  }
}
