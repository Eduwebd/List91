
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../repository/vendor_subscription_plan_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/vendor_subscription_plan.dart';
import '../common/ps_provider.dart';

class VendorSubscriptionPlanProvider extends PsProvider<VendorSubscriptionPlan> {
  VendorSubscriptionPlanProvider({
   required BuildContext context, 
    int limit = 0, 
   }) : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  static VendorSubscriptionPlanRepository initRepo(BuildContext context) {
    return VendorSubscriptionPlanRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }

    return Provider.of<PsValueHolder>(context, listen: false)
        .blockItemLoadingLimit!;
  }

   PsResource<List<VendorSubscriptionPlan>> get subscriptionList => super.dataList;
   

}
// SingleChildWidget initVendorSubScriptionPlanProvider(
//   BuildContext context,
//   Function function, {
//   Widget? widget,
// }) {
//   final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
//   final VendorSubscriptionPlanRepository repo = Provider.of<VendorSubscriptionPlanRepository>(context);
//   // final AppLocalization langProvider = Provider.of<AppLocalization>(context);
//   return psInitProvider<VendorSubscriptionPlanProvider>(
//       widget: widget,
//       initProvider: () {
//         return VendorSubscriptionPlanProvider(
//             repo: repo, limit: valueHolder.defaultLoadingLimit!);
//       },
//       onProviderReady: (VendorSubscriptionPlanProvider provider) {
//         provider.loadDataList(
//             requestPathHolder: RequestPathHolder(
//                 loginUserId: Utils.checkUserLoginId(valueHolder),
//                 languageCode: valueHolder.languageCode
//                 ),
//          );
         
//         function(provider);
//       });
// }