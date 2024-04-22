import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile/vendor_link_info.dart';

class CustomVendorLinkInfo extends StatelessWidget {
  const CustomVendorLinkInfo({
    Key? key,
    this.icon,
    this.imageName,
    this.title,
    required this.link,
    this.onTap,
  }) : super(key: key);

  final IconData? icon;
  final String? imageName;
  final String? title;
  final String? link;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return VendorLinkInfo(
      icon: icon,
      imageName: imageName,
      title: title,
      link: link,
      onTap: onTap,
    );
  }
}
