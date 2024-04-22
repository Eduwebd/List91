import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/detail/component/appbar/product_expandable_appbar.dart';

class CustomProductExpandableAppbar extends StatelessWidget {
  const CustomProductExpandableAppbar({required this.isReadyToShowAppBarIcons, this.itemDetailBackIconOnTap});
  final bool isReadyToShowAppBarIcons;
  final Function()? itemDetailBackIconOnTap;

  @override
  Widget build(BuildContext context) {
    return ProductExpandableAppbar(
      itemDetailBackIconOnTap: itemDetailBackIconOnTap,
        isReadyToShowAppBarIcons: isReadyToShowAppBarIcons);
  }
}
