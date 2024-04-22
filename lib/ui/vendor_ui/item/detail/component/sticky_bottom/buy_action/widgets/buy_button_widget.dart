import 'package:flutter/material.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../common/ps_button_widget_with_round_corner.dart';

class BuyButtonWidget extends StatelessWidget {
  const BuyButtonWidget({Key? key, this.onPressed}) : super(key: key);
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return PSButtonWidgetRoundCorner(
      height: PsDimens.space40,
      hasShadow: true,
      colorData: Utils.isLightMode(context)
          ? PsColors.achromatic100
          : PsColors.achromatic700,
      titleTextColor: Utils.isLightMode(context)
          ? PsColors.achromatic800
          : PsColors.achromatic50,
      titleText:'product_buy_now'.tr,
      titleTextAlign: TextAlign.center,
      onPressed: onPressed,
    );
  }
}
