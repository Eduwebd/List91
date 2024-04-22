import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';

import '../db/order_id_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/order_id.dart';
import 'Common/ps_repository.dart';

class OrderIdRepository extends PsRepository {
  OrderIdRepository(
      {required PsApiService psApiService, required OrderIdDao orderIdDao}) {
    _psApiService = psApiService;
orderIdDao=orderIdDao;

  }
  String primaryKey = 'id';
  late PsApiService _psApiService;
 late OrderIdDao orderIdDao;
  // Future<dynamic> insert(AboutUs aboutUs) async {
  //   return _aboutUsDao.insert(primaryKey, aboutUs);
  // }

  // Future<dynamic> update(AboutUs aboutUs) async {
  //   return _aboutUsDao.update(aboutUs);
  // }

  // Future<dynamic> delete(AboutUs aboutUs) async {
  //   return _aboutUsDao.delete(aboutUs);
  // }

  // @override
  // Future<void> loadDataList({
  //   required StreamController<PsResource<List<dynamic>>> streamController,
  //   required int limit,
  //   required int offset,
  //   PsHolder<dynamic>? requestBodyHolder,
  //   RequestPathHolder? requestPathHolder,
  //   required DataConfiguration dataConfig,
  // }) async {
  //   await startResourceSinkingForList(
  //     dao: _aboutUsDao,
  //     streamController: streamController,
  //     dataConfig: dataConfig,
  //     serverRequestCallback: () => _psApiService
  //         .getAboutUsDataList(requestPathHolder?.loginUserId ?? 'nologinuser'),
  //   );
  // }

  // @override
  // Future<void> loadData({
  //   required StreamController<PsResource<dynamic>> streamController,
  //   PsHolder<dynamic>? requestBodyHolder,
  //   RequestPathHolder? requestPathHolder,
  //   // PsHolder<dynamic>? requestBodyHolder,
  //   required DataConfiguration dataConfig,
  // }) async {
  // print('do=>${requestBodyHolder!.toMap()}');
  // print('do=>${requestPathHolder?.headerToken}');
  //   await startResourceSinkingForOne(
  //     dao: _orderIdDao,
  //     streamController: streamController,
  //     dataConfig: dataConfig,
  //     serverRequestCallback: () => _psApiService.getOrderIdForOrder(
  //       requestBodyHolder.toMap(),
  //       requestPathHolder!.loginUserId!,
  //       requestPathHolder.languageCode ?? 'en',
  //       requestPathHolder.headerToken!,
  //     ),
  //   );
  // }
  @override
  Future<PsResource<OrderId>> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {
    print('do=>${requestBodyHolder!.toMap()}');
    print('do=>${requestPathHolder?.headerToken}');
    final PsResource<OrderId> _resource =
        await _psApiService.getOrderIdForOrder(
      requestBodyHolder.toMap(),
      requestPathHolder!.loginUserId!,
      requestPathHolder.languageCode!,
      requestPathHolder.headerToken!,
    );

    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<OrderId>> completer =
          Completer<PsResource<OrderId>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
