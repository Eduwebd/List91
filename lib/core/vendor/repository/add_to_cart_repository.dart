import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/add_to_cart_dao.dart';
import '../db/common/ps_data_source_manager.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class AddToCartRepository extends PsRepository {
  AddToCartRepository(
      {required PsApiService psApiService,
      required AddToCartDao addToCartDao}) {
    _psApiService = psApiService;
    _addToCartDao = addToCartDao;
  }

  late PsApiService _psApiService;
  late AddToCartDao _addToCartDao;

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
      dao: _addToCartDao,
      streamController: streamController,
      finder: Finder(),
      dataConfig: dataConfig,
      serverRequestCallback: () async {
        return _psApiService.getAllItemFromCart(
            requestPathHolder?.loginUserId ?? '',
            requestPathHolder?.languageCode ?? 'en');
      },
    );
  }

  Future<PsResource<ApiStatus>> submitAddToCart(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String? languageCode) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.submitAddToCart(jsonMap, loginUserId, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }

  Future<PsResource<ApiStatus>> deleteItemFromCart(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String? languageCode) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.deleteItemFromCart(jsonMap, loginUserId, languageCode);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<ApiStatus>> completer =
          Completer<PsResource<ApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
