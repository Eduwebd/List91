import 'package:flutter/material.dart';

import '../../../vendor_ui/order_detail/component/order_detail_summary.dart';

class CustomOrderDetailSummary extends StatelessWidget {
  const CustomOrderDetailSummary(
      {Key? key,
      required this.title,
      required this.value,
      this.isDiscount = false})
      : super(key: key);
  final String title;
  final String value;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return OrderDetailSummary(
        title: title, value: value, isDiscount: isDiscount);
  }
}
