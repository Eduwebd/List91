import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../../custom_ui/user/profile/component/my_vendor/widget/my_vendor_list_item.dart';
import '../../../../common/ps_list_header_widget.dart';

class MyVendorHorizontalListWidget extends StatelessWidget {
  const MyVendorHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return SliverToBoxAdapter(child: Consumer<VendorUserProvider>(
      builder:
          (BuildContext context, VendorUserProvider provider, Widget? child) {
        print('Current Status: ${provider.currentStatus}');
        print('Data Count: ${provider.vendorUserList.data?.length ?? 0}');
        final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;

        final int count = isLoading
            ? valueHolder.loadingShimmerItemCount!
            : provider.vendorUserList.data!.length;

        return ((provider.currentStatus == PsStatus.BLOCK_LOADING ||
                    provider.hasData) &&
                valueHolder.vendorFeatureSetting == PsConst.ONE)
            ? Column(children: <Widget>[
                PsListHeaderWidget(
                  headerName: 'List91'.tr,
                  headerDescription: '',
                  viewAllClicked: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.myVendorList,
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
                        return CustomMyVendorListItem(
                          animation: curveAnimation(animationController!),
                          animationController: animationController,
                          vendorUser: isLoading
                              ? VendorUser()
                              : provider.vendorUserList.data![index],
                          isLoading: isLoading,
                          width: MediaQuery.of(context).size.width / 4 * 2.2,
                        );
                      }),
                ),
              ])
            : const SizedBox();
      },
    ));
  }
}
