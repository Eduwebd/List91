import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';

import '../../../../../../core/vendor/utils/utils.dart';

class SubTotalDiscount extends StatelessWidget {
  const SubTotalDiscount(
      {Key? key, this.title, this.values, required this.isDiscount})
      : super(key: key);
  final String? title;
  final String? values;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title ?? '',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        Text(
          isDiscount ? '- $values' : ' $values',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: isDiscount ? PsColors.error400 :
              Utils.isLightMode(context)
                                      ? PsColors.achromatic800
                                      : PsColors.achromatic50),
        )
      ],
    );
  }
}
