import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../repository/reported_item_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/reported_item.dart';
import '../common/ps_provider.dart';

class ReportedItemProvider extends PsProvider<ReportedItem> {
  ReportedItemProvider({
    required BuildContext context,
    this.valueHolder,
    int limit = 0,
  }) : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  

  static ReportedItemRepository initRepo(BuildContext context) {
    return ReportedItemRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }

    return Provider.of<PsValueHolder>(context, listen: false)
        .blockItemLoadingLimit!;
  }
  PsValueHolder? valueHolder;

  PsResource<List<ReportedItem>> get reportedItem => super.dataList;

  String categoryId = '';
}
