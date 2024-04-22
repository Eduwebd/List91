import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../../core/vendor/provider/common/ps_init_provider.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/vendor_user_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/vendor_user.dart';
import '../common/ps_provider.dart';

class VendorUserProvider extends PsProvider<VendorUser> {
  VendorUserProvider({
    required VendorUserRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  PsResource<List<VendorUser>> get vendorUserList => super.dataList;

  // PsResource<VendorUser> get vendorUserData => super.data;

  // PsResource<ApiStatus> _apiStatus =
  //     PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  // PsResource<ApiStatus> get vendorUser => _apiStatus;

  PsResource<VendorUser> _vendorUser =
      PsResource<VendorUser>(PsStatus.NOACTION, '', null);
  String? _currencyId;

  VendorUser? user;
  VendorUserRepository? _repo;
  String? documentPath;
  String? documentName;
  String? userName;
  String? email;
  String? storeName;
  String? coverLetter;

  String? get currencyId => _currencyId;

  set setCurrencyId(String ?value) {
    _currencyId = value;
    notifyListeners();
  }

  Future<dynamic> postVendorApplicationSubmit(
    String loginUserId,
    String? email,
    String storeName,
    String coverLetter,
    File? documentFile,
    String vendorApplicationId,
    String currencyId
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _vendorUser = await _repo!.postVendorApplicationSubmit(
        loginUserId,
        email!,
        storeName,
        coverLetter,
        documentFile,
        vendorApplicationId,
        currencyId,
        isConnectedToInternet,
        PsStatus.PROGRESS_LOADING);

    return _vendorUser;
  }

  // Future<dynamic> getVendorById(String? loginUserId, String id, String ownerUserId
  //  ) async {
  //   isLoading = true;
  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   await _repo!.getVendorById(super.dataStreamController, loginUserId,
  //       isConnectedToInternet, PsStatus.PROGRESS_LOADING, id,ownerUserId);
  // }
}

SingleChildWidget initVendorUserProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final VendorUserRepository repo = Provider.of<VendorUserRepository>(context);
  // final AppLocalization langProvider = Provider.of<AppLocalization>(context);
  return psInitProvider<VendorUserProvider>(
      widget: widget,
      initProvider: () {
        return VendorUserProvider(
            repo: repo, limit: valueHolder.defaultLoadingLimit!);
      },
      onProviderReady: (VendorUserProvider provider) {
        provider.loadDataList(
          requestPathHolder: RequestPathHolder(
              loginUserId: Utils.checkUserLoginId(valueHolder),
              ownerUserId: Utils.checkUserLoginId(valueHolder)),
        );

        function(provider);
      });
}
