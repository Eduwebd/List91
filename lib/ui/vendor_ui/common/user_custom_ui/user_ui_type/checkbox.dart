import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_feild_provider.dart';

import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';

class UserCheckBoxWidget extends StatefulWidget {
  const UserCheckBoxWidget({
    Key? key,
    required this.customField,
  }) : super(key: key);
  final CustomField customField;

  @override
  State<UserCheckBoxWidget> createState() => _UserCheckBoxWidgetState();
}

class _UserCheckBoxWidgetState extends State<UserCheckBoxWidget> {
  late MapEntry<CustomField, SelectedObject> element;

  void _handleOnChange(bool? value) {
    setState(() {
      // _isSelected = value;
      if (value == true) {
        element.value.valueTextController.text = PsConst.ONE;
      } else {
        element.value.valueTextController.text = PsConst.ZERO;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserFieldProvider userFieldProvider =
        Provider.of<UserFieldProvider>(context);
    element = userFieldProvider.textControllerMap.entries.firstWhere(
        (MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == widget.customField.coreKeyId);

    if (element.value.valueTextController.text.isEmpty) {
      element.value.valueTextController.text = PsConst.ZERO;
    }
    print(widget.customField.id);
    return Container(
      margin: const EdgeInsets.only(left: PsDimens.space1),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.customField.id=='123033') 
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: PsDimens.space10),
             child: (element.value.valueTextController.text == PsConst.ONE) ?
             
             Icon(Icons.check_box,color: PsColors.primary500,): Icon(Icons.check_box_outline_blank,color: PsColors.achromatic300,),
           )
            
             else Checkbox(
              activeColor: Theme.of(context).primaryColor,
              value: element.value.valueTextController.text == PsConst.ONE,
              onChanged: _handleOnChange,
            ),
            Text(
              widget.customField.name!.tr,
              style:(widget.customField.id=='123033')?
              Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: PsColors.text400
              ):
               Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              width: PsDimens.space60,
            )
          ]),
    );
  }
}
