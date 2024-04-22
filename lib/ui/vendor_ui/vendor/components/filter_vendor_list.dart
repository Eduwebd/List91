import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/vendor/search_vendor_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../custom_ui/category/component/menu_vertical/widgets/vertical_list/category_sorting_empty_data_box.dart';
import '../../../custom_ui/user/profile/component/my_vendor/widget/my_vendor_list_grid_item.dart';
import '../../../custom_ui/user/profile/component/my_vendor/widget/my_vendor_list_item.dart';

class FilterVendorList extends StatelessWidget {
  const FilterVendorList(
      {required this.animationController,
      required this.controller,
      required this.isGrid});

  final AnimationController animationController;
  final ScrollController controller;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return Consumer<VendorSearchProvider>(builder:
        (BuildContext context, VendorSearchProvider provider, Widget? child) {
      print('Current Status: ${provider.currentStatus}');
      print('Data Count for serach: ${provider.vendorList.data?.length ?? 0}');
      final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
      final int count = isLoading ? 5 : provider.dataLength;

      if (isGrid)
        return (provider.hasData ||
                provider.currentStatus == PsStatus.BLOCK_LOADING)
            ?
            // Flexible(
            //   child:
            SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220, childAspectRatio: 0.95),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return CustomMyVendorListItem(
                      animationController: animationController,
                      animation: curveAnimation(animationController,
                          count: count, index: index),
                      vendorUser: isLoading
                          ? VendorUser()
                          : provider.getListIndexOf(index),
                      isLoading: isLoading,
                    );
                  },
                  childCount: count,
                ),
              )
            : CustomCategorySortingEmptyBox();
      else
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return CustomMyVendorListGridItem(
                animationController: animationController,
                animation: curveAnimation(animationController,
                    count: count, index: index),
                vendorUser:
                    isLoading ? VendorUser() : provider.getListIndexOf(index),
                isLoading: isLoading,
              );
            },
            childCount: count,
          ),
        );
    });
  }
}
