import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_provider.dart';
import '../../../../../../core/vendor/repository/vendor_user_repository.dart';
import '../../../../../../core/vendor/viewobject/vendor_user.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/utils/ps_animation.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/vendor_applicaion/component/widget/apply_button.dart';
import '../../../custom_ui/vendor_applicaion/component/widget/document_widget.dart';
import '../../common/ps_textfield_widget.dart';
import 'widget/vendor_currency_widget.dart';

class VendorApplicationFormView extends StatefulWidget {
  const VendorApplicationFormView(
      {Key? key,
      required this.animationController,
      required this.flag,
      required this.vendorUser})
      : super(key: key);
  final AnimationController? animationController;
  final String? flag;
  final VendorUser vendorUser;
  @override
  _VendorApplicationFormViewState createState() =>
      _VendorApplicationFormViewState();
}

class _VendorApplicationFormViewState extends State<VendorApplicationFormView> {
  late VendorUserRepository repository;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController coverLetterController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();

  late AppLocalization langProvider;
  bool bindDataFirstTime = true;
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation =
        curveAnimation(widget.animationController!);
    widget.animationController!.forward();
    repository = Provider.of<VendorUserRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);

    return ChangeNotifierProvider<VendorUserProvider>(
        lazy: false,
        create: (BuildContext context) {
          final VendorUserProvider vendorUserProvider =
              VendorUserProvider(repo: repository);
          vendorUserProvider.loadDataList(
              requestPathHolder: RequestPathHolder(
            loginUserId: Utils.checkUserLoginId(psValueHolder),
            ownerUserId: Utils.checkUserLoginId(psValueHolder),
          ));
          vendorUserProvider.user = widget.vendorUser;
          return vendorUserProvider;
        },
        child: Consumer<VendorUserProvider>(
          builder: (BuildContext context, VendorUserProvider provider,
              Widget? child) {
            if (bindDataFirstTime) {
              if (widget.flag == PsConst.EDIT_ITEM) {
                userNameController.text = widget.vendorUser.name ?? '';
                emailController.text = widget.vendorUser.email ?? '';
                currencyController.text = '';
                storeNameController.text = widget.vendorUser.name ?? '';
                coverLetterController.text =
                    widget.vendorUser.vendorApplication!.coverLetter ?? '';
                documentController.text =
                    widget.vendorUser.vendorApplication!.document ?? '';
              }
              bindDataFirstTime = false;
            }
            return AnimatedBuilder(
                animation: widget.animationController!,
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PsTextFieldWidget(
                        titleText: 'vendor_user_name'.tr,
                        textAboutMe: false,
                        hintText: 'vendor_user_name'.tr,
                        isStar: true,
                        textEditingController: userNameController),
                    PsTextFieldWidget(
                        titleText: 'vendor_user_email'.tr,
                        textAboutMe: false,
                        hintText: 'vendor_user_email'.tr,
                        isStar: true,
                        textEditingController: emailController),
                    PsTextFieldWidget(
                        titleText: 'vendor_name'.tr,
                        textAboutMe: false,
                        height: PsDimens.space120,
                        isStar: true,
                        hintText: 'vendor_name_hint_text'.tr,
                        textEditingController: storeNameController),
                    CustomDocumentWidget(
                      isStar: true,
                      documentController: documentController,
                      flag: widget.flag,
                      vendorUser: widget.vendorUser,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: PsDimens.space14, top: PsDimens.space4),
                      child: Text('Only Zip or PDF file is allowed.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 14,
                                  color: Utils.isLightMode(context)
                                      ? PsColors.text900
                                      : PsColors.text50)),
                    ),
                    const SizedBox(
                      height: PsDimens.space8,
                    ),
                    PsTextFieldWidget(
                        titleText: 'vendor_cover_letter'.tr,
                        textAboutMe: false,
                        height: PsDimens.space160,
                        hintText: 'vendor_cover_letter_hint_text'.tr,
                        isStar: true,
                        textEditingController: coverLetterController),
                    VendorCurrencyWidget(
                      titleText: 'vendor_currency'.tr,
                      hintText: 'vendor_currency_hint'.tr,
                      isStar: true,
                      textEditingController: currencyController,
                      showSuffixIcon: true,
                      readonly: true,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.privacyPolicy);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: (Directionality.of(context) ==
                                    TextDirection.rtl)
                                ? 0
                                : PsDimens.space16,
                            right: (Directionality.of(context) ==
                                    TextDirection.rtl)
                                ? PsDimens.space16
                                : 0,
                            bottom: PsDimens.space10),
                        child: Row(
                          children: <Widget>[
                            Text('vendor_apply_agree_text'.tr,
                                style: Theme.of(context).textTheme.bodyMedium!),
                            const SizedBox(
                              width: PsDimens.space4,
                            ),
                            Text('vendor_privacy_policy'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: PsDimens.space16,
                          top: PsDimens.space16,
                          right: PsDimens.space16,
                          bottom: PsDimens.space40),
                      child: CustomApplyButtonWidget(
                        userNameText: userNameController,
                        emailText: emailController,
                        storeNameText: storeNameController,
                        coverLetterText: coverLetterController,
                        documentText: documentController,
                        flag: widget.flag,
                        vendorUser: widget.vendorUser,
                      ),
                    ),
                    const SizedBox(
                      height: PsDimens.space8,
                    ),
                  ],
                )),
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                      opacity: animation,
                      child: Transform(
                          transform: Matrix4.translationValues(
                              0.0, 100 * (1.0 - animation.value), 0.0),
                          child: child));
                });
          },
        ));
  }
}
