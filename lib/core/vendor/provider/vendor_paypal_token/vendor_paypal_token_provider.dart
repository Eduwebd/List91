import 'dart:async';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/vendor_paypal_token_repository.dart';
import '../../viewobject/vendor_paypal_token.dart';
import '../common/ps_provider.dart';

class VendorPayPalTokenProvider extends PsProvider<VendorPaypalToken> {
  VendorPayPalTokenProvider({
    required VendorPaypalTokenRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = repo;
  }

  VendorPaypalTokenRepository? _repo;

  Future<PsResource<VendorPaypalToken>?> loadToken(
      String loginUserId, String? vendorId, String headerToken) async {
    print('start fun');
    print('provider=>$loginUserId');
    print('provider=>$vendorId');
    print('provider=>$headerToken');
    // isLoading = true;
    // isConnectedToInternet = await Utils.checkInternetConnectivity();

    final PsResource<VendorPaypalToken>? _resource =
        await _repo!.getVendorPayPalToken(
            // isConnectedToInternet, PsStatus.SUCCESS,
            loginUserId,
            vendorId,
            headerToken);
    return _resource;
  }
}
