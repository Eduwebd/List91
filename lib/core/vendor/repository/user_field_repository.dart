import 'dart:async';

import 'package:sembast/sembast.dart';
import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/user_field_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/user_filed.dart';
import 'Common/ps_repository.dart';

class UserFieldRepository extends PsRepository {
  UserFieldRepository(
      {required this.psApiService, required this.userFieldDao});

  late PsApiService psApiService;
  late UserFieldDao userFieldDao;

  Future<dynamic> insert(UserField userField) async {
    return userFieldDao.insert('', userField);
  }

  Future<dynamic> update(UserField userField) async {
    return userFieldDao.update(userField);
  }

  Future<dynamic> delete(UserField userField) async {
    return userFieldDao.delete(userField);
  }

 @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    // final Finder finder =
    //     Finder(filter: Filter.equals('', requestPathHolder?.itemId));

    await startResourceSinkingForOne(
      dao: userFieldDao,
      streamController: streamController,
      finder: Finder(),
      dataConfig: dataConfig,
      serverRequestCallback: () async {
        return psApiService.getUserField(
          requestPathHolder!.loginUserId ?? 'nologinuser', requestPathHolder.languageCode ?? 'en');
      },
    );
  }


}
