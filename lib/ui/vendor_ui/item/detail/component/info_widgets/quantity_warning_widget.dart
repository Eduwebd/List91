import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';

class QuantityWarningWidget extends StatelessWidget {
  const QuantityWarningWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Utils.isLightMode(context)
              ? PsColors.warning50
              : PsColors.warning800,
          borderRadius: BorderRadius.circular(PsDimens.space8),
          border: Border.all(
              color: Utils.isLightMode(context)
                  ? PsColors.warning400
                  : PsColors.warning600)),
      padding: const EdgeInsets.all(10),
      child: Text(
          'please_update_the_quantity_of_this_item'.tr),
    );
  }
}
