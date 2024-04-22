import 'package:flutter/material.dart';
import '../../../../../vendor_ui/dashboard/components/home/widgets/home_latest_vendor_list_widget.dart';

class CustomLatestVendorListWidget extends StatelessWidget {
  const CustomLatestVendorListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return LatestVendorListWidget(animationController: animationController);
  }
}
