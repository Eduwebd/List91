import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../vendor_ui/checkout/view/checkout_view.dart';

class CustomCheckOutView extends StatelessWidget {
  const CustomCheckOutView(
      {Key? key,
      required this.vendorId,
      required this.checkoutItemList,
      this.isSingleItemCheckout = false})
      : super(key: key);
  final String vendorId;
  final List<ShoppingCartItem> checkoutItemList;
  final bool isSingleItemCheckout;
  @override
  Widget build(BuildContext context) {
    return CheckoutView(
      vendorId: vendorId,
      checkoutItemList : checkoutItemList,
      isSingleItemCheckout: isSingleItemCheckout,
    );
  }
}
