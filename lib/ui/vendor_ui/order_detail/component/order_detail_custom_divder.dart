import 'package:flutter/material.dart';

import '../../../../config/ps_colors.dart';

class OrderDetailCustomDivider extends StatelessWidget {
  const OrderDetailCustomDivider({Key? key,required this.margin,required this.height})
      : super(key: key);
  final double margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: height,
        margin: EdgeInsets.symmetric(vertical: margin),
        color: PsColors.achromatic200);
  }
}
