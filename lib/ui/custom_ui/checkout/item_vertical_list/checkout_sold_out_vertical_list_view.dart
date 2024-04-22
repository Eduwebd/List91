import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../vendor_ui/checkout/component/item_vertical_list/checkout_sold_out_vertical_list_view.dart';

class CustomCheckOutSoldOutVerticalListView extends StatelessWidget {
  const CustomCheckOutSoldOutVerticalListView({Key? key,required this.isSingleItemCheckout,required this.isVendorExpired,required this.soldOutItemList,required this.vendorId}) : super(key: key);
  final List<ShoppingCartItem> soldOutItemList;
  final String vendorId;
  final bool isSingleItemCheckout;
  final int isVendorExpired;
  @override
  Widget build(BuildContext context) {
    return CheckOutSoldOutVerticalListView(soldOutItemList: soldOutItemList,vendorId: vendorId,isSingleItemCheckout: isSingleItemCheckout,isVendorExpired: isVendorExpired,);
  }
}