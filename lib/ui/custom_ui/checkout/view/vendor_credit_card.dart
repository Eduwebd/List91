import 'package:flutter/material.dart';

import '../../../../core/vendor/provider/vendor_item_bought/vendor_item_bought_provider.dart';
import '../../../vendor_ui/checkout/view/vendor_credit_card_view.dart';

class CustomVendorCreditCardView extends StatelessWidget {
  const CustomVendorCreditCardView(
      {Key? key,
      this.vendorItemBoughtProvider,
      this.currencyId,
      this.orderId,
      this.paymentAmount,
      this.userId,
      this.vendorId,
      this.isSingleCheckout,
      this.vendorStripePulicKey,
      this.itemId})
      : super(key: key);
  final VendorItemBoughtProvider? vendorItemBoughtProvider;
  final String? vendorId;
  final String? currencyId;
  final String? userId;
  final String? paymentAmount;
  final String? vendorStripePulicKey;
  final String? orderId;
  final String? itemId;
  final String? isSingleCheckout;
  @override
  Widget build(BuildContext context) {
    return VendorCreditCardView(
      vendorItemBoughtProvider: vendorItemBoughtProvider,
      vendorId: vendorId,
      currencyId: currencyId,
      userId: userId,
      paymentAmount: paymentAmount,
      vendorStripePulicKey: vendorStripePulicKey,
      orderId: orderId,
      itemId: itemId,
      isSingleCheckout : isSingleCheckout
    );
  }
}
