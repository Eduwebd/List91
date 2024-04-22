import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile/vendor_social_icon.dart';

class CustomVendorSocialIcon extends StatelessWidget {
  const CustomVendorSocialIcon({
    Key? key,
    this.imageName,
    this.onTap,
  }) : super(key: key);

  final String? imageName;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return VendorSocialIcon(
      imageName: imageName,
      onTap: onTap,
    );
  }
}
