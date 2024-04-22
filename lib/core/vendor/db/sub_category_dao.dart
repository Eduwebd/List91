

import 'package:sembast/sembast.dart';

import '../viewobject/sub_category.dart';
import 'common/ps_dao.dart';

class SubCategoryDao extends PsDao<SubCategory> {
  SubCategoryDao._() {
    init(SubCategory());
  }

  static const String STORE_NAME = 'SubCategory';
  final String _primaryKey = 'id';

// Singleton instance
  static final SubCategoryDao _singleton = SubCategoryDao._();

  // Singleton accessor
  static SubCategoryDao get instance => _singleton;
  @override
  String? getPrimaryKey(SubCategory object) {
    return object.id;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  Filter getFilter(SubCategory object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
