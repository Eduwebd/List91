import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/vendor_user_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class VendorSearchRepository extends PsRepository {
  VendorSearchRepository(
      {required PsApiService psApiService, required VendorUserDao vendorUserDao}) {
    _psApiService = psApiService;
    _vendorUserDao = vendorUserDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late VendorUserDao _vendorUserDao;

  @override
  Future<void> loadDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
      dao: _vendorUserDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getVendorSearchList(
          requestPathHolder!.loginUserId!,requestBodyHolder!.toMap(),limit,offset),
    );
  }

  // @override
  // Future<void> loadNextDataList({
  //   required StreamController<PsResource<List<dynamic>>> streamController,
  //   required int limit,
  //   required int offset,
  //   PsHolder<dynamic>? requestBodyHolder,
  //   RequestPathHolder? requestPathHolder,
  //   required DataConfiguration dataConfig,
  // }) async {
  //   await startResourceSinkingForNextList(
  //     dao: _vendorUserDao,
  //     streamController: streamController,
  //     dataConfig: dataConfig,
  //     loadingStatus: PsStatus.PROGRESS_LOADING,
  //     serverRequestCallback: () => _psApiService.getVendorUserList(
  //         requestPathHolder!.loginUserId!, requestPathHolder.ownerUserId!),
  //   );
  // }

  // @override
  // Future<void> loadData({
  //   required StreamController<PsResource<dynamic>> streamController,
  //   PsHolder<dynamic>? requestBodyHolder,
  //   RequestPathHolder? requestPathHolder,
  //   required DataConfiguration dataConfig,
  // }) async {
  //   final Finder finder =
  //       Finder(filter: Filter.equals(primaryKey, requestPathHolder?.vendorId));

  //   await startResourceSinkingForOne(
  //     dao: _vendorUserDao,
  //     streamController: streamController,
  //     finder: finder,
  //     dataConfig: dataConfig,
  //     serverRequestCallback: () async {
  //       return _psApiService.getVendorById(
  //           requestPathHolder?.loginUserId ?? '',
  //           requestPathHolder?.vendorId ?? '',
  //           requestPathHolder?.ownerUserId ?? '');
  //     },
  //   );
  // }    
}
