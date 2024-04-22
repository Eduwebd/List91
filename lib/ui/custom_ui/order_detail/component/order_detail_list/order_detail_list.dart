import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/item_info.dart';
import '../../../../vendor_ui/order_detail/component/order_detail_list/order_detail_list.dart';

class CustomOrderDetailList extends StatelessWidget {
  const CustomOrderDetailList(
      {Key? key, required this.title, required this.itemInfoList})
      : super(key: key);
  final String title;
  final List<ItemInfo> itemInfoList;

  @override
  Widget build(BuildContext context) {
    return OrderDetailList(title: title, itemInfoList: itemInfoList);
  }
}
