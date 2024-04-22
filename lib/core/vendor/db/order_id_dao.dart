import 'package:sembast/sembast.dart';

import '../viewobject/order_id.dart';
import 'common/ps_dao.dart' show PsDao;

class OrderIdDao extends PsDao<OrderId> {
  OrderIdDao._() {
    init(OrderId());
  }
  static const String STORE_NAME = 'OrderId';
  final String _primaryKey = 'id';

  // Singleton instance
  static final OrderIdDao _singleton = OrderIdDao._();

  // Singleton accessor
  static OrderIdDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(OrderId object) {
    return object.orderId;
  }

  @override
  Filter getFilter(OrderId object) {
    return Filter.equals(_primaryKey, object.orderId);
  }
}
