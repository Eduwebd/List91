import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/vendor_item_bought_status.dart';
import 'Common/ps_repository.dart';

class VendorItemBoughtRepository extends PsRepository {
  VendorItemBoughtRepository({required PsApiService psApiService}) {
    _psApiService = psApiService;
  }
  String primaryKey = 'id';
  late PsApiService _psApiService;

  @override
  Future<PsResource<VendorItemBoughtApiStatus>> postData({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    final PsResource<VendorItemBoughtApiStatus> _resource =
        await _psApiService.postVendorItemBought(
            requestBodyHolder!.toMap(),
            requestPathHolder!.loginUserId!,
            requestPathHolder.languageCode ?? 'en',
            requestPathHolder.headerToken!);
    if (_resource.status == PsStatus.SUCCESS) {
      return _resource;
    } else {
      final Completer<PsResource<VendorItemBoughtApiStatus>> completer =
          Completer<PsResource<VendorItemBoughtApiStatus>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
