import '../../../../core/vendor/repository/vendor_info_repository.dart';
import '../../../../core/vendor/viewobject/vendor_info.dart';
import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../common/ps_provider.dart';

class VendorInfoProvider extends PsProvider<VendorInfo> {
  VendorInfoProvider({
    required VendorInfoRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);
  PsResource<VendorInfo> get vendorInfo => super.data;

  int _selectedValue = 0;
  int get selectedValue => _selectedValue;

  set selectedValue(dynamic val) => _selectedValue = val;

  void updateSelectedValue(int? value) {
    selectedValue = value;
    notifyListeners();
  }
}
