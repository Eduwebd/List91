import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/vendor_branch_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/vendor_user.dart';
import 'Common/ps_repository.dart';

class VendorBranchRepository extends PsRepository {
  VendorBranchRepository(
      {required PsApiService psApiService, required VendorBranchDao branchDao}) {
    _psApiService = psApiService;
    _branchDao = branchDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late VendorBranchDao _branchDao;

    void sinkUserDetailStream(
      StreamController<PsResource<dynamic>>? userListStream,
      PsResource<VendorUser?> data) {
    userListStream!.sink.add(data);
  }

  Future<dynamic> insert(VendorUser vendorUser) async {
    return _branchDao.insert(primaryKey, vendorUser);
  }

  Future<dynamic> update(VendorUser vendorUser) async {
    return _branchDao.update(vendorUser);
  }

  Future<dynamic> delete(VendorUser vendorUser) async {
    return _branchDao.delete(vendorUser);
  }

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
      dao: _branchDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getVendorBranchList(
          requestBodyHolder!.toMap(),  requestPathHolder!.loginUserId!,requestPathHolder.languageCode!),
    );
  }

  @override
  Future<void> loadNextDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForNextList(
      dao: _branchDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getVendorBranchList(
           requestBodyHolder!.toMap(), requestPathHolder!.loginUserId!, requestPathHolder.languageCode!),
    );
  }


    
}
