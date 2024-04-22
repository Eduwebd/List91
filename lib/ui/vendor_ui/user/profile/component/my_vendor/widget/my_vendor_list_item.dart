import 'package:flutter/material.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../../../custom_ui/user/profile/component/my_vendor/widget/my_vendor_approve_info.dart';
import '../../../../../common/ps_ui_widget.dart';
import '../../../../../common/shimmer_item.dart';

class MyVendorListItem extends StatefulWidget {
  const MyVendorListItem(
      {Key? key,
      required this.vendorUser,
      this.animation,
      this.animationController,
      this.isLoading = false,
      this.width})
      : super(key: key);

  final VendorUser vendorUser;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final double? width;

  @override
  State<MyVendorListItem> createState() => _MyVendorListItemState();
}

class _MyVendorListItemState extends State<MyVendorListItem> {
  @override
  Widget build(BuildContext context) {
    widget.animationController!.forward();
    return AnimatedBuilder(
        animation: widget.animationController!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: Utils.isLightMode(context)
                    ? PsColors.text100
                    : PsColors.text50),
          ),
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: 170,
          margin: const EdgeInsets.only(
              bottom: PsDimens.space16,
              left: PsDimens.space8,
              right: PsDimens.space8),
          child: widget.isLoading
              ? const ShimmerItem()
              : InkWell(
                  onTap: () {
                    //  onTap(context);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Stack(children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.only(top: PsDimens.space8),
                              child: SizedBox(
                                width: PsDimens.space74,
                                height: PsDimens.space74,
                                child:Stack(
                                  children: <Widget>[
                                    PsNetworkCircleImageForUser(
                                        photoKey: '',
                                        imagePath:
                                            widget.vendorUser.logo!.imgPath,
                                        boxfit: BoxFit.cover,
                                        onTap: () {
                                          //onDetailClick(context);
                                        },
                                      ),
                                     if ( widget.vendorUser.expiredStatus == PsConst.EXPIRED_NOTI)
                                     Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: PsColors.achromatic900.withOpacity(0.75),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text('Closed',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    color: PsColors.text50)),
                                      )else const SizedBox()

                                  ],
                                )
                              ),
                            ),
                            if (widget.vendorUser.isVendorUser)
                              Positioned(
                                right: -1,
                                bottom: -1,
                                child: Icon(
                                  Icons.verified_user,
                                  color: PsColors.info500,
                                  size: 20,
                                ),
                              ),
                          ]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                                widget.vendorUser.name == ''
                                    ? 'default__user_name'.tr
                                    : '${widget.vendorUser.name}',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          const SizedBox(width: PsDimens.space4),
                          Image.asset(
                            'assets/images/storefont.png',
                            width: 25,
                          ),
                        ],
                      ),
                      if (widget.vendorUser.expiredStatus ==
                          PsConst.EXPIRED_NOTI
                          )
                        Text('Subscription expired',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: PsColors.error500,
                                ))
                      else
                        const SizedBox(),
                      CustomMyVendorApproveInfoWidget(
                        vendorUser: widget.vendorUser,
                      )
                    ],
                  ),
                ),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: widget.animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - widget.animation!.value), 0.0),
                  child: child));
        });
  }
}
