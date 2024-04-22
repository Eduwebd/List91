import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../common/base/ps_widget_with_appbar.dart';
import '../../common/ps_html_text_widget.dart';

class SettingFAQView extends StatefulWidget {
  const SettingFAQView();
  @override
  _SettingFAQViewState createState() {
    return _SettingFAQViewState();
  }
}

class _SettingFAQViewState extends State<SettingFAQView>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }

  PsValueHolder? valueHolder;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    return PsWidgetWithAppBar<AboutUsProvider>(
        appBarTitle: 'setting__faq'.tr,
        initProvider: () {
          return AboutUsProvider(context: context);
        },
        onProviderReady: (AboutUsProvider provider) {
          provider.loadData(
            requestPathHolder: RequestPathHolder(
                    loginUserId: valueHolder!.loginUserId,
                    languageCode: langProvider.currentLocale.languageCode
                  ),
          );
        },
        builder:
            (BuildContext context, AboutUsProvider provider, Widget? child) {
          if (provider.hasData) {
            /**
             * UI SECTION
             */
            return Padding(
              padding: const EdgeInsets.all(PsDimens.space10),
              child: SingleChildScrollView(
                child: PsHTMLTextWidget(
                  htmlData: provider.aboutUs.data!.faqPages!,
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
