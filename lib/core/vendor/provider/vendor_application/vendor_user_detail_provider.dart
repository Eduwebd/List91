import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/vendor_user_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';

import '../../viewobject/vendor_user.dart';
import '../common/ps_provider.dart';

class VendorUserDetailProvider extends PsProvider<VendorUser> {
  VendorUserDetailProvider({
    required VendorUserRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
   // _repo = repo;
  }

//  VendorUserRepository? _repo;
  PsValueHolder? psValueHolder;
  PsResource<VendorUser> get vendorUserDetail => super.data;

}


