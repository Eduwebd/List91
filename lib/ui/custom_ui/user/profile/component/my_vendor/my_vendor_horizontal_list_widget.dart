import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/profile/component/my_vendor/my_vendor_horizontal_list_widget.dart';

class CustomMyVendorHorizontalListWidget extends StatelessWidget {
  const CustomMyVendorHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    
    return MyVendorHorizontalListWidget(
      animationController: animationController,
    );
  }
}
