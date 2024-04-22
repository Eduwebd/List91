import 'package:flutter/material.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/item_info.dart';
import '../../../../custom_ui/order_detail/component/order_detail_list/widgets/order_detail_item.dart';

class OrderDetailList extends StatelessWidget {
  const OrderDetailList(
      {Key? key, required this.title, required this.itemInfoList})
      : super(key: key);
  final String title;
  final List<ItemInfo> itemInfoList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: TextStyle(
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic800
                    : PsColors.achromatic100,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: PsDimens.space8),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemInfoList.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomOrderDetailItem(itemInfo: itemInfoList[index]);
            }),
      ],
    );
  }
}
