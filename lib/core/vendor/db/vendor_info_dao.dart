import 'package:sembast/sembast.dart';

import '../viewobject/vendor_info.dart';
import 'common/ps_dao.dart';


class VendorInfoDao extends PsDao<VendorInfo>{
  VendorInfoDao._() {
    init(VendorInfo());
  }

  static const String STORE_NAME = 'VendorInfo';
  final String _primaryKey = '';
  // Singleton instance
  static final VendorInfoDao _singleton = VendorInfoDao._();

  // Singleton accessor
  static VendorInfoDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(VendorInfo object) {
    return '';
  }

  @override
  Filter getFilter(VendorInfo object) {
    return Filter.equals(_primaryKey, '');
  }
}
