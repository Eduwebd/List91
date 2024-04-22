import 'package:flutter/material.dart';

import '../../../vendor_ui/add_to_cart/view/add_to_cart_view.dart';

class CustomAddToCartView extends StatelessWidget {
  const CustomAddToCartView({Key? key,required this.vendorName,required this.vendorId}) : super(key: key);
  final String vendorName;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    return AddToCartView(vendorName : vendorName,vendorId:vendorId);
  }
}
