import 'package:flutter/material.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/all_billing_address.dart';

class BillingAddressBox extends StatelessWidget {
  const BillingAddressBox({
    Key? key,
    this.billingAddressList,
    required this.values,
    this.groupValue,
    this.onChanged,
    this.onPressed,
    this.shippingDefault,
    this.billingDefault
  }) : super(key: key);
  final AllBillingAddress? billingAddressList;
  final int values;
  final int? groupValue;
  final void Function(int?)? onChanged;
  final void Function()? onPressed;
  final bool? billingDefault;
  final bool? shippingDefault;
  @override
  Widget build(BuildContext context) {
    final String billingAddressListData =
        '${billingAddressList?.billingFirstName} ${billingAddressList?.billingLastName},${billingAddressList?.billingPhoneNo},${billingAddressList?.billingEmail},${billingAddressList?.billingAddress},${billingAddressList?.billingCountry},${billingAddressList?.billingState},${billingAddressList?.billingCity},${billingAddressList?.billingPostalCode}';
    return Container(
      decoration: BoxDecoration(
        color: Utils.isLightMode(context)
            ? PsColors.achromatic50
            : PsColors.achromatic700,
        border: Border.all(
          color: Utils.isLightMode(context)
              ? PsColors.achromatic100
              : PsColors.achromatic600,
        ),
        borderRadius: BorderRadius.circular(PsDimens.space8),
      ),
      margin: const EdgeInsets.only(
          left: PsDimens.space16,
          right: PsDimens.space16,
          top: PsDimens.space8),
      child: RadioListTile<int>(
        contentPadding: EdgeInsets.zero,
        dense: true,
        secondary: Padding(
          padding: const EdgeInsets.only(bottom: PsDimens.space10),
          child: TextButton(
            onPressed: onPressed,
            child: Text('profile__edit'.tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: PsColors.primary500)),
          ),
        ),
        isThreeLine: true,
        activeColor: PsColors.primary500,
        value: values,
        groupValue: groupValue,
        onChanged: onChanged,
        subtitle: 
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   if (shippingDefault == true)
                    Container(
                      margin: const EdgeInsets.only(right: PsDimens.space40),
                      color: Utils.isLightMode(context)
                          ? PsColors.primary50
                          : PsColors.error700,
                      padding: const EdgeInsets.all(PsDimens.space1),
                      child: Text('user_default_shipping_address'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Utils.isLightMode(context)
                                      ? PsColors.error600
                                      : PsColors.primary50)),
                    ) else
                const SizedBox(),
                   if (billingDefault == true)
                    Container(
                      margin: const EdgeInsets.only(
                          right: PsDimens.space40, top: PsDimens.space2),
                      color: Utils.isLightMode(context)
                          ? PsColors.primary50
                          : PsColors.error700,
                      padding: const EdgeInsets.all(PsDimens.space1),
                      child: Text('user_default_billing_address'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Utils.isLightMode(context)
                                      ? PsColors.error600
                                      : PsColors.primary50)),
                    )
                     else
                const SizedBox(),
                  ]),
           
        title: Padding(
          padding: const EdgeInsets.only(top: PsDimens.space8),
          child: Text(
            '$billingAddressListData',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
