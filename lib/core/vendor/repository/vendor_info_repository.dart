import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/vendor_info_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class VendorInfoRepository extends PsRepository {
  VendorInfoRepository({
    required PsApiService psApiService,
    required VendorInfoDao vendorInfoDao,
  }) {
    _psApiService = psApiService;
    _vendorInfoDao = vendorInfoDao;

  }

  late PsApiService _psApiService;
  late VendorInfoDao _vendorInfoDao;

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
      dao: _vendorInfoDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService
          .getVendorInfo(requestPathHolder!.loginUserId!,requestPathHolder.vendorId!),
    );
  }

  // Future<dynamic> loadColorFromDB(
  //     StreamController<PsResource<dynamic>> colorsListStream,
  //     PsStatus status) async {
  //   colorsListStream.sink.add(await _mobileColorDao.getOne(status: status));
  // }
}
