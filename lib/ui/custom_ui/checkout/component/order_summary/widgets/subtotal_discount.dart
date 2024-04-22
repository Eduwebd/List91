import 'package:flutter/material.dart';

import '../../../../../vendor_ui/checkout/component/order_summary/widgets/subtotal_discount.dart';

class CustomSubTotalDiscount extends StatelessWidget {
  const CustomSubTotalDiscount({Key? key, required this.isDiscount})
      : super(key: key);
  final bool isDiscount;
  @override
  Widget build(BuildContext context) {
    return SubTotalDiscount(isDiscount: isDiscount);
  }
}
