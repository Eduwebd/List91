import 'package:flutter/material.dart';

import '../../../../vendor_ui/add_to_cart/components/widgets/shopping_cart_order_summary_widget.dart';

class CustomShoppingCartOrderSummaryWidget extends StatelessWidget {
  const CustomShoppingCartOrderSummaryWidget(
      {Key? key,
      required this.subTotal,
      required this.discount,
      required this.deliveryCharges,
      required this.currency})
      : super(key: key);

  final String subTotal;
  final String discount;
  final String deliveryCharges;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return ShoppingCartOrderSummaryWidget(
        subTotal: subTotal,
        discount: discount,
        deliveryCharges: deliveryCharges,
        currency: currency);
  }
}
