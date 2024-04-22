import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../vendor_ui/vendor_applicaion/component/vendor_application_form_view.dart';

class CustomVendorApplicationFormView extends StatefulWidget {
  const CustomVendorApplicationFormView({Key? key, required this.animationController,required this.flag,required this.vendorUser})
      : super(key: key);
  final AnimationController? animationController;
    final String? flag;
    final VendorUser vendorUser; 
  @override
  _CustomVendorApplicationFormViewState createState() =>
      _CustomVendorApplicationFormViewState();
}

class _CustomVendorApplicationFormViewState extends State<CustomVendorApplicationFormView> {

  @override
  Widget build(BuildContext context) {
    
    return VendorApplicationFormView(animationController: widget.animationController,flag: widget.flag,vendorUser: widget.vendorUser,);
  }
}
