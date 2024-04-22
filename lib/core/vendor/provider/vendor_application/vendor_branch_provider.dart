import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/vendor_branch_repository.dart';
import '../../viewobject/holder/vendor_branch_parameter_holder.dart';
import '../../viewobject/vendor_user.dart';
import '../common/ps_provider.dart';

class VendorBranchProvider extends PsProvider<VendorUser> {
  VendorBranchProvider({
    required VendorBranchRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
   // _repo = repo;
  }

  VendorBranchParameterHolder vendorBranchParameterHolder =
      VendorBranchParameterHolder().getVendorParameterHolder();
      
  PsResource<List<VendorUser>> get vendorBranchList => super.dataList;

  // PsResource<VendorUser> get vendorUserData => super.data;

  // PsResource<ApiStatus> _apiStatus =
  //     PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  // PsResource<ApiStatus> get vendorUser => _apiStatus;

  // PsResource<VendorUser> _vendorUser =
  //     PsResource<VendorUser>(PsStatus.NOACTION, '', null);




  // dynamic daoSubscription;

  // @override
  // void dispose() {
  //   if (daoSubscription != null) {
  //     daoSubscription.cancel();
  //   }
  //   isDispose = true;
  //   super.dispose();
  // }




  // Future<dynamic> getVendorById(String? loginUserId, String id, String ownerUserId
  //  ) async {
  //   isLoading = true;
  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   await _repo!.getVendorById(super.dataStreamController, loginUserId,
  //       isConnectedToInternet, PsStatus.PROGRESS_LOADING, id,ownerUserId);
  // }


}

