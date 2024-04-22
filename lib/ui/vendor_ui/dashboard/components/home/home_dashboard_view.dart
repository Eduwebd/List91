import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_config.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/repository/Common/notification_repository.dart';
import '../../../../../../core/vendor/repository/blog_repository.dart';
import '../../../../../../core/vendor/repository/category_repository.dart';
import '../../../../../../core/vendor/repository/item_location_repository.dart';
import '../../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../../core/vendor/repository/user_unread_message_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/widget_provider_dyanmic.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/delete_task/delete_task_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/viewobject/api_status.dart';
import '../../../common/dialog/confirm_dialog_view.dart';
import '../../../common/dialog/rating_dialog/core.dart';
import '../../../common/dialog/rating_dialog/style.dart';
import '../../../common/dialog/set_user_name_and_pwd_dialog.dart';
import '../../../sort_widget/ps_dynamic_option.dart';

class HomeDashboardViewWidget extends StatefulWidget {
  const HomeDashboardViewWidget(
    this.animationController,
    this.context,
  );

  final AnimationController animationController;
  final BuildContext context;

  @override
  _HomeDashboardViewWidgetState createState() =>
      _HomeDashboardViewWidgetState();
}

class _HomeDashboardViewWidgetState extends State<HomeDashboardViewWidget> {
  PsValueHolder? valueHolder;
  CategoryRepository? repo1;
  late ProductRepository repo2;
  late BlogRepository repo3;
  ItemLocationRepository? repo4;
  NotificationRepository? notificationRepository;
  late UserRepository userRepository;
  late UserProvider userProvider;
  late DeleteTaskProvider deleteTaskProvider;
  Function? onrefresh;
  UserUnreadMessageRepository? userUnreadMessageRepository;
  late AppLocalization langProvider;
  final int count = 8;
  final TextEditingController userInputItemNameTextEditingController =
      TextEditingController();
  final TextEditingController useraddressTextEditingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool androidFusedLocation = true;
  bool locationIsGranted = false;
  bool isFirstTime = true;
  WidgetProviderDynamic? widgetProviderDynamic = WidgetProviderDynamic(
      providerList: <String>[''], widgetList: <String>['']);
  @override
  void dispose() {
    super.dispose();
  }

  final RateMyApp _rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 0,
      minLaunches: 1,
      remindDays: 5,
      remindLaunches: 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (valueHolder!.isUserNameNeeded &&
          valueHolder!.setUserNameAttemptCount! >= 5) {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext contet) {
              return SetUserNameAndPwdDialog(
                userId: valueHolder!.loginUserId!,
              );
            });
      }
      {
        userRepository.replaceSetUserNameAttemptCount(
            valueHolder!.setUserNameAttemptCount! + 1);
      }
      initPlugin();
    });
    if (Platform.isAndroid) {
      _rateMyApp.init().then((_) {
        if (_rateMyApp.shouldOpenDialog) {
          _rateMyApp.showStarRateDialog(
            context,
            title: 'home__menu_drawer_rate_this_app'.tr,
            message: 'rating_popup_dialog_message'.tr,
            ignoreNativeDialog: true,
            actionsBuilder: (BuildContext context, double? stars) {
              return <Widget>[
                TextButton(
                  child: Text(
                    'dialog__ok'.tr,
                  ),
                  onPressed: () async {
                    if (stars != null) {
                      // _rateMyApp.save().then((void v) => Navigator.pop(context));
                      Navigator.pop(context);
                      if (stars < 1) {
                      } else if (stars >= 1 && stars <= 3) {
                        await _rateMyApp
                            .callEvent(RateMyAppEventType.laterButtonPressed);
                        await showDialog<dynamic>(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmDialogView(
                                description: 'rating_confirm_message'.tr,
                                leftButtonText: 'dialog__cancel'.tr,
                                rightButtonText:
                                    'home__menu_drawer_contact_us'.tr,
                                onAgreeTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                    context,
                                    RoutePaths.contactUs,
                                  );
                                },
                              );
                            });
                      } else if (stars >= 4) {
                        await _rateMyApp
                            .callEvent(RateMyAppEventType.rateButtonPressed);
                        if (Platform.isIOS) {
                          Utils.launchAppStoreURL(
                              iOSAppId: valueHolder!.iosAppStoreId,
                              writeReview: true);
                        } else {
                          Utils.launchURL();
                        }
                      }
                    } else {
                      Navigator.pop(context);
                    }
                  },
                )
              ];
            },
            onDismissed: () =>
                _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
            dialogStyle: const DialogStyle(
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 16.0),
            ),
            starRatingOptions: const StarRatingOptions(),
          );
        }
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_authStatus', _authStatus));
  }

  String _authStatus = 'Unknown';
  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      setState(() => _authStatus = '$status');
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        final TrackingStatus status =
            await AppTrackingTransparency.requestTrackingAuthorization();
        setState(() => _authStatus = '$status');
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final String uuid =
        await AppTrackingTransparency.getAdvertisingIdentifier();
    print('UUID: $uuid');
  }

  Future<void> logoutWhenUserIsDeleted(UserProvider userProvider,
      PsValueHolder? valueHolder, DeleteTaskProvider deleteTaskProvider) async {
    if (valueHolder?.loginUserId != null && valueHolder?.loginUserId != '') {
      userProvider
          .checkUserExistsById(
              valueHolder?.loginUserId, valueHolder?.languageCode ?? '')
          .then((dynamic value) {
        final PsResource<ApiStatus> respone = value;
        if (respone.status == PsStatus.ERROR) {
          callLogout(userProvider, deleteTaskProvider);
        }
      });
    }
  }

  dynamic callLogout(
      UserProvider provider, DeleteTaskProvider deleteTaskProvider) async {
    await provider.replaceLoginUserId('');
    //   await provider.replaceOwnerUserId('');
    await provider.replaceLoginUserName('');
    await provider.replaceIsUserNameAndPwdNeeded(false, false);
    await deleteTaskProvider.deleteTask();
    await provider.removeHeaderToken();
    await Utils.saveHeaderInfoAndToken(provider); //restore new header token
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
    await fb_auth.FirebaseAuth.instance.signOut();
    await Navigator.pushNamed(context, RoutePaths.login_container);
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context);
    userRepository = Provider.of<UserRepository>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context);
    deleteTaskProvider = Provider.of<DeleteTaskProvider>(context);

    if (isFirstTime) {
      final WidgetProviderDynamic widgetprovider =
          Utils.psWidgetToProvider(PsConfig.homeWidgetList);
      widgetProviderDynamic!.widgetList!.addAll(widgetprovider.widgetList!);
      widgetProviderDynamic!.providerList!.addAll(widgetprovider.providerList!);
      widgetProviderDynamic!.widgetList!.add('sizedbox_80');

      logoutWhenUserIsDeleted(userProvider, valueHolder, deleteTaskProvider);

      isFirstTime = false;
    }
    widgetProviderDynamic!.widgetList =
        widgetProviderDynamic!.widgetList!.toSet().toList();
    print(widgetProviderDynamic!.widgetList);
    print(widgetProviderDynamic!.providerList);

    return PSDynamicOptionWidget(
      animationController: widget.animationController,
      scrollController: _scrollController,
      widgetList: widgetProviderDynamic!,
    );
  }
}
