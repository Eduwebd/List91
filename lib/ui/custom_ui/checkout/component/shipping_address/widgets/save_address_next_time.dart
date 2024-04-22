import 'package:flutter/material.dart';

import '../../../../../vendor_ui/checkout/component/shipping_address/widgets/save_address_next_time.dart';

class CustomSaveAddressNextTimeWidget extends StatelessWidget {
  const CustomSaveAddressNextTimeWidget({Key? key,required this.checkBoxTitle,this.onChanged,this.value}) : super(key: key);
 final String checkBoxTitle;
final void Function(bool?)? onChanged;
final bool? value;
  @override
  Widget build(BuildContext context) {
    return  SaveAddressNextTimeWidget(checkBoxTitle: checkBoxTitle,onChanged: onChanged,value: value,);
  }
}
