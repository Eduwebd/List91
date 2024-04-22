import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import 'widgets/decline_and_agree.dart';
import 'widgets/terms_and_conditions_text_widget.dart';

class AgreeTermsAndConditionWidget extends StatefulWidget {
  @override
  _AgreeTermsAndConditionWidgetState createState() {
    return _AgreeTermsAndConditionWidgetState();
  }
}

class _AgreeTermsAndConditionWidgetState
    extends State<AgreeTermsAndConditionWidget> {
  late AboutUsProvider aboutUsProvider;
  PsValueHolder? psValueHolder;

  @override
  Widget build(BuildContext context) {
    aboutUsProvider = Provider.of<AboutUsProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'terms_and_condition__toolbar_name'.tr,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color:
                    Utils.isLightMode(context) ? PsColors.achromatic900 : PsColors.achromatic50,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        AgreeTermsAndConditionTextWidget(),
        const SizedBox(
          height: 24,
        ),
        AgreeTermsAndConditionDeclineAndAgreeWidget()
      ],
    );
  }
}
