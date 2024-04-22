import 'package:flutter/material.dart';

import '../../../vendor_ui/order_detail/view/order_detail_view.dart';

class CustomOrderDetailView extends StatelessWidget {
  const CustomOrderDetailView(
      {Key? key, required this.orderId, required this.vendorId})
      : super(key: key);
  final String orderId;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    return OrderDetailView(
      orderId: orderId,
      vendorId: vendorId,
    );
  }
}
