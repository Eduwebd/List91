import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/ps_api_service.dart';
import '../viewobject/vendor_paypal_token.dart';
import 'Common/ps_repository.dart';

class VendorPaypalTokenRepository extends PsRepository {
  VendorPaypalTokenRepository({
    required PsApiService psApiService,
  }) {
    _psApiService = psApiService;
  }
  String primaryKey = '';
  late PsApiService _psApiService;

  Future<PsResource<VendorPaypalToken>?> getVendorPayPalToken(
    // bool isConnectedToInternet,
    // PsStatus status,
    String loginUserId,
    String? vendorId,
    String headerToken,
  ) async {
    final PsResource<VendorPaypalToken>? _resource = await _psApiService
        .getVendorPaypalToken(loginUserId, vendorId, headerToken);
    
    return _resource;
  
  }
}
