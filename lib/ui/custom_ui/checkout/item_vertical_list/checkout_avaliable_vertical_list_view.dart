import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../vendor_ui/checkout/component/item_vertical_list/checkout_available_vertical_list_view.dart';

class CustomCheckOutAvailableVerticalListView extends StatelessWidget {
  const CustomCheckOutAvailableVerticalListView({Key? key,required this.availableItemList,required this.isSingleItemCheckout,required this.isVendorExpired,required this.title,required this.vendorId}) : super(key: key);
 final List<ShoppingCartItem> availableItemList;
  final String title, vendorId;
  final bool isSingleItemCheckout;
  final int isVendorExpired;
  @override
  Widget build(BuildContext context) {
    return CheckOutAvailableVerticalListView(availableItemList: availableItemList,title: title,vendorId: vendorId,isSingleItemCheckout: isSingleItemCheckout,isVendorExpired: isVendorExpired,);
  }
}