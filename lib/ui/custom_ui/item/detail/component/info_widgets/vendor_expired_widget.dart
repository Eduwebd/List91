import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/detail/component/info_widgets/vendor_expired_widget.dart';

class CustomVendorExpiredWidget extends StatelessWidget {
  const CustomVendorExpiredWidget({Key? key, required this.vendorExpText})
      : super(key: key);
  final String vendorExpText;
  @override
  Widget build(BuildContext context) {
    return VendorExpiredWidget(
      vendorExpText: vendorExpText,
    );
  }
}
