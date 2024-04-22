import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/user_vendor_detail/view/user_vendor_detail_view.dart';

class CustomUserVendorDetailView extends StatefulWidget {
  const CustomUserVendorDetailView({
    required this.vendorId,
    required this.vendorUserId,
    required this.vendorUserName,
  });
  final String? vendorId;
  final String? vendorUserId;
  final String? vendorUserName;
  @override
  _UserShoreDetailViewState createState() => _UserShoreDetailViewState();
}

class _UserShoreDetailViewState extends State<CustomUserVendorDetailView>
    with TickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
   
    return UserVendorDetailView(
      vendorId: widget.vendorId,
      vendorUserId: widget.vendorUserId,
      vendorUserName: widget.vendorUserName,
    );
  }
}
