
import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/vendor_item_bought_repository.dart';
import '../../viewobject/common/ps_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../../viewobject/vendor_item_bought_status.dart';
import '../common/ps_provider.dart';

class VendorItemBoughtProvider extends PsProvider<VendorItemBoughtApiStatus> {
  VendorItemBoughtProvider({
    required VendorItemBoughtRepository? vendorItemBoughtRepository,
    int limit = 0,
  }) : super(vendorItemBoughtRepository, limit,
            subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = vendorItemBoughtRepository;
  }

  VendorItemBoughtRepository? _repo;
  Future<PsResource<VendorItemBoughtApiStatus>?> vendorItemBought({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    // print('start fun');
    // print('provider=>$loginUserId');
    // print('provider=>$vendorId');
    // print('provider=>$headerToken');
    // isLoading = true;
    // isConnectedToInternet = await Utils.checkInternetConnectivity();

    final PsResource<VendorItemBoughtApiStatus>? _resource =
        await _repo!.postData(
            // isConnectedToInternet, PsStatus.SUCCESS,
            requestBodyHolder: requestBodyHolder,
            requestPathHolder: requestPathHolder);
    return _resource;
  }
}
