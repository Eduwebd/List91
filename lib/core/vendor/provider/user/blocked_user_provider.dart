import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../repository/blocked_user_repository.dart';
import '../../viewobject/blocked_user.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../common/ps_provider.dart';

class BlockedUserProvider extends PsProvider<BlockedUser> {
  BlockedUserProvider({
    required BuildContext context,
    this.valueHolder,
    int limit = 0,
  }) : super(initRepo(context), getLimit(context, limit),
            subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  static BlockedUserRepository initRepo(BuildContext context) {
    return BlockedUserRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  static int getLimit(BuildContext context, int limit) {
    if (limit > 0) {
      return limit;
    }

    return Provider.of<PsValueHolder>(context, listen: false)
        .blockItemLoadingLimit!;
  }
  BlockedUserRepository? _repo;
  PsValueHolder? valueHolder;

  PsResource<List<BlockedUser>> get blockedUserList => super.dataList;

  Future<dynamic> deleteUserFromDB(String? loginUserId) async {
    await _repo!.postDeleteUserFromDB(super.dataListStreamController!,
        loginUserId, PsStatus.PROGRESS_LOADING);
  }
}
