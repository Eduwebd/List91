import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/choose_profile_widget.dart';

class CustomChooseProfileWidget extends StatelessWidget {
  const CustomChooseProfileWidget({Key? key, required this.flag})
      : super(key: key);

  final String flag;

  @override
  Widget build(BuildContext context) {
    return ChooseProfileWidget(flag: flag);
  }
}
