import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../core/vendor/constant/ps_dimens.dart';

class PsBackButtonWithCircleBgWidget extends StatelessWidget {
  const PsBackButtonWithCircleBgWidget({Key? key, this.isReadyToShow, this.backButtonIconOnTap})
      : super(key: key);

  final bool? isReadyToShow;
  final Function()? backButtonIconOnTap;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isReadyToShow!,
      child: Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space12, right: PsDimens.space4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: PsColors.achromatic900.withAlpha(100),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
                left: Platform.isIOS ? PsDimens.space8 : PsDimens.space1),
            child: InkWell(
                child: Icon(
                  Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  color: PsColors.achromatic50,
                ),
                onTap: backButtonIconOnTap ?? () {

                  Navigator.pop(context);
                }),
          ),
        ),
      ),
    );
  }
}
