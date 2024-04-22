import 'package:flutter/material.dart';

import '../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/provider/vendor_item_bought/vendor_item_bought_provider.dart';
import '../../../vendor_ui/checkout/view/vendor_paystack.dart';

class CustomVendorPayStackView extends StatelessWidget {
  const CustomVendorPayStackView(
      {Key? key,
      this.amount,
      this.currencyId,
      this.orderId,
      this.userId,
      this.userProvider,
      this.vendorId,
      this.vendorItemBoughtProvider,
      this.vendorPayStackKey,
      this.isSingleCheckout,
      this.itemDetailProvider})
      : super(key: key);
  final VendorItemBoughtProvider? vendorItemBoughtProvider;
  final String? currencyId;
  final String? orderId;
  final String? amount;
  final String? userId;
  final String? vendorId;
  final String? vendorPayStackKey;
  final String? isSingleCheckout;
  final UserProvider? userProvider;
  final ItemDetailProvider? itemDetailProvider;

  @override
  Widget build(BuildContext context) {
    return VendorPayStackView(
      currencyId: currencyId,
      orderId: orderId,
      amount: amount,
      userId: userId,
      vendorId: vendorId,
      userProvider: userProvider,
      vendorItemBoughtProvider: vendorItemBoughtProvider,
      vendorPayStackKey: vendorPayStackKey,
      itemDetailProvider: itemDetailProvider,
      isSingleCheckout: isSingleCheckout,
    );
  }
}
