import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/profile/component/my_vendor/my_vendor_vertical_list_view.dart';

class CustomMyVendorVerticalListViewContainer extends StatefulWidget {
  const CustomMyVendorVerticalListViewContainer();
  @override
  State<StatefulWidget> createState() {
    return _CustomMyVendorVerticalListViewContainer();
  }
}

class _CustomMyVendorVerticalListViewContainer
    extends State<CustomMyVendorVerticalListViewContainer>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
  
    return const MyVendorVerticalListViewContainer();
  }
}
