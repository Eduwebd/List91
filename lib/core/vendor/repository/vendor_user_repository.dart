import 'dart:async';
import 'dart:io';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/vendor_user_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/vendor_user.dart';
import 'Common/ps_repository.dart';

class VendorUserRepository extends PsRepository {
  VendorUserRepository(
      {required PsApiService psApiService, required VendorUserDao vendorUserDao}) {
    _psApiService = psApiService;
    _vendorUserDao = vendorUserDao;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late VendorUserDao _vendorUserDao;

    void sinkUserDetailStream(
      StreamController<PsResource<dynamic>>? userListStream,
      PsResource<VendorUser?> data) {
    userListStream!.sink.add(data);
  }

  Future<dynamic> insert(VendorUser vendorUser) async {
    return _vendorUserDao.insert(primaryKey, vendorUser);
  }

  Future<dynamic> update(VendorUser vendorUser) async {
    return _vendorUserDao.update(vendorUser);
  }

  Future<dynamic> delete(VendorUser vendorUser) async {
    return _vendorUserDao.delete(vendorUser);
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
      dao: _vendorUserDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getVendorUserList(
          requestPathHolder!.loginUserId!,requestPathHolder.ownerUserId!),
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
      dao: _vendorUserDao,
      streamController: streamController,
      dataConfig: dataConfig,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      serverRequestCallback: () => _psApiService.getVendorUserList(
          requestPathHolder!.loginUserId!, requestPathHolder.ownerUserId!),
    );
  }

   Future<PsResource<VendorUser>> postVendorApplicationSubmit(
    String loginUserId,
    String? email,
    String storeName,
    String coverLetter,
    File? documentFile,
    String vendorApplicationId,
    String currencyId,
    bool isConnectedToInternet,
    PsStatus status,
      {bool isLoadFromServer = true}) async {
    final PsResource<VendorUser> _resource =
        await _psApiService.postVendorApplicationSubmit( loginUserId, email!, storeName,coverLetter,documentFile,vendorApplicationId,currencyId);
    if (_resource.status == PsStatus.SUCCESS) {
          //   await _vendorUserDao
          // .deleteWithFinder(Finder(filter: Filter.equals('id', loginUserId)));
     // await insert(_resource.data!);
      return _resource;
    } else {
      final Completer<PsResource<VendorUser>> completer =
          Completer<PsResource<VendorUser>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
  
  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    final Finder finder =
        Finder(filter: Filter.equals(primaryKey, requestPathHolder?.vendorId));

    await startResourceSinkingForOne(
      dao: _vendorUserDao,
      streamController: streamController,
      finder: finder,
      dataConfig: dataConfig,
      serverRequestCallback: () async {
        return _psApiService.getVendorById(
            requestPathHolder?.loginUserId ?? '',
            requestPathHolder?.vendorId ?? '',
            requestPathHolder?.ownerUserId ?? '');
      },
    );
  }

    // Future<dynamic> getVendorById(StreamController<PsResource<dynamic>>? userListStream,
    //   String? loginUserId, bool isConnectedToInternet, PsStatus status, String id, String ownerUserId,
    //   {bool isLoadFromServer = true}) async {
    // final Finder finder = Finder(filter: Filter.equals('id', loginUserId));
    // sinkUserDetailStream(
    //     userListStream, await _vendorUserDao.getOne(finder: finder, status: status));

    // if (isConnectedToInternet) {
    //   final PsResource<VendorUser> _resource =
    //       await _psApiService.getVendorById(loginUserId ?? '',id,ownerUserId);

    //   if (_resource.status == PsStatus.SUCCESS) {
    //     await _vendorUserDao.deleteAll();
    //     await _vendorUserDao.insert(primaryKey, _resource.data!);
    //     // sinkUserDetailStream(
    //     //     userListStream, await _vendorUserDao.getOne(finder: finder));
    //   }
    // }
    //   }
    
}
