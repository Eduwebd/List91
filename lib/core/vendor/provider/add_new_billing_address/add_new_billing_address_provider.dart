import '../../../../core/vendor/viewobject/api_status.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/add_new_billing_address_repository.dart';
import '../../viewobject/common/ps_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../common/ps_provider.dart';

class AddNewBillingAddressProvider extends PsProvider<ApiStatus> {
  AddNewBillingAddressProvider({
    required AddNewBillingAddressRepository? addNewBillingAddressRepository,
    int limit = 0,
  }) : super(addNewBillingAddressRepository, limit,
            subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = addNewBillingAddressRepository;
  }

  String _billingPhoneCode = '';
  bool _defaultShippingCheck = false;
  bool _defaultBillingCheck = false;
  String get billingPhoneCode => _billingPhoneCode;
  bool get defaultShippingCheck => _defaultShippingCheck;
  bool get defaultBillingCheck => _defaultBillingCheck;

  set billingPhoneCode(String value) {
    _billingPhoneCode = value;
    notifyListeners();
  }

  set defaultShippingCheck(bool value) {
    _defaultShippingCheck = value;
    notifyListeners();
  }

  set defaultBillingCheck(bool value) {
    _defaultBillingCheck = value;
    notifyListeners();
  }

  AddNewBillingAddressRepository? _repo;
  Future<PsResource<ApiStatus>?> addNewBillingAddress({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    // print('start fun');
    // print('provider=>$loginUserId');
    // print('provider=>$vendorId');
    // print('provider=>$headerToken');
    // isLoading = true;
    // isConnectedToInternet = await Utils.checkInternetConnectivity();

    final PsResource<ApiStatus>? _resource = await _repo!.postData(
      // isConnectedToInternet, PsStatus.SUCCESS,
      requestBodyHolder: requestBodyHolder,
      requestPathHolder: requestPathHolder,
    );
    print('end fun');
    return _resource;
  }
}
