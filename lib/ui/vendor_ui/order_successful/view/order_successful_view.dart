import 'package:flutter/material.dart';
import '../component/widgets/order_successful_widget.dart';

class OrderSuccessfulView extends StatelessWidget {
  const OrderSuccessfulView({
    Key? key,
    required this.orderId,
    required this.vendorId
  }) : super(key: key);
  final String orderId;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
      child: Scaffold(
          body: OrderSuccessfulWidget(
        orderId: orderId,
        vendorId: vendorId,
      )),
    );
  }
}
