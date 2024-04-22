import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../../../custom_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile/vendor_link_info.dart';
import '../../../../../common/ps_ui_widget.dart';

class VendorBranchItem extends StatelessWidget {
  const VendorBranchItem({
    Key? key,
    required this.vendorBranch,
    this.onTap,
  }) : super(key: key);

  final VendorUser vendorBranch;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: PsDimens.space6,
          right: PsDimens.space8,
          bottom: PsDimens.space8,
          top: PsDimens.space6),
      color: PsColors.text50,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(children: <Widget>[
                    Container(
                      child: SizedBox(
                        width: PsDimens.space80,
                        height: PsDimens.space80,
                        child: PsNetworkCircleImageForUser(
                          photoKey: '',
                          imagePath: vendorBranch.logo!.imgPath,
                          boxfit: BoxFit.cover,
                          onTap: () {
                            //onDetailClick(context);
                          },
                        ),
                      ),
                    ),
                    if (vendorBranch.isVendorUser)
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
                  const SizedBox(width: PsDimens.space8),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(vendorBranch.name ?? '',
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: PsDimens.space4),
                      ],
                    ),
                  ),
                ],
              ),
              //           MaterialButton(
              //   height: 40,
              //   minWidth: 40,
              //  color: PsColors.achromatic50,
              //   child: Text(
              //     'View Store'.tr,
              //     style: Theme.of(context).textTheme.labelLarge?.copyWith(
              //         color: Utils.isLightMode(context) ? PsColors.text800 : PsColors.achromatic800, fontWeight: FontWeight.normal),
              //   ),
              //   shape: RoundedRectangleBorder(side: BorderSide(color: PsColors.text100),borderRadius: BorderRadius.circular(5.0)),
              //   onPressed: onTap as void Function(),
              // ),
            ],
          ),
          Text(vendorBranch.address ?? '',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.primary500
                      : PsColors.text400,
                  fontSize: 16)),
          CustomVendorLinkInfo(
            icon: Icons.phone,
            link: vendorBranch.phone,
            onTap: () async {
              if (await canLaunchUrl(
                  Uri.parse('tel://${vendorBranch.phone}'))) {
                await launchUrl(Uri.parse('tel://${vendorBranch.phone}'));
              } else {
                throw 'Could not Call Phone Number 1';
              }
            },
          ),
          CustomVendorLinkInfo(
              icon: Icons.location_pin,
              title: 'shop_info__visit_our_website'.tr,
              link: vendorBranch.address),
        ],
        // ),
      ),
    );
  }
}
