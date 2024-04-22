import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';

import '../../../../../../core/vendor/utils/utils.dart';

class EntryCategoryInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              // 'item_entry_category_title'.tr,
              'Choose a category',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.text800
                      : PsColors.text50,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: PsDimens.space12,
                    left: PsDimens.space24,
                    right: PsDimens.space24),
                child: Text(
                  'Enhance customization by first selecting categories to enable the personalized input fields',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.text500
                          : PsColors.text300),
                  textAlign: TextAlign.center,
                  // 'item_entry_category_description'.tr,

                  // 'Enhance customization by first selecting categories to enable the personalized input fields',
                )),
          ]),
    );
  }
}
