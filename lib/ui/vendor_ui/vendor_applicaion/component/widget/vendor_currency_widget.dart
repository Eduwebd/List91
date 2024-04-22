import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/vendor_application/vendor_user_provider.dart';
import '../../../../../core/vendor/viewobject/item_currency.dart';

class VendorCurrencyWidget extends StatelessWidget {
  const VendorCurrencyWidget(
      {this.textEditingController,
      this.titleText = '',
      this.hintText,
      this.height = PsDimens.space44,
      this.showTitle = true,
      this.keyboardType = TextInputType.text,
      this.isStar = false,
      this.isEnable = true,
      this.wrongFormat = false,
      this.readonly = false,
      this.showSuffixIcon = false});

  final TextEditingController? textEditingController;
  final String titleText;
  final String? hintText;
  final double height;
  final TextInputType keyboardType;
  final bool showTitle;
  final bool isStar;
  final bool isEnable;
  final bool wrongFormat;
  final bool readonly;
  final bool showSuffixIcon;

  @override
  Widget build(BuildContext context) {
    final VendorUserProvider provider =
        Provider.of<VendorUserProvider>(context, listen: false);
    final Widget _productTextWidget =
        Text(titleText, style: Theme.of(context).textTheme.titleMedium);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (showTitle)
          Container(
            margin: const EdgeInsets.only(
                left: PsDimens.space16,
                top: PsDimens.space12,
                right: PsDimens.space16),
            child: Row(
              children: <Widget>[
                if (isStar)
                  Row(
                    children: <Widget>[
                      Text(titleText,
                          style: Theme.of(context).textTheme.titleMedium!),
                      Text('*',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Theme.of(context).primaryColor))
                    ],
                  )
                else
                  _productTextWidget
              ],
            ),
          ),
        GestureDetector(
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());

            final dynamic itemCurrencySymbolResult = await Navigator.pushNamed(
                context, RoutePaths.itemCurrencySymbol,
                arguments: textEditingController!.text);

            if (itemCurrencySymbolResult != null &&
                itemCurrencySymbolResult is ItemCurrency) {
              provider.setCurrencyId = itemCurrencySymbolResult.id;

              textEditingController!.text =
                  itemCurrencySymbolResult.currencySymbol!;
            }
          },
          child: Container(
              width: double.infinity,
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
              margin: const EdgeInsets.only(
                  top: PsDimens.space12,
                  left: PsDimens.space16,
                  right: PsDimens.space16,
                  bottom: PsDimens.space12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: wrongFormat ? PsColors.error500 : PsColors.text400),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (textEditingController?.text == '' ||
                      textEditingController?.text == null)
                    Text(
                      hintText ?? '',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: PsColors.text400),
                    )
                  else
                    Text(
                      textEditingController?.text ?? '',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: PsColors.text500),
                    ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: PsColors.achromatic400,
                  )
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: PsDimens.space16,
              right: PsDimens.space16,
              bottom: PsDimens.space8),
          child: Text(
            'predefine_default_vendor_currency'.tr,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.normal, color: PsColors.text400),
          ),
        )
      ],
    );
  }
}
