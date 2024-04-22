import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/order_detail_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class OrderDetailRepository extends PsRepository {
  OrderDetailRepository(
      {required PsApiService psApiService,}) {
    _psApiService = psApiService;
    _orderDetailDao = OrderDetailDao.instance;
  }

  // String primaryKey = 'id';
  late PsApiService _psApiService;
  late OrderDetailDao _orderDetailDao;



  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
      dao: _orderDetailDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getOrderSummary(
        requestPathHolder!.orderId ?? '',
        requestPathHolder.loginUserId ?? 'nologinuser',
        requestPathHolder.languageCode ?? 'en',
      ),
    );
  }
}
