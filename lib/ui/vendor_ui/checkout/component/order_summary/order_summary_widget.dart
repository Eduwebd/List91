import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../add_to_cart/components/widgets/shopping_cart_order_summary_widget.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget(
      {Key? key,
      required this.subTotal,
      required this.discount,
      required this.deliveryCharges,
      required this.currency})
      : super(key: key);

  final String subTotal;
  final String discount;
  final String deliveryCharges;
  final String currency;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('check_out_order_summary'.tr,
            style: TextStyle(
                fontSize: 18,
                color: Utils.isLightMode(context)
                    ? PsColors.text800
                    : PsColors.text50)),
        const SizedBox(height: PsDimens.space6),
        OrderSummaryDataWidget(
            title: 'transaction_detail__sub_total'.tr,
            value: subTotal,
            currency: currency),
        OrderSummaryDataWidget(
          title: 'transaction_detail__discount'.tr,
          value: discount,
          currency: currency,
          isDiscount: true,
        ),
        OrderSummaryDataWidget(
            title: 'delivery_charges'.tr,
            value: deliveryCharges,
            currency: currency),
        Container(
          width: double.maxFinite,
          height: PsDimens.space1,
          margin: const EdgeInsets.symmetric(vertical: PsDimens.space12),
          decoration: BoxDecoration(
            color: PsColors.achromatic200,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SelectableText.rich(
          TextSpan(children: <InlineSpan>[
            TextSpan(
              text: 'check_out_aggree'.tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic800
                      : PsColors.achromatic50),
            ),
            TextSpan(
              text: 'check_out_policy'.tr,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: PsColors.primary500),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RoutePaths.privacyPolicy);
                },
            ),
          ]),
        ),
        const SizedBox(height: PsDimens.space10)
      ],
    );
  }
}
