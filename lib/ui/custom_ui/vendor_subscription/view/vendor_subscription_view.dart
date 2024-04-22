import 'package:flutter/material.dart';

import '../../../vendor_ui/vendor_subscription/view/vendor_subscription_view.dart';

class CustomVendorSubscriptionView extends StatelessWidget {
  const CustomVendorSubscriptionView({Key? key,required this.androidKeyList,required this.iosKeyList,required this.vendorId}) : super(key: key);

    final String? androidKeyList;
    final String? iosKeyList;
    final String? vendorId;

  @override
  Widget build(BuildContext context) {
    return   VendorSubscriptionView(
     androidKeyList: androidKeyList,
      iosKeyList: iosKeyList,
      vendorId:vendorId ,
    );
  }
}