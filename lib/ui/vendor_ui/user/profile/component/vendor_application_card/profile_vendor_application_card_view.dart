
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/vendor_application_form_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/ps_button_widget.dart';


class ProfileVendorApplicationCard extends StatelessWidget {
  const ProfileVendorApplicationCard({Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    final VendorUserProvider  provider = Provider.of<VendorUserProvider>(context, listen: true);
    final Animation<double>? animation = curveAnimation(animationController!);
    return SliverToBoxAdapter(
        child: AnimatedBuilder(
          animation: animationController!,
          child: (provider.currentStatus == PsStatus.SUCCESS &&
                 !provider.hasData && valueHolder.vendorFeatureSetting == PsConst.ONE)
              ? Container(
                margin: const EdgeInsets.only(
                  top: PsDimens.space16,
                  left: PsDimens.space14,
                  right: 14,
                ),
                width: double.infinity,
                // height: 165,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  border: Border.all(
                    color: PsColors.achromatic100,
                    width: 1.0,
                  ),
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic50
                      : PsColors.achromatic800,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/profile_vendor_shop.png',
                          width: 110,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(
                                right: PsDimens.space8,
                              ),
                              child: Text(
                                'vendor_profile_become_vendor'.tr,
                                textAlign: TextAlign.right,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Utils.isLightMode(context) ? PsColors.text800 : PsColors.text100),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  right: PsDimens.space8, top: PsDimens.space8),
                              width: PsDimens.space220,
                              child: Text(
                                'venodr_profile_desc'
                                    .tr,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Utils.isLightMode(context) ? PsColors.text600 : PsColors.text400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: PsDimens.space12,
                          left: PsDimens.space12,
                          right: PsDimens.space12,
                          top: PsDimens.space4),
                      child: PSButtonWidget(
                        colorData: Theme.of(context).primaryColor,
                        hasShadow: false,

                        ///width:PsDimens.space100,
                        titleText: 'Become a Vendor'.tr,
                        onPressed: () async {
                          if (await Utils.checkInternetConnectivity()) {
                            Utils.navigateOnUserVerificationView(context,
                                () async {
                              await Navigator.pushNamed(
                                context,
                                RoutePaths.vendorApplicationForm,arguments: VendorApplicationFormIntentHolder(
                              vendorUser: VendorUser(),
                              flag: PsConst.ADD_NEW_ITEM,
                            )
                              );
                            });
                          } else {
                            showDialog<dynamic>(
                                context: context,
                                builder: (BuildContext context) {
                                  return ErrorDialog(
                                    message: 'error_dialog__no_internet'.tr,
                                  );
                                });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            
              : const SizedBox(),
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
                opacity: animation!,
                child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 100 * (1.0 - animation.value), 0.0),
                    child: child));
          }));
  ///  }));
  }
}
