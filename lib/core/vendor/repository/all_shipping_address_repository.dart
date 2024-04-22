import 'dart:async';
import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/all_shipping_address_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class AllShippingAddressRepository extends PsRepository {
  AllShippingAddressRepository(
      {required PsApiService psApiService, }) {
    _psApiService = psApiService;
    _allShippingAddressDao = AllShippingAddressDao.instance;
  }


  late PsApiService _psApiService;
  late AllShippingAddressDao _allShippingAddressDao;

  //   void sinkUserDetailStream(
  //     StreamController<PsResource<dynamic>>? userListStream,
  //     PsResource<AllShippingAddress?> data) {
  //   userListStream!.sink.add(data);
  // }

  // Future<dynamic> insert(AllShippingAddress allShippingAddress) async {
  //   return _allShippingAddressDao.insert(primaryKey, allShippingAddress);
  // }

  // Future<dynamic> update(AllShippingAddress allShippingAddress) async {
  //   return _allShippingAddressDao.update(allShippingAddress);
  // }

  // Future<dynamic> delete(AllShippingAddress allShippingAddress) async {
  //   return _allShippingAddressDao.delete(allShippingAddress);
  // }

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
      dao: _allShippingAddressDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getAllShippingAddressList(
          requestPathHolder!.loginUserId!,requestPathHolder.languageCode??'en'),
    );
  }

  
  

    
}
