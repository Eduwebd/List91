import 'package:flutter/material.dart';

import '../../../../../vendor_ui/checkout/component/payment/widgets/payment_role_widget.dart';

class CustomPaymentRoleWidget extends StatelessWidget {
  const CustomPaymentRoleWidget(
      {Key? key, required this.image, required this.paymentName})
      : super(key: key);
  final Image image;
  final String paymentName;
  @override
  Widget build(BuildContext context) {
    return PaymentRoleWidget(image: image, paymentName: paymentName);
  }
}
