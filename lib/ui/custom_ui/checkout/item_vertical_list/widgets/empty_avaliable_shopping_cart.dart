import 'package:flutter/material.dart';

import '../../../../vendor_ui/checkout/component/item_vertical_list/widgets/empty_avaliable_shopping_cart.dart';

class CustomEmptyAvaliableShoppingCartWidget extends StatelessWidget {
  const CustomEmptyAvaliableShoppingCartWidget({Key? key,this.isVendorExpired,this.vendorName}) : super(key: key);
  final String? vendorName;
  final int? isVendorExpired;
  @override
  Widget build(BuildContext context) {
    return EmptyAvaliableShoppingCartWidget(vendorName: vendorName,isVendorExpired: isVendorExpired,);
  }
}