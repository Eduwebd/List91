import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_feild_provider.dart';

import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';
import '../../ps_textfield_widget.dart';

class UserTextAreaWidget extends StatelessWidget {
  const UserTextAreaWidget({Key? key, required this.customField}) : super(key: key);
  final CustomField customField;
  @override
  Widget build(BuildContext context) {
    final UserFieldProvider userFieldProvider =
        Provider.of<UserFieldProvider>(context);
    final MapEntry<CustomField, SelectedObject> element = userFieldProvider
        .textControllerMap.entries
        .firstWhere((MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == customField.coreKeyId);

    return PsTextFieldWidget(
      // ignore: avoid_bool_literals_in_conditional_expressions
      readonly:(customField.id =='123034' && element.value.valueTextController.text.isEmpty)?true :false ,
      height: 100,
      titleText: customField.name!.tr,
      textAboutMe: false,
      hintText: customField.placeHolder!.tr,
      textEditingController: element.value.valueTextController,
      isStar: customField.isMandatory,
    );
  }
}
