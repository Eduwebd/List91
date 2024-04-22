import 'package:flutter/material.dart';

import '../../../vendor_ui/vendor/view/latest_vendor_filter_view.dart';

class CustomLatestVendorFilterView extends StatefulWidget {
  const CustomLatestVendorFilterView();

  @override
  State<StatefulWidget> createState() => _LatestVendorFilterState();
}

class _LatestVendorFilterState extends State<CustomLatestVendorFilterView> {

  @override
  Widget build(BuildContext context) {
    return const LatestVendorFilterView();
  }
}
