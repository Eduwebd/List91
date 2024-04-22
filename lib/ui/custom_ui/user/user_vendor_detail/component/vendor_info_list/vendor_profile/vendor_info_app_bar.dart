import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile/vendor_info_app_bar.dart';

class CustomUserVendorInfoListViewAppBar extends StatefulWidget {
  const CustomUserVendorInfoListViewAppBar(
      {this.selectedIndex = 0,
      this.showElevation = true,
      this.iconSize = 24,
      required this.items,
      required this.onItemSelected,
      this.chatFlag})
      : assert(items.length >= 2 && items.length <= 5);

  @override
  _UserVendorInfoListViewAppBarState createState() {
    return _UserVendorInfoListViewAppBarState(
        selectedIndexNo: selectedIndex,
        items: items,
        iconSize: iconSize,
        onItemSelected: onItemSelected);
  }

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final List<UserVendorInfoListViewAppBarItem> items;
  final ValueChanged<int> onItemSelected;
  final String? chatFlag;
}

class _UserVendorInfoListViewAppBarState extends State<CustomUserVendorInfoListViewAppBar> {
  _UserVendorInfoListViewAppBarState(
      {required this.items,
      this.iconSize,
      this.selectedIndexNo,
      required this.onItemSelected});

  final double? iconSize;
  List<UserVendorInfoListViewAppBarItem> items;
  int? selectedIndexNo;
  ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return UserVendorInfoListViewAppBar(
        items: widget.items,
        onItemSelected: widget.onItemSelected,
        iconSize: widget.iconSize,
        selectedIndex: widget.selectedIndex,
        showElevation: widget.showElevation,
        );
  }
}



