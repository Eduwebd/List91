import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../vendor_ui/vendor_applicaion/view/vendor_application_form_container_view.dart';

class CustomVendorApplicationFormContainerView extends StatefulWidget {
      const CustomVendorApplicationFormContainerView({Key? key, required this.flag,required this.vendorUser})
      : super(key: key);

  final String? flag;
  final VendorUser vendorUser; 
  @override
  _CustomVendorApplicationFormContainerViewState createState() => _CustomVendorApplicationFormContainerViewState();
}

class _CustomVendorApplicationFormContainerViewState extends State<CustomVendorApplicationFormContainerView>
    with SingleTickerProviderStateMixin {
 

  @override
  Widget build(BuildContext context) {
   
    return VendorApplicationFormContainerView(flag: widget.flag,vendorUser: widget.vendorUser,);
  }
}
