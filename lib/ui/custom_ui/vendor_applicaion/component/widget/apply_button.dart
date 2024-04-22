import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../vendor_ui/vendor_applicaion/component/widget/apply_button.dart';

class CustomApplyButtonWidget extends StatelessWidget {
  const CustomApplyButtonWidget({
    required this.userNameText,
    required this.emailText,
    required this.storeNameText,
    required this.coverLetterText,
    required this.documentText,
    required this.flag,
    required this.vendorUser,
   
  });

  final TextEditingController userNameText, emailText, storeNameText,coverLetterText,documentText;
  final String? flag;
  final VendorUser vendorUser; 


  @override
  Widget build(BuildContext context) {

    return ApplyButtonWidget(
      userNameText: userNameText,
      emailText: emailText,
      storeNameText: storeNameText,
      coverLetterText: coverLetterText,
      documentText: documentText,
      flag: flag!,
    
      vendorUser: vendorUser,
    );
  }
}
