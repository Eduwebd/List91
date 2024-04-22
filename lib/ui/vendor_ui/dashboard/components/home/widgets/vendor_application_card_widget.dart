import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/vendor_application_form_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/ps_button_widget.dart';

class VendorApplicationCard extends StatefulWidget {
  @override
  _VendorApplicationCardState createState() => _VendorApplicationCardState();
}

class _VendorApplicationCardState extends State<VendorApplicationCard> {
  late PsValueHolder psValueHolder;
  late VendorUserProvider provider;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    provider = Provider.of<VendorUserProvider>(context);
    langProvider = Provider.of<AppLocalization>(context);
    
    return SliverToBoxAdapter(
        child: (psValueHolder.loginUserId != '' && psValueHolder.vendorFeatureSetting == PsConst.ONE)
            ? Container(
                margin: const EdgeInsets.only(
                  top: PsDimens.space16,
                  left: PsDimens.space16,
                  right: 16,
                ),
                width: double.infinity,
                // height: 165,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  border: Border.all(
                    color: PsColors.achromatic50,
                    width: 1.0,
                  ),
                  color: Utils.isLightMode(context)
                      ? PsColors.primary50
                      : PsColors.achromatic800,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: PsDimens.space8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: PsDimens.space8, top: PsDimens.space8),
                          child: Text(
                            'become_a_vendor'.tr,
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: PsDimens.space8,
                              right: PsDimens.space8,
                              top: PsDimens.space8),
                          width: PsDimens.space200,
                          child: Text(
                            'become_a_vendor_desc'
                                .tr,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Utils.isLightMode(context) ? PsColors.text600 : PsColors.text300),
                          ),
                        ),
                        Container(
                          height: PsDimens.space60,
                          width: PsDimens.space160,
                          padding: const EdgeInsets.only(
                              bottom: PsDimens.space12,
                              left: PsDimens.space12,
                              right: PsDimens.space12,
                              top: PsDimens.space16),
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
                                      context, RoutePaths.vendorApplicationForm,
                                      arguments:
                                          VendorApplicationFormIntentHolder(
                                        vendorUser: VendorUser(),
                                        flag: PsConst.ADD_NEW_ITEM,
                                      ));
                                     
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
                    Container(
                      padding: const EdgeInsets.only(
                          //bottom: PsDimens.space32,
                          top: PsDimens.space60),
                      child: Image.asset(
                        'assets/images/become_a_vendor.png',
                        width: 125,
                        //height: 120,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox());
  }
}
