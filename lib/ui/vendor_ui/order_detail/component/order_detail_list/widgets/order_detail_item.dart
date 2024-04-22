import 'package:flutter/material.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/item_info.dart';
import '../../../../common/ps_ui_widget.dart';

class OrderDetailItem extends StatelessWidget {
  const OrderDetailItem({Key? key, required this.itemInfo}) : super(key: key);
  final ItemInfo itemInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 88,
      margin: const EdgeInsets.only(bottom: PsDimens.space6),
      child: Row(children: <Widget>[
        /// Image
        ClipRRect(
          borderRadius: BorderRadius.circular(PsDimens.space6),
          child: PsNetworkImage(
            photoKey: itemInfo.itemId,
            defaultPhoto: itemInfo.defaultPhoto,
            imageAspectRation: PsConst.Aspect_Ratio_3x,
            width: PsDimens.space88,
            height: PsDimens.space88,
            boxfit: BoxFit.cover,
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: PsDimens.space8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// Item Name
                Text(
                  itemInfo.itemName ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Utils.isLightMode(context)
                          ? PsColors.text600
                          : PsColors.text100),
                ),

                const SizedBox(height: PsDimens.space6),

                /// Item Qty
                Text(
                  'Qty: ${itemInfo.quantity}x',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: PsColors.error500),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: PsDimens.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                itemInfo.salePrice ?? '',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: PsColors.primary500, fontSize: 16),
              ),
              if (itemInfo.discountPrice?.replaceAll(RegExp(r'[^0-9]'), '') ==
                  '0')
                const SizedBox()
              else
                Text(
                  itemInfo.originalPrice ?? '',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Utils.isLightMode(context)
                          ? PsColors.text500
                          : PsColors.text200,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14),
                ),
            ],
          ),
        )
      ]),
    );
  }
}
