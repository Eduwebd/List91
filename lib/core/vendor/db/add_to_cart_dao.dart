import 'package:sembast/sembast.dart';

import '../viewobject/shopping_cart.dart';
import 'common/ps_dao.dart';

class AddToCartDao extends PsDao<ShoppingCart> {
  AddToCartDao._() {
    init(ShoppingCart());
  }

  static const String STORE_NAME = 'ShoppingCart';
  final String _primaryKey = 'id';

  // Singleton instance
  static final AddToCartDao _singleton = AddToCartDao._();

  // Singleton accessor
  static AddToCartDao get instance => _singleton;

  @override
  String? getPrimaryKey(ShoppingCart? object) {
    return '';
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  Filter getFilter(ShoppingCart? object) {
    return Filter.equals(_primaryKey,'');
  }
}
