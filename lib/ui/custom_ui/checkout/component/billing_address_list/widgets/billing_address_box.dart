import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/all_billing_address.dart';
import '../../../../../vendor_ui/checkout/component/billing_address_list/widgets/billing_address_box.dart';

class CustomBillingAddressBox extends StatelessWidget {
  const CustomBillingAddressBox({Key? key,this.billingAddressList,this.groupValue,this.onChanged,required this.values,this.shippingDefault,this.billingDefault,this.onPressed}) : super(key: key);
 final AllBillingAddress? billingAddressList;
  final int values;
  final int? groupValue;
  final void Function(int?)? onChanged;
 final void Function()? onPressed;
  final bool? billingDefault;
  final bool? shippingDefault;
  @override
  Widget build(BuildContext context) {
    return BillingAddressBox(values: values,groupValue: groupValue,onChanged: onChanged,billingAddressList: billingAddressList,billingDefault: billingDefault,shippingDefault: shippingDefault,onPressed: onPressed,);
  }
}