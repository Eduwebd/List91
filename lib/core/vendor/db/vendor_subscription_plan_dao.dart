
import 'package:sembast/sembast.dart';

import '../viewobject/vendor_subscription_plan.dart';
import 'common/ps_dao.dart';

class VendorSubscriptionPlanDao extends PsDao<VendorSubscriptionPlan>{

  VendorSubscriptionPlanDao._(){
    init(
      VendorSubscriptionPlan()
    );
  }
 static const String STORE_NAME = 'VendorSubscriptionPlan';
  final String _primaryKey = 'id';

  //singleton instance
  static final VendorSubscriptionPlanDao _singleton = VendorSubscriptionPlanDao._();

 // Singleton accessor
  static VendorSubscriptionPlanDao get instance => _singleton;
  @override
  Filter getFilter(VendorSubscriptionPlan object) {
    return Filter.equals(_primaryKey, object.vendorSubscriptionId);
   
  }

  @override
  String? getPrimaryKey(VendorSubscriptionPlan object) {
    return object.vendorSubscriptionId;
  }

  @override
  String getStoreName() {
return STORE_NAME;
  }
}