import 'dart:async';


import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/all_billing_address_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class AllBillingAddressRepository extends PsRepository {
  AllBillingAddressRepository(
      {required PsApiService psApiService,}) {
    _psApiService = psApiService;
    _allBillingAddressDao = AllBillingAddressDao.instance;
  }

  String primaryKey = 'id';
  late PsApiService _psApiService;
  late AllBillingAddressDao _allBillingAddressDao;

  

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
      dao: _allBillingAddressDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getAllBillingAddressList(
          requestPathHolder!.loginUserId!,requestPathHolder.languageCode??'en'),
    );
  }

  
  

    
}


  
  

    

