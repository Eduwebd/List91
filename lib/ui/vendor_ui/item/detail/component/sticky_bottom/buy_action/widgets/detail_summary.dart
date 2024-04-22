import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../common/ps_ui_widget.dart';

class DetailSummary extends StatelessWidget {
  const DetailSummary({Key? key, required this.product,this.quantity}) : super(key: key);
  final Product product;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(PsDimens.space6),
      color: Utils.isLightMode(context)
          ? PsColors.achromatic50
          : PsColors.achromatic700,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Image View
          ClipRRect(
            borderRadius: BorderRadius.circular(PsDimens.space6),
            child: PsNetworkImage(
              photoKey: product.id,
              defaultPhoto: product.defaultPhoto,
              imageAspectRation: PsConst.Aspect_Ratio_3x,
              width: PsDimens.space100,
              height: PsDimens.space100,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Item Name
                  Text(
                    product.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Utils.isLightMode(context)
                            ? PsColors.text600
                            : PsColors.text100),
                  ),

                  /// Item price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (product.isDiscountedItem &&
                          psValueHolder.isShowDiscount!)
                        Text(
                          '${product.itemCurrency?.currencySymbol}${product.originalPrice} ',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Utils.isLightMode(context)
                                      ? PsColors.text500
                                      : PsColors.text200,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12),
                        ),
                      Text(
                        ' ${product.itemCurrency?.currencySymbol}${product.currentPrice}',
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: PsColors.primary500, fontSize: 14),
                      ),
                    ],
                  ),

                  /// Item Qty
                  if((quantity?? 0) <= 10)Text(
                    'Only $quantity Items In Stock',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: PsColors.error500),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
