import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/profile/component/my_vendor/my_vendor_vertical_list_widget.dart';

class CustomMyVendorVerticalListWidget extends StatelessWidget {
  const CustomMyVendorVerticalListWidget(
      {required this.animationController, required this.controller,required this.isGrid});

  final AnimationController animationController;
  final ScrollController controller;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
   
      return MyVendorVerticalListWidget(
        animationController: animationController,
        controller: controller,
        isGrid: isGrid,
      );
  }
}
