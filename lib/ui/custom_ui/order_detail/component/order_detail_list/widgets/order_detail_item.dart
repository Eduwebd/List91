import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/item_info.dart';
import '../../../../../vendor_ui/order_detail/component/order_detail_list/widgets/order_detail_item.dart';

class CustomOrderDetailItem extends StatelessWidget {
  const CustomOrderDetailItem({Key? key, required this.itemInfo})
      : super(key: key);
  final ItemInfo itemInfo;

  @override
  Widget build(BuildContext context) {
    return OrderDetailItem(itemInfo: itemInfo);
  }
}
