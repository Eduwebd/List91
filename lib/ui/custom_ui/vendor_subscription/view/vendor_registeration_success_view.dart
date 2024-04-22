import 'package:flutter/material.dart';

import '../../../vendor_ui/vendor_subscription/view/vendor_registeration_success_view.dart';

class CustomVendorRegisterationSuccess extends StatefulWidget {
  const CustomVendorRegisterationSuccess({Key? key}) : super(key: key);

  @override
  State<CustomVendorRegisterationSuccess> createState() => _CustomVendorRegisterationSuccessState();
}

class _CustomVendorRegisterationSuccessState extends State<CustomVendorRegisterationSuccess> {
  @override
  Widget build(BuildContext context) {
    return const VendorRegisterationSuccessView();
  }
}