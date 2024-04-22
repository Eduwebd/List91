



import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../viewobject/api_status.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class EditBillingAddressRepository extends PsRepository {
  EditBillingAddressRepository({required PsApiService psApiService}) {
    _psApiService = psApiService;
  }
  String primaryKey = 'billingPhoneNo';
  late PsApiService _psApiService;
  @override
  Future<PsResource<ApiStatus>> postData({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
     
  }) async {
    final PsResource<ApiStatus> _resource =
        await _psApiService.postEditBillingAddress(
            requestBodyHolder!.toMap(),
            requestPathHolder!.loginUserId!,
            requestPathHolder.languageCode ?? 'en');
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
