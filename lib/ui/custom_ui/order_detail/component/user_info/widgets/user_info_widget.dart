import 'package:flutter/material.dart';

import '../../../../../vendor_ui/order_detail/component/user_info/widgets/user_info_widget.dart';

class CustomUserInfoWidget extends StatelessWidget {
  const CustomUserInfoWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return UserInfoWidget(title: title);
  }
}
