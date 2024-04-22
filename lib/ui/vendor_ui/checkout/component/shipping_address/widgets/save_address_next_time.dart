import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';

class SaveAddressNextTimeWidget extends StatelessWidget {
  const SaveAddressNextTimeWidget(
      {Key? key, required this.checkBoxTitle, this.onChanged, this.value})
      : super(key: key);
  final String checkBoxTitle;
  final void Function(bool?)? onChanged;
  final bool? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: PsDimens.space1),
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(
              unselectedWidgetColor: PsColors.achromatic500,
            ),
            child: Checkbox(
              checkColor: PsColors.achromatic50,

              activeColor: PsColors.primary600,
              value: value,
              //  provider.isAggreTermsAndPolicy,
              onChanged: onChanged,
            ),
          ),
          Flexible(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: PsDimens.space4),
                height: PsDimens.space24,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Directionality.of(context) == TextDirection.ltr
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    checkBoxTitle,
                    // 'Save this address for next time',
                    // 'save_address_next_time'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
