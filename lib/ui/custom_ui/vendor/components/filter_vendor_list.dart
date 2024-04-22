import 'package:flutter/material.dart';

import '../../../vendor_ui/vendor/components/filter_vendor_list.dart';

class CustomFilterVendorList extends StatelessWidget {
  const CustomFilterVendorList(
      {required this.animationController, required this.controller,required this.isGrid});

  final AnimationController animationController;
  final ScrollController controller;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
   
      return FilterVendorList(
        animationController: animationController,
        controller: controller,
        isGrid: isGrid,
      );
  }
}
