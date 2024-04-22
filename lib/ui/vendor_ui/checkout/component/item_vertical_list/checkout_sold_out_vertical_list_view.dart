import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../../custom_ui/checkout/item_vertical_list/widgets/checkout_vertical_list_item.dart';

class CheckOutSoldOutVerticalListView extends StatelessWidget {
  const CheckOutSoldOutVerticalListView(
      {Key? key,
      required this.soldOutItemList,
      required this.vendorId,
      required this.isSingleItemCheckout,required this.isVendorExpired})
      : super(key: key);

  final List<ShoppingCartItem> soldOutItemList;
  final String vendorId;
  final bool isSingleItemCheckout;
  final int isVendorExpired;
  @override
  Widget build(BuildContext context) {
    return Consumer<AddToCartProvider>(
        builder: (_, AddToCartProvider provider, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('sold_out_items'.tr,
              style: TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic800
                      : PsColors.achromatic100,
                  fontWeight: FontWeight.w600)),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: soldOutItemList.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomCheckoutVerticalListItem(
                   isVendorExpired: isVendorExpired,
                  shoppingCartItem: soldOutItemList[index],
                  vendorId: vendorId,
                  isSingleItemCheckout : isSingleItemCheckout
                );
              }),
          const SizedBox(height: PsDimens.space10),
        ],
      );
    });
  }
}
