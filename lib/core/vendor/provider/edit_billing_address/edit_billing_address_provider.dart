import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/edit_billing_address_repository.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/common/ps_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../common/ps_provider.dart';

class EditBillingAddressProvider extends PsProvider<ApiStatus> {
  EditBillingAddressProvider({
    required EditBillingAddressRepository? editBillingAddressRepository,
    int limit = 0,
  }) : super(editBillingAddressRepository, limit,
            subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = editBillingAddressRepository;
  }

  String _billingPhoneCode = '';
  bool? _defaultShippingCheck;
  bool? _defaultBillingCheck;
  String get billingPhoneCode => _billingPhoneCode;
  bool? get defaultShippingCheck => _defaultShippingCheck;
  bool? get defaultBillingCheck => _defaultBillingCheck;

  set billingPhoneCode(String value) {
    _billingPhoneCode = value;
    notifyListeners();
  }

  set defaultShippingCheck(bool? value) {
    _defaultShippingCheck = value;
    notifyListeners();
  }

  set defaultBillingCheck(bool? value) {
    _defaultBillingCheck = value;
    notifyListeners();
  }

  EditBillingAddressRepository? _repo;
  Future<PsResource<ApiStatus>?> editBillingAddress({
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
    return _resource;
  }
}
