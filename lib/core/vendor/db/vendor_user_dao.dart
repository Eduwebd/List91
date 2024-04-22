import 'package:sembast/sembast.dart';

import '../viewobject/vendor_user.dart';
import 'common/ps_dao.dart';

class VendorUserDao extends PsDao<VendorUser> {
  VendorUserDao._() {
    init(VendorUser());
  }

  static const String STORE_NAME = 'VendorUser';
  final String _primaryKey = 'id';

  // Singleton instance
  static final VendorUserDao _singleton = VendorUserDao._();

  // Singleton accessor
  static VendorUserDao get instance => _singleton;

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
