import 'package:flutter/material.dart';

import '../../../../../vendor_ui/checkout/component/billing_address/widgets/address_tile_widget.dart';

class CustomAddressTileWidget extends StatelessWidget {
  const CustomAddressTileWidget({Key? key,this.onTap,this.subtitleAddress,this.titleAddress}) : super(key: key);
  final String? titleAddress;
  final String? subtitleAddress;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  AddressTileWidget(
      titleAddress: titleAddress,
      subtitleAddress: subtitleAddress,
      onTap: onTap,
    );
  }
}
