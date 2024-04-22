import 'package:sembast/sembast.dart';

import '../viewobject/order_summary.dart';
import 'common/ps_dao.dart' show PsDao;

class OrderDetailDao extends PsDao<OrderSummaryModel> {
  OrderDetailDao._() {
    init(OrderSummaryModel());
  }
  static const String STORE_NAME = 'OrderDetail';
  final String _primaryKey = 'order_code';

  // Singleton instance
  static final OrderDetailDao _singleton = OrderDetailDao._();

  // Singleton accessor
  static OrderDetailDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(OrderSummaryModel object) {
    return object.key;
  }

  @override
  Filter getFilter(OrderSummaryModel object) {
    return Filter.equals(_primaryKey, object.key);
  }
}
