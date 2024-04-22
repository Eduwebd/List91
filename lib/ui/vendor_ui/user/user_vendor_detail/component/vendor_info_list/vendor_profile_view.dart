import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_branch_provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../custom_ui/user/user_vendor_detail/component/vendor_info_list/vendor_branch/vendor_branch_item.dart';
import '../../../../../custom_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile/vendor_link_info.dart';
import '../../../../../custom_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile/vendor_owner_info_widget.dart';
import '../../../../../custom_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile/vendor_social_icon.dart';
import '../../../../item/detail/component/info_widgets/vendor_expired_widget.dart';

class VendorProfileView extends StatefulWidget {
  // const ShopProfileView({
  //   Key? key,
  //   this.animationController,
  // }) : super(key: key);

  // final AnimationController? animationController;

  @override
  State<VendorProfileView> createState() => _VendorProfileViewState();
}

class _VendorProfileViewState extends State<VendorProfileView> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // final Animation<double>? animation = curveAnimation(widget.animationController!);
    final VendorUserDetailProvider provider =
        Provider.of<VendorUserDetailProvider>(context);
    final VendorBranchProvider vendorBranchProvider =
        Provider.of<VendorBranchProvider>(context);

    return provider.hasData
        ? Container(
            // color: Colors.amber,
            padding: const EdgeInsets.only(
                left: PsDimens.space14,
                right: PsDimens.space14,
                bottom: PsDimens.space8,
                top: PsDimens.space6),
            child: SingleChildScrollView(
              // controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (provider.vendorUserDetail.data?.expiredStatus ==
                      PsConst.EXPIRED_NOTI)
                     Padding(
                      padding: const EdgeInsets.only(top: PsDimens.space8),
                      child: VendorExpiredWidget(vendorExpText: 'vendor_expired_text'.tr),
                    )
                  else
                    const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(
                        // left: PsDimens.space14,
                        right: PsDimens.space8,
                        bottom: PsDimens.space14,
                        top: PsDimens.space18),
                    child: Text('vendor_info'.tr,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Utils.isLightMode(context)
                                    ? PsColors.text800
                                    : PsColors.text400,
                                fontSize: 20)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: PsDimens.space6,
                        right: PsDimens.space8,
                        bottom: PsDimens.space8,
                        top: PsDimens.space6),
                    color: PsColors.text50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomVendorOwnerProfilePhoto(),
                        const SizedBox(
                          height: PsDimens.space6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: PsDimens.space14,
                          ),
                          child: Text(
                              provider.vendorUserDetail.data!.description ?? '',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Utils.isLightMode(context)
                                          ? PsColors.primary500
                                          : PsColors.text400,
                                      fontSize: 16)),
                        ),
                        const SizedBox(
                          height: PsDimens.space6,
                        ),
                        CustomVendorLinkInfo(
                          icon: Icons.language,
                          link: provider.vendorUserDetail.data!.website,
                          onTap: () async {
                            if (await canLaunchUrl(Uri.parse(
                                provider.vendorUserDetail.data!.website!))) {
                              await launchUrl(Uri.parse(
                                  provider.vendorUserDetail.data!.website!));
                            } else {
                              throw 'Could not launch ';
                            }
                          },
                        ),
                        CustomVendorLinkInfo(
                          icon: Icons.phone,
                          link: provider.vendorUserDetail.data!.phone,
                          onTap: () async {
                            if (await canLaunchUrl(Uri.parse(
                                'tel://${provider.vendorUserDetail.data!.phone}'))) {
                              await launchUrl(Uri.parse(
                                  'tel://${provider.vendorUserDetail.data!.phone}'));
                            } else {
                              throw 'Could not Call Phone Number 1';
                            }
                          },
                        ),
                        CustomVendorLinkInfo(
                            icon: Icons.location_pin,
                            title: 'shop_info__visit_our_website'.tr,
                            link: provider.vendorUserDetail.data!.address),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            if (provider.vendorUserDetail.data!.facebook != '')
                              CustomVendorSocialIcon(
                                imageName: 'assets/images/Facebook_svg.svg',
                                onTap: () async {
                                  const String url =
                                      'https://www.facebook.com/';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                            if (provider.vendorUserDetail.data!.instagram != '')
                              CustomVendorSocialIcon(
                                imageName: 'assets/images/Instagram_svg.svg',
                                onTap: () async {
                                  const String url =
                                      'https://www.instagram.com/';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                            if (provider.vendorUserDetail.data!.phone != '')
                              CustomVendorSocialIcon(
                                imageName: 'assets/images/WhatsApp_svg.svg',
                                onTap: () async {
                                  final String url =
                                      'whatsapp://send?phone=${provider.vendorUserDetail.data!.phone}';
                                  if (await canLaunchUrl(Uri.parse(
                                      'whatsapp://send?phone=$url'))) {
                                    await launchUrl(Uri.parse(
                                        'whatsapp://send?phone=$url'));
                                  } else {
                                    const String whatsappDownloadUrl =
                                        'https://play.google.com/store/apps/details?id=com.whatsapp';
                                    const String whatsappDownloadUrlIos =
                                        'https://apps.apple.com/us/app/whatsapp-messenger/id310633997';
                                    if (Platform.isIOS) {
                                      if (await canLaunchUrl(
                                          Uri.parse(whatsappDownloadUrlIos))) {
                                        await launchUrl(
                                            Uri.parse(whatsappDownloadUrlIos));
                                      } else {
                                        throw 'Could not launch $whatsappDownloadUrlIos';
                                      }
                                    } else {
                                      if (await canLaunchUrl(
                                          Uri.parse(whatsappDownloadUrl))) {
                                        await launchUrl(
                                            Uri.parse(whatsappDownloadUrl));
                                      } else {
                                        throw 'Could not launch $whatsappDownloadUrl';
                                      }
                                    }
                                    // throw 'Could not send Phone Number 1';
                                  }
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (vendorBranchProvider.hasData)
                    Padding(
                      padding: const EdgeInsets.only(
                          //left: PsDimens.space6,
                          right: PsDimens.space8,
                          bottom: PsDimens.space14,
                          top: PsDimens.space18),
                      child: Text('vendor_branches'.tr,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Utils.isLightMode(context)
                                      ? PsColors.text800
                                      : PsColors.text400,
                                  fontSize: 20)),
                    ),
                  ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          vendorBranchProvider.vendorBranchList.data!.length,

                      /// modifty later
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            CustomVendorBranchItem(
                              vendorBranch: provider.vendorUserDetail.data!,
                              onTap: () {},
                            ),
                            const SizedBox(
                              height: PsDimens.space10,
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
