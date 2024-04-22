import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/utils/utils.dart';

class SliderTitle extends StatelessWidget {
  const SliderTitle({required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    final List<String> titleList = <String>[
      'intro_slider1_title',
      'intro_slider2_title',
      'intro_slider3_title'
    ];
    return Text(
      titleList[currentIndex].tr,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Utils.isLightMode(context)
                ? PsColors.text800
                : PsColors.achromatic50,
          ),
      textAlign: TextAlign.center,
    );
  }
}
