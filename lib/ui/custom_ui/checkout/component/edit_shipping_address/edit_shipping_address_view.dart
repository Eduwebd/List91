import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/all_shipping_address.dart';
import '../../../../vendor_ui/checkout/component/edit_shipping_address/edit_shipping_address_view.dart';

class CustomEditShippingAddressView extends StatelessWidget {
  const CustomEditShippingAddressView({Key? key,this.editShippingAddress}) : super(key: key);
final AllShippingAddress? editShippingAddress;
  @override
  Widget build(BuildContext context) {
    return EditShippingAddressView(editShippingAddress: editShippingAddress,);
  }
}