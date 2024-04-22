import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/vendor_subscription_plan.dart';
import '../../common/ps_button_widget.dart';

class VendorSubscriptionCard extends StatelessWidget {
  const VendorSubscriptionCard(
      {Key? key,
      required this.vendorSubscriptionPlan,
      required this.onTap,
      required this.priceWithCurrency})
      : super(key: key);

  final VendorSubscriptionPlan vendorSubscriptionPlan;
  // final PsValueHolder psValueHolder;
  final Function? onTap;
  final String? priceWithCurrency;
  @override
  Widget build(BuildContext context) {
    print(vendorSubscriptionPlan.paymentAttributes!.discountPrice);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space18),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: PsColors.achromatic300),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        // color: Colors.black,
        child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: PsColors.achromatic100),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 50,
                  left: (Directionality.of(context) == TextDirection.rtl)
                      ? 0
                      : 60,
                  bottom: 30,
                  right: (Directionality.of(context) == TextDirection.rtl)
                      ? 60
                      : 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('vendor_subscription_price'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontSize: 18,
                                  color: PsColors.achromatic600,
                                )),
                        if (vendorSubscriptionPlan
                                .paymentAttributes!.isMostPopularPlan ==
                            PsConst.ONE)
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: PsDimens.space10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: PsDimens.space4,
                                vertical: PsDimens.space1),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                color: PsColors.primary600),
                            child: Text('vendor_most_popular'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      color: PsColors.achromatic50,
                                    )),
                          )
                        else
                          const SizedBox()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: PsDimens.space12),
                      child: RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                                // text:(widget.vendorSubscriptionPlan.paymentAttributes!.discountPrice !=PsConst.ZERO) ?'${widget.vendorSubscriptionPlan.paymentAttributes!.currencySymbol} ${Utils.getPriceFormat(widget.vendorSubscriptionPlan.paymentAttributes!.discountPrice!, widget.psValueHolder.priceFormat!)}\t':'${widget.vendorSubscriptionPlan.paymentAttributes!.currencySymbol} ${Utils.getPriceFormat(widget.vendorSubscriptionPlan.paymentAttributes!.salePrice!, widget.psValueHolder.priceFormat!)}\t',
                                //  text:(vendorSubscriptionPlan.paymentAttributes!.discountPrice !=PsConst.ZERO)? '${vendorSubscriptionPlan.paymentAttributes!.currencySymbol} ${vendorSubscriptionPlan.paymentAttributes!.discountPrice!}\t': '${vendorSubscriptionPlan.paymentAttributes!.currencySymbol} ${vendorSubscriptionPlan.paymentAttributes!.salePrice!}\t',
                                text: priceWithCurrency,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      color: PsColors.primary500,
                                    )),
                            //  if (vendorSubscriptionPlan.paymentAttributes!.discountPrice !=PsConst.ZERO)
                            //  TextSpan(
                            //   // text: '${widget.vendorSubscriptionPlan.paymentAttributes!.currencySymbol} ${Utils.getPriceFormat(widget.vendorSubscriptionPlan.paymentAttributes!.salePrice!, widget.psValueHolder.priceFormat!)}',
                            //   text: '${vendorSubscriptionPlan.paymentAttributes!.currencySymbol}${vendorSubscriptionPlan.paymentAttributes!.salePrice!}',
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .displayMedium!
                            //       .copyWith(
                            //         fontSize: 20,
                            //         decoration: TextDecoration.lineThrough,
                            //         fontWeight: FontWeight.w500,
                            //         color: PsColors.achromatic600,
                            //       ))
                            //       else const TextSpan(),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              children: <Widget>[
                Text(
                  '${vendorSubscriptionPlan.paymentInfo!.value}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Utils.isLightMode(context)
                            ? PsColors.achromatic800
                            : PsColors.achromatic50,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Text(
                    '${vendorSubscriptionPlan.paymentAttributes!.vendorDuration}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          color: Utils.isLightMode(context)
                              ? PsColors.achromatic800
                              : PsColors.achromatic50,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: PSButtonWidget(
                      titleText: 'vendor_subsription_purchase'.tr,
                      onPressed: onTap as void Function()?),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
