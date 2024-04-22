import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/product/related_product_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../custom_ui/item/list_item/product_vertical_list_item.dart';

class RelatedProductList extends StatelessWidget {
  const RelatedProductList({required this.animationController});
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final RelatedProductProvider provider =
        Provider.of<RelatedProductProvider>(context);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count =
        isLoading ? valueHolder.loadingShimmerItemCount! : provider.dataList.data?.toSet().toList().length ?? 0;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 280.0,
          childAspectRatio: valueHolder.isShowOwnerInfo! ? 0.6 : 0.72),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
        final  Product product = provider.dataList.data!.toSet().toList()[index];
          return CustomProductVeticalListItem(
            isLoading: isLoading,
            coreTagKey: provider.hashCode.toString(),
            product: isLoading ? Product() : product,
            animation:
                curveAnimation(animationController, index: index, count: count),
            animationController: animationController,
          );
        },
        childCount: count,
      ),
    );
  }
}
