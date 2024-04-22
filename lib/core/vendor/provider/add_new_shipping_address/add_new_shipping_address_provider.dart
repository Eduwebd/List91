
import '../../../../core/vendor/viewobject/api_status.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/Common/add_new_shipping_address_repository.dart';
import '../../viewobject/common/ps_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../common/ps_provider.dart';

class AddNewShippingAddressProvider extends PsProvider<ApiStatus> {
  AddNewShippingAddressProvider({
    required AddNewShippingAddressRepository? addNewShippingAddressRepository,
    int limit = 0,
  }) : super(addNewShippingAddressRepository, limit,
            subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = addNewShippingAddressRepository;
  }
  
  String _shippingPhoneCode = '';
  bool _defaultShippingCheck=false;
  bool _defaultBillingCheck=false;
  String get shippingPhoneCode => _shippingPhoneCode;
  bool get defaultShippingCheck => _defaultShippingCheck;
  bool get defaultBillingCheck => _defaultBillingCheck;

 set shippingPhoneCode (String value){
_shippingPhoneCode = value;
notifyListeners();
  }
  set defaultShippingCheck(bool value){
_defaultShippingCheck = value;
notifyListeners();
  }
   set defaultBillingCheck(bool value){
_defaultBillingCheck = value;
notifyListeners();
  }



  AddNewShippingAddressRepository? _repo;
  Future<PsResource<ApiStatus>?> addNewShippingAddress({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    // print('start fun');
    // print('provider=>$loginUserId');
    // print('provider=>$vendorId');
    // print('provider=>$headerToken');
    // isLoading = true;
    // isConnectedToInternet = await Utils.checkInternetConnectivity();

    final PsResource<ApiStatus>? _resource =
        await _repo!.postData(
            // isConnectedToInternet, PsStatus.SUCCESS,
            requestBodyHolder: requestBodyHolder,
            requestPathHolder: requestPathHolder,);
    return _resource;
  }
}
