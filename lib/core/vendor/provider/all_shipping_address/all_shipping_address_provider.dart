import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../repository/all_shipping_address_repository.dart';
import '../../viewobject/all_shipping_address.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../common/ps_provider.dart';

class AllShippingAddressProvider extends PsProvider<AllShippingAddress> {
  AllShippingAddressProvider({
required BuildContext context,
    int limit = 0,
  }) : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

 static AllShippingAddressRepository initRepo(BuildContext context) {
    return AllShippingAddressRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }

    return Provider.of<PsValueHolder>(context, listen: false)
        .blockItemLoadingLimit!;
  }

  PsResource<List<AllShippingAddress>> get allShippingAddress => dataList;
  int? _values;
  int? get values => _values;
  // ignore: always_specify_types
  set values(val) {
    _values = val;
    notifyListeners();
  }
}

// SingleChildWidget initAllShippingAddressProvider(
//   BuildContext context,
//   Function function, {
//   Widget? widget,
// }) {
//   final AllShippingAddressRepository repo =
//       Provider.of<AllShippingAddressRepository>(context);
//   final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

//   return psInitProvider<AllShippingAddressProvider>(
//       initProvider: () => AllShippingAddressProvider(
//             repo: repo,
//           ),
//       onProviderReady: (AllShippingAddressProvider provider) {
//         final String? loginUserId = Utils.checkUserLoginId(valueHolder);
//         provider.loadDataList(
//           requestPathHolder: RequestPathHolder(
//             loginUserId: loginUserId,
//             languageCode: valueHolder.languageCode,
//           ),
//         );
//         function(provider);
//       });
// }
