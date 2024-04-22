import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/order_id_repository.dart';
import '../../viewobject/order_id.dart';
import '../common/ps_provider.dart';

class GetOrderIdProvider extends PsProvider<OrderId> {
  GetOrderIdProvider({
    OrderIdRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  PsResource<OrderId> get orderId => super.data;
  
  }