import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/all_shipping_address.dart';
import '../../../../../vendor_ui/checkout/component/shipping_address_list/widget/shipping_address_box.dart';

class CustomShippingAddressBox extends StatelessWidget {
  const CustomShippingAddressBox({Key? key,this.groupValue,this.onChanged,this.onPressed,this.shippingAddressList,required this.values,this.shippingDefault,this.billingDefault,}) : super(key: key);
  final AllShippingAddress? shippingAddressList;
  final int values;
  final int? groupValue;
  final void Function(int?)? onChanged;
  final void Function()? onPressed;
  final bool? billingDefault;
  final bool? shippingDefault;


  @override
  Widget build(BuildContext context) {
    return ShippingAddressBox(values: values,shippingAddressList: shippingAddressList,groupValue: groupValue,onChanged: onChanged,onPressed: onPressed,billingDefault: billingDefault,shippingDefault:shippingDefault,);
  }
}