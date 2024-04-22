import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: PsDimens.space28,
          right: PsDimens.space28,
          top: PsDimens.space16),
      child: Center(
        child: Text('Order Successfully Completed',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Utils.isLightMode(context)
                    ? PsColors.text800
                    : PsColors.achromatic50)),
      ),
    );
  }
}
