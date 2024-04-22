import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../../../../config/ps_config.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_provider.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/repository/vendor_user_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/vendor_application_form_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../../custom_ui/user/profile/component/my_vendor/my_vendor_vertical_list_widget.dart';
import '../../../../common/ps_app_bar_widget.dart';

class MyVendorVerticalListViewContainer extends StatefulWidget {
  const MyVendorVerticalListViewContainer();
  @override
  State<StatefulWidget> createState() {
    return _MyVendorVerticalListViewContainer();
  }
}

class _MyVendorVerticalListViewContainer
    extends State<MyVendorVerticalListViewContainer>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  UserRepository? userRepo;
  VendorUserProvider? vendorUserProvider;
  VendorUserRepository? vendorUserRepository;
  late PsValueHolder valueHolder;
  late AppLocalization langProvider;
  final ScrollController _controller = ScrollController();
  bool isGrid = true;

  @override
  void dispose() {
    animationController!.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController!);

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        vendorUserProvider!.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    userRepo = Provider.of<UserRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    vendorUserRepository = Provider.of<VendorUserRepository>(context);

    print(
        '............................Build UI Again ............................');

    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<UserProvider?>(
              lazy: false,
              create: (BuildContext context) {
                return UserProvider(repo: userRepo, psValueHolder: valueHolder);
              }),
          ChangeNotifierProvider<VendorUserProvider?>(
              lazy: false,
              create: (BuildContext context) {
                vendorUserProvider = VendorUserProvider(
                  repo: vendorUserRepository,
                );

                vendorUserProvider!.loadDataList(
                    requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(valueHolder),
                  ownerUserId: Utils.checkUserLoginId(valueHolder)
                ));
                return vendorUserProvider;
              }),
        ],
        child: Consumer<VendorUserProvider>(builder: (BuildContext context,
            VendorUserProvider userProvider, Widget? child) {
          /**
          * UI SECTION
          */
          return Scaffold(
              appBar: PsAppbarWidget(
                appBarTitle: 'vendor_profile_title'.tr,
                actionWidgets: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add, size: 25),
                    onPressed: () async {
                      await Navigator.pushNamed(
                          context, RoutePaths.vendorApplicationForm,
                          arguments: VendorApplicationFormIntentHolder(
                            vendorUser: VendorUser(),
                            flag: PsConst.ADD_NEW_ITEM,
                          ));
                    },
                  ),
                  if (isGrid)
                    IconButton(
                      icon: const Icon(Icons.grid_view, size: 20),
                      onPressed: () async {
                        setState(() {
                          isGrid = false;
                        });
                      },
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.list, size: 28),
                      onPressed: () async {
                        setState(() {
                          isGrid = true;
                        });
                      },
                    ),
                ],
              ),
              body: CustomScrollView(
                  controller: _controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  slivers: <Widget>[
                    CustomMyVendorVerticalListWidget(
                      animationController: animationController!,
                      controller: _controller,
                      isGrid: isGrid,
                    ),
                  ]));
        }));
  }
}
