import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../vendor_ui/add_to_cart/components/available_vertical_list_view.dart';

class CustomAvailableVerticalListView extends StatelessWidget {
  const CustomAvailableVerticalListView({Key? key,required this.availableItemList,required this.isVedorExpired,required this.title,required this.vendorId}) : super(key: key);
  final List<ShoppingCartItem> availableItemList;
  final String title, vendorId;
  final int isVedorExpired;
  @override
  Widget build(BuildContext context) {
    return AvailableVerticalListView(availableItemList: availableItemList,title: title,vendorId: vendorId,isVedorExpired: isVedorExpired,);
  }
}