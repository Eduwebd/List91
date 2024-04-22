import 'package:sembast/sembast.dart';

import '../viewobject/default_billing_and_shipping.dart';
import 'common/ps_dao.dart';


class DefaultBillingAndShippingDao extends PsDao<DefaultBillingAndShipping>{
  DefaultBillingAndShippingDao._() {
    init(DefaultBillingAndShipping());
  }

  static const String STORE_NAME = 'DefaultBillingAndShipping';
  final String _primaryKey = 'shipping_id';
  // Singleton instance
  static final DefaultBillingAndShippingDao _singleton = DefaultBillingAndShippingDao._();

  // Singleton accessor
  static DefaultBillingAndShippingDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(DefaultBillingAndShipping object) {
    return object.shippingId;
  }

  @override
  Filter getFilter(DefaultBillingAndShipping object) {
    return Filter.equals(_primaryKey, object.shippingId);
  }
}
