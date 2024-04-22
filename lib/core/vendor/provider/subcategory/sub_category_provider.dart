import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../repository/sub_category_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/holder/sub_category_parameter_holder.dart';
import '../../viewobject/sub_category.dart';
import '../common/ps_provider.dart';

class SubCategoryProvider extends PsProvider<SubCategory> {
  SubCategoryProvider({
    required BuildContext context,
    this.psValueHolder,
    int limit = 0,
  }) : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  static SubCategoryRepository initRepo(BuildContext context) {
    return SubCategoryRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }

    return Provider.of<PsValueHolder>(context, listen: false)
        .blockItemLoadingLimit!;
  }

 
  PsValueHolder? psValueHolder;
  bool isChecked = false;
  String subcatId = '';
  String isSubscribe = '';
  String categoryId = '';

  PsResource<List<SubCategory>> get subCategoryList => super.dataList;

  ProductParameterHolder subCategoryByCatIdParamenterHolder =
      ProductParameterHolder().getLatestParameterHolder();
  SubCategoryParameterHolder subCategoryParameterHolder =
      SubCategoryParameterHolder().getLatestParameterHolder();

  bool subscriptionMode = false;
  List<String?> subscribeList = <String?>[];
  List<String?> unsubscribeListWithMB = <String?>[];
  List<String?> tempList = <String?>[];    
  bool needToAddToTempList = true;

}
