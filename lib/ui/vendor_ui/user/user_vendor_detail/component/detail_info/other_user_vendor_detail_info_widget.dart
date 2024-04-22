import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/user/user_vendor_detail/component/detail_info/widgets/other_user_vendor_banner_photo.dart';
import '../../../../../custom_ui/user/user_vendor_detail/component/detail_info/widgets/other_user_vendor_item_count.dart';
import '../../../../../custom_ui/user/user_vendor_detail/component/detail_info/widgets/other_user_vendor_joined_datetime_widget.dart';
import '../../../../../custom_ui/user/user_vendor_detail/component/detail_info/widgets/other_user_vendor_logo_photo.dart';

class OtherUserVendorDetailWidget extends StatefulWidget {
  const OtherUserVendorDetailWidget({
    Key? key,
    this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  State<OtherUserVendorDetailWidget> createState() =>
      _OtherUserStoreDetailWidgetState();
}

class _OtherUserStoreDetailWidgetState
    extends State<OtherUserVendorDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final Animation<double>? animation =
        curveAnimation(widget.animationController!);
//  final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return SliverToBoxAdapter(child: Consumer<VendorUserDetailProvider>(builder:
        (BuildContext context, VendorUserDetailProvider provider,
            Widget? child) {
      if (provider.vendorUserDetail.data != null) {
        widget.animationController!.forward();
        return AnimatedBuilder(
            animation: widget.animationController!,
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomOtherUserVendorBannerPhoto(),
                    const SizedBox(height: PsDimens.space12),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: PsDimens.space16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  CustomOtherUserVendorLogoPhoto(),
                                  if (provider
                                      .vendorUserDetail.data!.isVendorUser)
                                    Positioned(
                                      right: -1,
                                      bottom: -1,
                                      child: Icon(
                                        Icons.verified_user,
                                        color: PsColors.info500,
                                        size: 20,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: PsDimens.space8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: PsDimens.space14),
                                  Text(
                                    provider.vendorUserDetail.data!.name ?? '',
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: PsDimens.space8),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: PsDimens.space32, right: PsDimens.space32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomOtherUserVendorItemCount(),
                      CustomOtherUserVendorJoinDateTimeWidget()
                    ],
                  ),
                ),
              ],
            ),
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                  opacity: animation!,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 100 * (1.0 - animation.value), 0.0),
                      child: child));
            });
      } else {
        return const SizedBox();
      }
    }));
  }
}
