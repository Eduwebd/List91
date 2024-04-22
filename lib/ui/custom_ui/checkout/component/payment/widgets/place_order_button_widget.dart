import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../../../vendor_ui/checkout/component/payment/widgets/place_order_button.dart';

// ignore: must_be_immutable
class CustomPlaceOrderButtonWidget extends StatelessWidget {
  const CustomPlaceOrderButtonWidget(
      {Key? key,
      required this.defaultShippingAndBilling,
      required this.shoppingCartList,
      required this.isSingleItemCheckout,
      required this.totalPrice,
      required this.currencySymbol,
      required this.vendorCurrencyShortForm,
      required this.vendorId,
      required this.vendorExpOrSoldOut,
      required this.color,
      this.titleTextColor})
      : super(key: key);

  final bool defaultShippingAndBilling;
  final bool isSingleItemCheckout;
  final List<ShoppingCartItem> shoppingCartList;
  final String? totalPrice;
  final String? currencySymbol;
  final String? vendorCurrencyShortForm;
  final String? vendorId;
  final bool vendorExpOrSoldOut;
  final Color color;
  final Color? titleTextColor;
  @override
  Widget build(BuildContext context) {
    return PlaceOrderButton(
      color: color,
      vendorExpOrSoldOut: vendorExpOrSoldOut,
      totalPrice: totalPrice,
      shoppingCartList: shoppingCartList,
      defaultShippingAndBilling: defaultShippingAndBilling,
      isSingleItemCheckout: isSingleItemCheckout,
      currencySymbol: currencySymbol,
      vendorCurrencyShortForm: vendorCurrencyShortForm,
      vendorId: vendorId,
      titleTextColor: titleTextColor,
    );
  }
}
