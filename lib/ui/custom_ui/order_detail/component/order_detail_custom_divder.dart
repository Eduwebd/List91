import 'package:flutter/material.dart';

import '../../../vendor_ui/order_detail/component/order_detail_custom_divder.dart';

class CustomOrderDetailCustomDivider extends StatelessWidget {
  const CustomOrderDetailCustomDivider(
      {Key? key, this.margin = 6, this.height = 1})
      : super(key: key);
  final double margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    return OrderDetailCustomDivider(margin: margin, height: height);
  }
}
