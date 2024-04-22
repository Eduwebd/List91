import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/default_billing_shipping_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class DefaultBillingAndShippingRepository extends PsRepository {
  DefaultBillingAndShippingRepository({
    required PsApiService psApiService,
  }) {
    _psApiService = psApiService;
    _defaultBillingAndShippingDao = DefaultBillingAndShippingDao.instance;
  }

  late PsApiService _psApiService;
  late DefaultBillingAndShippingDao _defaultBillingAndShippingDao;

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
      dao: _defaultBillingAndShippingDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getDefaultBillingAndShipping(
          requestPathHolder?.loginUserId,
          requestPathHolder?.languageCode ?? 'en'),
    );
  }
}
