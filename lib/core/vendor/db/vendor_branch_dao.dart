import 'package:sembast/sembast.dart';

import '../viewobject/vendor_user.dart';
import 'common/ps_dao.dart';

class VendorBranchDao extends PsDao<VendorUser> {
  VendorBranchDao._() {
    init(VendorUser());
  }

  static const String STORE_NAME = 'VendorBranch';
  final String _primaryKey = 'id';

  // Singleton instance
  static final VendorBranchDao _singleton = VendorBranchDao._();

  // Singleton accessor
  static VendorBranchDao get instance => _singleton;

  @override
  String? getPrimaryKey(VendorUser? object) {
    return object!.id;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  Filter getFilter(VendorUser? object) {
    return Filter.equals(_primaryKey, object!.id);
  }
}
