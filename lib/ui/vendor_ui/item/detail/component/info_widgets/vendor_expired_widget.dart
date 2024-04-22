import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';

class VendorExpiredWidget extends StatelessWidget {
  const VendorExpiredWidget({Key? key,required this.vendorExpText}) : super(key: key);
  final String vendorExpText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Utils.isLightMode(context)
              ? PsColors.warning50
              : PsColors.warning800,
          borderRadius: BorderRadius.circular(PsDimens.space8),
          border: Border.all(
              color: Utils.isLightMode(context)
                  ? PsColors.warning400
                  : PsColors.warning600)),
      padding: const EdgeInsets.all(20),
      child: Text(vendorExpText),
    );
  }
}
