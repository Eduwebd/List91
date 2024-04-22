import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../common/ps_button_widget_with_round_corner.dart';
import 'total_price_row.dart';

class OrderPlaceButtonWidget extends StatelessWidget {
  const OrderPlaceButtonWidget(
      {Key? key,
      this.totalPrice,
      this.onPressed,
      this.color,
      this.titleTextColor})
      : super(key: key);
  final String? totalPrice;
  final Function? onPressed;
  final Color? color;

  final Color? titleTextColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
          width: double.infinity,
          height: PsDimens.space84,
          decoration: BoxDecoration(
            color: Utils.isLightMode(context)
                ? PsColors.achromatic50
                : PsColors.achromatic800,
            border: Border.all(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic50
                    : PsColors.achromatic800),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(PsDimens.space12),
                topRight: Radius.circular(PsDimens.space12)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic100
                    : PsColors.achromatic700,
                blurRadius: 10.0, // has the effect of softening the shadow
                spreadRadius: 0, // has the effect of extending the shadow
                offset: const Offset(
                  0.0, // horizontal, move right 10
                  0.0, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                TotalPriceRowWidget(
                  totalPrice: totalPrice ?? '',
                ),
                PSButtonWidgetRoundCorner(
                  colorData: color,
                  onPressed: onPressed,
                  titleText: 'check_out_place_order'.tr,
                  titleTextColor: titleTextColor,
                )
              ],
            ),
          )
          // CustomOtherUserActionsWidget(),
          ),
    );
  }
}
