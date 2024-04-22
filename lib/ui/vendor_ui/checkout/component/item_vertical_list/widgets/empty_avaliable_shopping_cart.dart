import 'package:flutter/material.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../ui/vendor_ui/item/detail/component/info_widgets/vendor_expired_widget.dart';

class EmptyAvaliableShoppingCartWidget extends StatelessWidget {
  const EmptyAvaliableShoppingCartWidget(
      {Key? key, this.vendorName, this.isVendorExpired})
      : super(key: key);
  final String? vendorName;
  final int? isVendorExpired;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(vendorName ?? '',
            style: TextStyle(
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic800
                    : PsColors.achromatic100,
                fontWeight: FontWeight.w600)),
        if (isVendorExpired == 2)
          Padding(
            padding: const EdgeInsets.only(top:PsDimens.space8),
            child: VendorExpiredWidget(
                vendorExpText:
                    'vendor_expired_text_for_shopping_cart'.tr),
          )
        else
          const SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / PsDimens.space4),
          child: Image.asset(
            'assets/images/checkout_no_order.png',

            //height: 120,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              right: PsDimens.space14,
              left: PsDimens.space14,
              bottom: PsDimens.space22),
          child: Text(
              'Unfortunately, some items have sold out. Please pick and purchase other available items for your orders.',
              style: TextStyle(
                  fontSize: 14,
                  color: PsColors.text500,
                  fontWeight: FontWeight.w500)),
        )
      ],
    );
  }
}
