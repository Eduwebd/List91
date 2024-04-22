import 'package:flutter/material.dart';

import '../../../vendor_ui/vendor/view/latest_vendor_veritcal_list_view.dart';

class CustomLatestVendorVerticalListView extends StatefulWidget {
  const CustomLatestVendorVerticalListView();
  @override
  State<StatefulWidget> createState() {
    return _CustomLatestVendorVerticalListView();
  }
}

class _CustomLatestVendorVerticalListView
    extends State<CustomLatestVendorVerticalListView>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
  
    return const LatestVendorVerticalListView();
  }
}
