import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/vendor_application_form_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/vendor_user_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../../common/dialog/vendor_application_dialog.dart';

class MyVendorApproveInfoWidget extends StatelessWidget {
  const MyVendorApproveInfoWidget({
    Key? key,
    required this.vendorUser,
  }) : super(key: key);

  final VendorUser vendorUser;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.transparent;
    Color textColor = Colors.transparent;
    String vendorInfo = '';

    if (vendorUser.isPendingVendor) {
      textColor = PsColors.warning500;
      backgroundColor = PsColors.warning50;
      vendorInfo = 'profile__waiting_for_approval_blue_mark'.tr;
    } else if (vendorUser.isRejectedVendor) {
      textColor = PsColors.error500;
      backgroundColor = PsColors.error50;
      vendorInfo = 'profile__rejected_blue_mark'.tr;
    } else if (vendorUser.isVendorUser) {
      textColor = PsColors.text800;
      backgroundColor = PsColors.achromatic50;
      vendorInfo = 'vendor_visit'.tr;
    } else {
      textColor = PsColors.text800;
      backgroundColor = PsColors.achromatic50;
      vendorInfo = 'vendor_visit'.tr;
    }
    //  }

    return Column(
      children: <Widget>[
        const SizedBox(height: PsDimens.space4),
        InkWell(
          onTap: () async {
            if (vendorUser.isRejectedVendor) {
              // final dynamic returnData =
              await showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return VendorApplicationDialog(
                      title: 'vendor_reject_title'.tr,
                      message: 'vendor_reject_desc'.tr,
                      icon: Icons.block,
                      btnTitle: 'vendor_reject_btn_title'.tr,
                      onPressed: () async {
                        Navigator.pop(context, true);
                        await Navigator.pushNamed(
                            context, RoutePaths.vendorApplicationForm,
                            arguments: VendorApplicationFormIntentHolder(
                              vendorUser: vendorUser,
                              flag: PsConst.EDIT_ITEM,
                            ));
                      },
                    );
                  });
              // if (returnData != null && returnData) {
              //   final PsValueHolder valueHolder =
              //       Provider.of<PsValueHolder>(context, listen: false);
              //   userProvider.getUser(valueHolder.loginUserId,langProvider!.currentLocale.languageCode);
              // }
            } else if (vendorUser.isPendingVendor) {
              await showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return VendorApplicationDialog(
                      title: 'vendor_pending_title'.tr,
                      icon: Icons.history,
                      message: 'vendor_pending_desc'.tr,
                      btnTitle: 'vendor_pending_btn_title'.tr,
                      onPressed: () {
                        Navigator.pop(context, true);
                        //Navigator.pop(context,true);
                      },
                    );
                  });
            } else {
              Navigator.pushNamed(context, RoutePaths.userVendorDetail,
                  arguments: VendorUserIntentHolder(
                      vendorId: vendorUser.id ?? '',

                      /// modify latear,
                      vendorUserId: vendorUser.ownerUserId,
                      vendorUserName: vendorUser.name));
            }
          },
          /**
           * UI SECTION
           */
          child: Container(
            color: backgroundColor,
            margin: const EdgeInsets.only(
                left: PsDimens.space8,
                right: PsDimens.space8,
                bottom: PsDimens.space8),
            child: Container(
              // margin:const EdgeInsets.only(left:PsDimens.space8,right:PsDimens.space8 ),
              //width: 180,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: vendorUser.isPendingVendor
                        ? PsColors.warning500
                        : vendorUser.isRejectedVendor
                            ? PsColors.error500
                            : PsColors.achromatic100),
              ),
              // padding: const EdgeInsets.only(left:PsDimens.space8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // width: 80,
                    child: Text(vendorInfo,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: textColor)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
