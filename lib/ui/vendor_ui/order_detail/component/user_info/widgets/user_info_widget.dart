import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget(
      {Key? key, required this.title, this.values, this.isPayment, this.paid})
      : super(key: key);
  final String title;
  final String? values;
  final bool? isPayment;
  final String? paid;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Utils.isLightMode(context)? PsColors.text800:PsColors.text50),
          ),
          if (isPayment == true)
            Row(
              children: <Widget>[
                Text(
                  values ?? '',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Utils.isLightMode(context)? PsColors.text800:PsColors.text50),
                ),
                const SizedBox(
                  width: PsDimens.space10,
                ),
                Container(
                  alignment: Alignment.center,
                  color:
                      paid == 'Unpaid' ? PsColors.error50 : PsColors.success50,
                  width: PsDimens.space40,
                  height: PsDimens.space22,
                  child: Text(
                    paid ?? '',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: paid == 'Unpaid'
                            ? PsColors.error500
                            : PsColors.success500),
                  ),
                )
              ],
            )
          else
            Text(
              values ?? '',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Utils.isLightMode(context)? PsColors.text800:PsColors.text50),
            ),
        ],
      ),
    );
  }
}
