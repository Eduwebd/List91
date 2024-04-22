import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../core/vendor/provider/common/ps_init_provider.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../repository/about_us_repository.dart';
import '../../viewobject/about_us.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../common/ps_provider.dart';

class AboutUsProvider extends PsProvider<AboutUs> {
  AboutUsProvider({
    required BuildContext context,
    int limit = 0,
  }) : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);
 
  PsResource<AboutUs> get aboutUs => super.data;

  static AboutUsRepository initRepo(BuildContext context) {
    return AboutUsRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }

    return Provider.of<PsValueHolder>(context, listen: false)
        .blockItemLoadingLimit!;
  }

}

SingleChildWidget initAboutUsProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<AboutUsProvider>(
      initProvider: () => AboutUsProvider(
          context: context
          ),
      onProviderReady: (AboutUsProvider provider) {
        provider.loadData(
          requestPathHolder: RequestPathHolder(
              loginUserId: valueHolder.loginUserId,
              languageCode: valueHolder.languageCode),
        );
        function(provider);
      });
}
