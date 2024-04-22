import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/vendor/search_vendor_provider.dart';
import '../../../../../../core/vendor/repository/vendor_search_repository.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/vendor_search_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../../custom_ui/user/profile/component/my_vendor/widget/my_vendor_list_item.dart';
import '../../../../common/ps_list_header_widget.dart';

class LatestVendorListWidget extends StatefulWidget {
  const LatestVendorListWidget({Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  State<LatestVendorListWidget> createState() => _LatestVendorListWidgetState();
}

class _LatestVendorListWidgetState extends State<LatestVendorListWidget> {
  VendorSearchProvider? vendorSearchProvider;
  VendorSearchRepository? vendorSearchRepository;
  late VendorSearchParameterHolder vendorSearchParameterHolder;
  @override
  Widget build(BuildContext context) {
    vendorSearchParameterHolder = VendorSearchParameterHolder().getAllVendor();
    vendorSearchRepository = Provider.of<VendorSearchRepository>(context);
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<VendorSearchProvider?>(
            lazy: false,
            create: (BuildContext context) {
              vendorSearchProvider = VendorSearchProvider(
                repo: vendorSearchRepository,
              );
              final VendorSearchParameterHolder vendorSearchParameterHolder =
                  VendorSearchParameterHolder().getAllVendor();
              vendorSearchProvider!.loadDataList(
                  requestPathHolder: RequestPathHolder(
                      loginUserId: Utils.checkUserLoginId(valueHolder),
                      ownerUserId: Utils.checkUserLoginId(valueHolder)),
                  requestBodyHolder: vendorSearchParameterHolder);
              
              return vendorSearchProvider;
            }),
      ],
      child: SliverToBoxAdapter(child: Consumer<VendorSearchProvider>(
        builder: (BuildContext context, VendorSearchProvider provider,
            Widget? child) {
          final bool isLoading =
              provider.currentStatus == PsStatus.BLOCK_LOADING;
          final int count = isLoading
              ? valueHolder.loadingShimmerItemCount!
              : provider.vendorList.data!.length;

          return ((provider.currentStatus == PsStatus.BLOCK_LOADING ||
                      provider.hasData) &&
                  valueHolder.vendorFeatureSetting == PsConst.ONE)
              ? Column(children: <Widget>[
                  PsListHeaderWidget(
                    headerName: 'Latest Vendor'.tr,
                    headerDescription: '',
                    viewAllClicked: () {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.latestVendorList,
                      );
                    },
                  ),
                  Container(
                    height: 210,
                    child: ListView.builder(
                        shrinkWrap: false,
                        padding: const EdgeInsets.only(
                            right: PsDimens.space8, left: PsDimens.space8),
                        scrollDirection: Axis.horizontal,
                        itemCount: count,
                        itemBuilder: (BuildContext context, int index) {
                          if (provider.vendorList.data![index].status == '2') {
                            return CustomMyVendorListItem(
                              animation:
                                  curveAnimation(widget.animationController!),
                              animationController: widget.animationController,
                              vendorUser: isLoading
                                  ? VendorUser()
                                  : provider.vendorList.data![index],
                              isLoading: isLoading,
                              width:
                                  MediaQuery.of(context).size.width / 4 * 2.2,
                            );
                          }
                          return const SizedBox();
                        }),
                  ),
                ])
              : const SizedBox();
        },
      )),
    );
  }
}
