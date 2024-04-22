import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../../custom_ui/checkout/item_vertical_list/widgets/checkout_vertical_list_item.dart';
import '../../../item/detail/component/info_widgets/vendor_expired_widget.dart';

class CheckOutAvailableVerticalListView extends StatelessWidget {
  const CheckOutAvailableVerticalListView(
      {Key? key,
      required this.availableItemList,
      required this.title,
      required this.vendorId,
      required this.isSingleItemCheckout,
      required this.isVendorExpired})
      : super(key: key);

  final List<ShoppingCartItem> availableItemList;
  final String title, vendorId;
  final bool isSingleItemCheckout;
  final int isVendorExpired;
  @override
  Widget build(BuildContext context) {
    final List<int> _availableCartIdList = <int>[];

    if (!isSingleItemCheckout) {
      for (ShoppingCartItem value in availableItemList) {
        _availableCartIdList.add(int.parse(value.cartItemId.toString()));
      }
    }

    return Consumer<AddToCartProvider>(
        builder: (_, AddToCartProvider provider, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic800
                      : PsColors.achromatic100,
                  fontWeight: FontWeight.w600)),
          if (isVendorExpired == PsConst.EXPIRED_NOTI)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: VendorExpiredWidget(
                  vendorExpText: 'vendor_expired_text_for_shopping_cart'.tr),
            )
          else
            const SizedBox(),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: availableItemList.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomCheckoutVerticalListItem(
                    isVendorExpired: isVendorExpired,
                    shoppingCartItem: availableItemList[index],
                    vendorId: vendorId,
                    isSingleItemCheckout: isSingleItemCheckout);
              }),
          const SizedBox(height: PsDimens.space10),
        ],
      );
    });
  }
}
