import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/user_vendor_detail/component/detail_info/other_user_vendor_detail_info_widget.dart';

class CustomOtherUserVendorDetailWidget extends StatefulWidget {
  const CustomOtherUserVendorDetailWidget({
    Key? key,
    this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  State<CustomOtherUserVendorDetailWidget> createState() =>
      _CustomOtherUserStoreDetailWidgetState();
}

class _CustomOtherUserStoreDetailWidgetState
    extends State<CustomOtherUserVendorDetailWidget> {
  @override
  Widget build(BuildContext context) {
    
    return OtherUserVendorDetailWidget(
      animationController: widget.animationController,
    );
  }
}
