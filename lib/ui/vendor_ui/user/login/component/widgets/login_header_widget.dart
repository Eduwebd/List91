import 'package:flutter/material.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class LoginHeaderIconAndTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget _textWidget = Text(
      'login__sign_in'.tr,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          color: Utils.isLightMode(context)
              ? PsColors.achromatic900
              : PsColors.achromatic50 // color: PsColors.primary500,
          ),
    );

    final Widget _imageWidget = Container(
      width: 40,
      height: 40,
      child: Image.asset(
        'assets/images/WhatsApp Image 2024-04-17 at 19.53.23.jpeg',
      ),
    );
    return Column(
      children: <Widget>[
        const SizedBox(
          height: PsDimens.space32,
        ),
        _imageWidget,
        const SizedBox(
          height: PsDimens.space8,
        ),
        _textWidget,
        const SizedBox(
          height: PsDimens.space32,
        ),
      ],
    );
  }
}
