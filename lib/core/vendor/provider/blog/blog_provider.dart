import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../core/vendor/provider/common/ps_init_provider.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../repository/blog_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/blog.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/blog_parameter_holder.dart';
import '../common/ps_provider.dart';

class BlogProvider extends PsProvider<Blog> {
  BlogProvider({required BuildContext context, int limit = 0})
      : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  static BlogRepository initRepo(BuildContext context) {
    return BlogRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }

    return Provider.of<PsValueHolder>(context, listen: false)
        .blockItemLoadingLimit!;
  }
  PsResource<List<Blog>> get blogList => super.dataList;
  BlogParameterHolder blogParameterHolder = BlogParameterHolder();
}

SingleChildWidget initBlogProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

  return psInitProvider<BlogProvider>(
      widget: widget,
      initProvider: () {
        return BlogProvider(
            context: context, limit: valueHolder.blockSliderLoadingLimit!);
      },
      onProviderReady: (BlogProvider provider) {
        provider.loadDataList(
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(valueHolder),
                languageCode: valueHolder.languageCode),
            requestBodyHolder: provider.blogParameterHolder);
        function(provider);
      });
}
