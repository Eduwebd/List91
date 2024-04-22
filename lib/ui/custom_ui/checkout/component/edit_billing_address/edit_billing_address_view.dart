import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/all_billing_address.dart';
import '../../../../vendor_ui/checkout/component/edit_billing_address/edit_billing_address_view.dart';

class CustomEditBillingAddressView extends StatelessWidget {
  const CustomEditBillingAddressView({Key? key,this.editBillingAddress}) : super(key: key);
final AllBillingAddress? editBillingAddress;
  @override
  Widget build(BuildContext context) {
    return EditBillingAddressView(editBillingAddress:editBillingAddress ,);
  }
}