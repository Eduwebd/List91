import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../../../config/ps_config.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_branch_provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_provider.dart';
import '../../../../../../core/vendor/repository/vendor_branch_repository.dart';
import '../../../../../../core/vendor/repository/vendor_user_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/user_vendor_detail/component/detail_info/other_user_store_detail_info_widget.dart';
import '../../../../custom_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile_view.dart';
import '../../../common/ps_app_bar_widget.dart';
import '../component/vendor_info_list/vendor_profile/vendor_info_app_bar.dart';

int _selectedIndex = 0;

class UserVendorDetailView extends StatefulWidget {
  const UserVendorDetailView({
    required this.vendorId,
    required this.vendorUserId,
    required this.vendorUserName,
  });
  final String? vendorId;
  final String? vendorUserId;
  final String? vendorUserName;
  @override
  _UserShoreDetailViewState createState() => _UserShoreDetailViewState();
}

class _UserShoreDetailViewState extends State<UserVendorDetailView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late TabController tabController;
  final PageController _pageController =
      PageController(initialPage: _selectedIndex);
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    tabController = TabController(length: 1, vsync: this);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //_aboutUsProvider.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    tabController.dispose();
    super.dispose();
  }

  ScrollController scrollController = ScrollController();

  PsValueHolder? psValueHolder;
  late AppLocalization langProvider;
  VendorUserProvider? vendorUserProvider;
  VendorUserRepository? vendorUserRepository;
  VendorBranchProvider? vendorBranchProvider;
  VendorBranchRepository? vendorBranchRepository;
  VendorUserDetailProvider? vendorUserDetailProvider;

  @override
  Widget build(BuildContext context) {
    vendorBranchRepository = Provider.of<VendorBranchRepository>(context);
    vendorUserRepository = Provider.of<VendorUserRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    Future<bool> _requestPop() {
      animationController.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    final UserVendorInfoListViewAppBar pageviewAppBar =
        UserVendorInfoListViewAppBar(
      selectedIndex: _selectedIndex,
      onItemSelected: (int index) => setState(() {
        _selectedIndex = index;
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }),
      items: <UserVendorInfoListViewAppBarItem>[
        UserVendorInfoListViewAppBarItem(
            title: 'vendor_profile'.tr,
            mainColor: Theme.of(context).primaryColor),
      ],
    );

    print(
        '............................Build UI Again ............................');

    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<VendorUserDetailProvider>(
              lazy: false,
              create: (BuildContext context) {
                vendorUserDetailProvider = VendorUserDetailProvider(
                    repo: vendorUserRepository, psValueHolder: psValueHolder);
                //  vendorUserProvider.getVendorById(psValueHolder!.loginUserId,'13',psValueHolder!.loginUserId!);
                vendorUserDetailProvider!.loadData(
                    requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder),
                  vendorId: widget.vendorId,
                  ownerUserId: Utils.checkUserLoginId(psValueHolder),
                ));
                return vendorUserDetailProvider!;
              }),
          ChangeNotifierProvider<VendorBranchProvider>(
              lazy: false,
              create: (BuildContext context) {
                final VendorBranchProvider vendorUserProvider =
                    VendorBranchProvider(
                  repo: vendorBranchRepository!,
                );
                vendorUserProvider.vendorBranchParameterHolder.vendorId =
                    widget.vendorId;
                vendorUserProvider.loadDataList(
                    requestBodyHolder:
                        vendorUserProvider.vendorBranchParameterHolder,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder),
                        languageCode: langProvider.currentLocale.languageCode));
                //vendorUserProvider.user = widget.vendorUser;
                return vendorUserProvider;
              }),
        ],
        child: Consumer2<VendorUserDetailProvider, VendorBranchProvider>(
            builder: (BuildContext context,
                VendorUserDetailProvider vendorUserDetailProvider,
                VendorBranchProvider vendorBranchProvider,
                Widget? child) {
          /**
                   * UI SECTION
                   */
          return PopScope(
              canPop: false,
              onPopInvoked: (bool didPop) async {
                if (didPop) {
                  return;
                }
                _requestPop();
              },
              child: Scaffold(
                  appBar: PsAppbarWidget(
                    appBarTitle: widget.vendorUserName!,
                  ),
                  body: Container(
                      child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        CustomOtherUserVendorDetailWidget(
                          animationController: animationController,
                        ),
                        SliverToBoxAdapter(
                          child: pageviewAppBar,
                        ),
                      ];
                    },
                    body: CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      slivers: <Widget>[
                        SliverFillRemaining(
                          child: PageView(
                            controller: _pageController,
                            children: <Widget>[
                              CustomVendorProfileView(),
                            ],
                            onPageChanged: (int index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ))));
        }));
  }
}
