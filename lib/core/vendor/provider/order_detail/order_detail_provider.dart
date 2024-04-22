import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../repository/order_detail_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/order_summary.dart';
import '../common/ps_provider.dart';

class OrderDetailProvider extends PsProvider<OrderSummaryModel> {
  OrderDetailProvider({
    required BuildContext context,
    int limit = 0,
  }) : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

static OrderDetailRepository initRepo(BuildContext context) {
    return OrderDetailRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }

    return Provider.of<PsValueHolder>(context, listen: false)
        .blockItemLoadingLimit!;
  }

  PsResource<OrderSummaryModel> get orderSummaryModel => super.data;
}

// SingleChildWidget initOrderDetailProvider(
//   BuildContext context,
//   Function function, {
//   Widget? widget,
//   // String? orderId,
// }) {
//   final OrderDetailRepository repo =
//       Provider.of<OrderDetailRepository>(context);
//   final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

//   return psInitProvider<OrderDetailProvider>(
//       initProvider: () => OrderDetailProvider(
//             repo: repo,
//           ),
//       onProviderReady: (OrderDetailProvider provider) {
//         final String? loginUserId = Utils.checkUserLoginId(valueHolder);
//         provider.loadData(
//           requestPathHolder: RequestPathHolder(
//             loginUserId: loginUserId,
//             languageCode: valueHolder.languageCode,
//             //  orderId: valueHolder.orderId
//           ),
//         );
//         function(provider);
//       });
// }
