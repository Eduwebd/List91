import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/profile/component/vendor_application_card/profile_vendor_application_card_view.dart';

class CustomProfileVendorApplicationCard extends StatefulWidget {
    const CustomProfileVendorApplicationCard({Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  _CustomProfileVendorApplicationCardState createState() => _CustomProfileVendorApplicationCardState();
}

  class _CustomProfileVendorApplicationCardState extends State<CustomProfileVendorApplicationCard> {


  @override
  Widget build(BuildContext context) {
  
    return ProfileVendorApplicationCard(animationController: widget.animationController,);
  }


}
