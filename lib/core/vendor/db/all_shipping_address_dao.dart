import 'package:sembast/sembast.dart';

import '../viewobject/all_shipping_address.dart';
import 'common/ps_dao.dart';

class AllShippingAddressDao extends PsDao<AllShippingAddress> {
  AllShippingAddressDao._() {
    init(AllShippingAddress());
  }

  static const String STORE_NAME = 'AllShippingAddress';
  final String _primaryKey = 'id';

  // Singleton instance
  static final AllShippingAddressDao _singleton = AllShippingAddressDao._();

  // Singleton accessor
  static AllShippingAddressDao get instance => _singleton;

 @override
  Filter getFilter(AllShippingAddress object) {
    return Filter.equals(_primaryKey, object.id);
   
  }

  @override
  String? getPrimaryKey(AllShippingAddress object) {
    return object.id;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

 

  // @override
  // Filter getFilter(AllShippingAddress? object) {
  //   return Filter.equals(_primaryKey, object!.id);
  // }
}
