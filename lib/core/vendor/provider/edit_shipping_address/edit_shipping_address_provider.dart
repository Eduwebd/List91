import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/edit_shipping_address_repository.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/common/ps_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../common/ps_provider.dart';

class EditShippingAddressProvider extends PsProvider<ApiStatus> {
  EditShippingAddressProvider({
    required EditShippingAddressRepository? editShippingAddressRepository,
    int limit = 0,
  }) : super(editShippingAddressRepository, limit,
            subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = editShippingAddressRepository;
  }

  String _shippingPhoneCode = '';
  bool? _defaultShippingCheck;
  bool? _defaultBillingCheck;
  String get shippingPhoneCode => _shippingPhoneCode;
  bool? get defaultShippingCheck => _defaultShippingCheck;
  bool? get defaultBillingCheck => _defaultBillingCheck;

  set shippingPhoneCode(String value) {
    _shippingPhoneCode = value;
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

  EditShippingAddressRepository? _repo;
  Future<PsResource<ApiStatus>?> editShippingAddress({
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
