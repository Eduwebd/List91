import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../common/ps_ui_widget.dart';
import 'widgets/subtotal_discount.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary(
      {Key? key,
      this.subtotal,
      this.subtotalValue,
      this.discount,
      this.discountValue,
      this.productDesciption,
      this.defaultPhoto,
      this.photoKey,
      this.stockQty,
      this.userQty,
      this.currentPrice,
      this.title,
      this.isOrderDetail,
      this.total,
      this.totalValue,
      this.deliveryCharges,
      this.deliverySetting,
      this.onTap})
      : super(key: key);
  final String? subtotal;
  final String? subtotalValue;
  final String? discount;
  final String? discountValue;
  final String? currentPrice;
  final DefaultPhoto? defaultPhoto;
  final int? userQty;
  final int? stockQty;
  final String? photoKey;
  final String? productDesciption;
  final String? title;
  final bool? isOrderDetail;
  final String? total;
  final String? totalValue;
  final String? deliveryCharges;
  final String? deliverySetting;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title ?? '',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
        Container(
          margin: const EdgeInsets.only(
              top: PsDimens.space16, bottom: PsDimens.space4),
          width: double.infinity,
          height: PsDimens.space100,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: PsDimens.space6),
                  child: PsNetworkImage(
                    photoKey: photoKey,
                    defaultPhoto: defaultPhoto,
                    imageAspectRation: PsConst.Aspect_Ratio_3x,
                    width: PsDimens.space100,
                    height: PsDimens.space100,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (isOrderDetail == true)
                        Container()
                      else
                        int.parse(stockQty.toString()) < 10
                            ? //
                            Text(
                                'Only $stockQty Items In Stock',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red),
                              )
                            : Container(),
                      Expanded(
                        child: Text(
                          productDesciption ?? '',
                          // value.product.description.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Utils.isLightMode(context)
                                      ? PsColors.achromatic800
                                      : PsColors.achromatic50),
                        ),
                      ),
                      Expanded(child: Text('Qty: $userQty X')),
                      if (isOrderDetail == true)
                        Container()
                      else
                        Flexible(
                          child: GestureDetector(
                            onTap: onTap,
                            child: Text(
                              'check_out_edit'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: PsColors.primary500),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text('${currentPrice?.toString() ?? ''}'),
                )
              ]),
        ),
        const Divider(),
        SubTotalDiscount(
          title: subtotal ?? '',
          values: subtotalValue ?? '',
          isDiscount: false,
        ),
        SubTotalDiscount(
          title: discount ?? '',
          values: discountValue ?? '',
          isDiscount: true,
        ),
        if (deliverySetting == PsConst.ONE)
          SubTotalDiscount(
            title: 'delivery_charges'.tr,
            values: deliveryCharges ?? '',
            isDiscount: false,
          )
        else
          const SizedBox(),
        const Divider(),
        if (isOrderDetail == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                total ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: PsColors.text600),
              ),
              Text(
                totalValue ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic800
                        : PsColors.achromatic50),
              ),
            ],
          )
        else
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
              )
            ]),
          )
      ],
    );
  }
}
