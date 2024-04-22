import 'package:sembast/sembast.dart';

import '../viewobject/all_billing_address.dart';
import 'common/ps_dao.dart';

class AllBillingAddressDao extends PsDao<AllBillingAddress> {
  AllBillingAddressDao._() {
    init(AllBillingAddress());
  }

  static const String STORE_NAME = 'AllBillingAddress';
  final String _primaryKey = 'id';

  // Singleton instance
  static final AllBillingAddressDao _singleton = AllBillingAddressDao._();

  // Singleton accessor
  static AllBillingAddressDao get instance => _singleton;

  @override
  String? getPrimaryKey(AllBillingAddress? object) {
    return object!.id;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }



  @override
  Filter getFilter(AllBillingAddress? object) {
    return Filter.equals(_primaryKey, object!.id);
  }
}
