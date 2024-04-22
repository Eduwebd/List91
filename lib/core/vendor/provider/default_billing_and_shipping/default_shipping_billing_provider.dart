import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/vendor/repository/default_billing_shipping_repository.dart';

import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/default_billing_and_shipping.dart';
import '../common/ps_provider.dart';

class DefaultBillingAndShippingProvider
    extends PsProvider<DefaultBillingAndShipping> {
  DefaultBillingAndShippingProvider({
   required BuildContext context,
    int limit = 0,
  }) : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);
  
static DefaultBillingAndShippingRepository initRepo(BuildContext context) {
    return DefaultBillingAndShippingRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }

    return Provider.of<PsValueHolder>(context, listen: false)
        .categoryLoadingLimit!;
  }
// PsResource<DefaultBillingAndShipping>? defaultBillingAndShipping;
  PsResource<DefaultBillingAndShipping> get defaultBillingAndShipping =>
      super.data;
  void clearData() {
    defaultBillingAndShipping.data = DefaultBillingAndShipping();
    notifyListeners();
  }
//  set defaultBillingAndShipping(val){
//   defaultBillingAndShipping=val;
//  }
  //   int _selectedValue = 0;
  //  int get selectedValue => _selectedValue;
  // set selectedValue(dynamic val) => _selectedValue = val;
  // void updateSelectedValue(int? value) {
  //   selectedValue = value;
  //   notifyListeners();
  // }
}

// SingleChildWidget initDefaultAndBillingAddressProvider(
//   BuildContext context,
//   Function function, {
//   Widget? widget,
// }) {
//   final DefaultBillingAndShippingRepository repo =
//       Provider.of<DefaultBillingAndShippingRepository>(context);
//   final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

//   return psInitProvider<DefaultBillingAndShippingProvider>(
//       initProvider: () => DefaultBillingAndShippingProvider(
//             repo: repo,
//           ),
//       onProviderReady: (DefaultBillingAndShippingProvider provider) {
//         final String? loginUserId = Utils.checkUserLoginId(valueHolder);
//         provider.loadData(
//           requestPathHolder: RequestPathHolder(
//             loginUserId: loginUserId,
//             languageCode: valueHolder.languageCode,
//           ),
//         );
//         function(provider);
//       });
// }
