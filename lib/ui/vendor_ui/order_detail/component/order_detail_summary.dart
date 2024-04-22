import 'package:flutter/material.dart';

import '../../../../config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';

class OrderDetailSummary extends StatelessWidget {
  const OrderDetailSummary(
      {Key? key,
      required this.title,
      required this.value,
      required this.isDiscount})
      : super(key: key);
  final String title;
  final String value;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PsDimens.space6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic700
                      : PsColors.achromatic200,
                  fontSize: 16)),
          if (isDiscount)
            Text('-$value',
                style: TextStyle(color: PsColors.error500, fontSize: 16))
          else
            Text(value,
                style: TextStyle(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic700
                        : PsColors.achromatic200,
                    fontSize: 16)),
        ],
      ),
    );
  }
}
