import 'package:flutter/material.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';

class ShoppingCartOrderSummaryWidget extends StatelessWidget {
  const ShoppingCartOrderSummaryWidget(
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
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
          color: Utils.isLightMode(context)
              ? PsColors.achromatic50
              : PsColors.achromatic700,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(PsDimens.space12),
              topRight: Radius.circular(PsDimens.space12)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(0, 0),
                blurRadius: 4,
                spreadRadius: 0.2)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            child: Container(
              width: PsDimens.space40,
              height: PsDimens.space4,
              margin: const EdgeInsets.only(bottom: PsDimens.space8),
              decoration: BoxDecoration(
                color: PsColors.achromatic200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text('check_out_order_summary'.tr,
              style: TextStyle(
                  fontSize: 20,
                  color: Utils.isLightMode(context)
                      ? PsColors.text800
                      : PsColors.text50)),
          const SizedBox(height: 3),
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
        ],
      ),
    );
  }
}

class OrderSummaryDataWidget extends StatelessWidget {
  const OrderSummaryDataWidget(
      {Key? key,
      required this.title,
      required this.value,
      required this.currency,
      this.isDiscount = false})
      : super(key: key);
  final String title;
  final String value;
  final String currency;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Utils.isLightMode(context)
                      ? PsColors.text800
                      : PsColors.text200)),
          if (isDiscount)
            Text('-$currency$value',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: PsColors.error500))
          else
            Text('$currency$value',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Utils.isLightMode(context)
                        ? PsColors.text800
                        : PsColors.text200)),
        ],
      ),
    );
  }
}
