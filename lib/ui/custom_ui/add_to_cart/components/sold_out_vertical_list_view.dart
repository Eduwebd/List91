import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../vendor_ui/add_to_cart/components/sold_out_vertical_list_view.dart';

class CustomSoldOutVerticalListView extends StatelessWidget {
  const CustomSoldOutVerticalListView({Key? key,required this.isVedorExpired,required this.soldOutItemList,required this.vendorId,}) : super(key: key);
 final List<ShoppingCartItem> soldOutItemList;
  final String vendorId;
  final int isVedorExpired;
  @override
  Widget build(BuildContext context) {
    return  SoldOutVerticalListView(soldOutItemList: soldOutItemList,vendorId: vendorId,isVedorExpired:isVedorExpired,);
  }
}