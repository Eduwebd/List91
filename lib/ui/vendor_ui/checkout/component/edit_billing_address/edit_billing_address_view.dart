import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/edit_billing_address/edit_billing_address_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/repository/edit_billing_address_repository.dart';
import '../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/all_billing_address.dart';
import '../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/edit_billing_address_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/checkout/component/shipping_address/widgets/save_address_next_time.dart';
import '../../../common/dialog/success_dialog.dart';
import '../../../common/dialog/warning_dialog_view.dart';
import '../../../common/ps_button_widget_with_round_corner.dart';
import '../../../common/ps_textfield_widget.dart';
import '../../../vendor/view/latest_vendor_filter_view.dart';

class EditBillingAddressView extends StatefulWidget {
  const EditBillingAddressView({Key? key, this.editBillingAddress})
      : super(key: key);
  final AllBillingAddress? editBillingAddress;
  @override
  State<EditBillingAddressView> createState() => _EditBillingAddressViewState();
}

class _EditBillingAddressViewState extends State<EditBillingAddressView> {
  // OrderIdProvider? orderIdProvider;
  PsValueHolder? valueHolder;

  // ProductRepository? repo1;
  EditBillingAddressProvider? editBillingAddressProvider;

  EditBillingAddressRepository? editBillingAddressRepository;
  final TextEditingController phone = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    editBillingAddressRepository =
        Provider.of<EditBillingAddressRepository>(context);
    final List<String>? codeAndNumber =
        widget.editBillingAddress?.billingPhoneNo?.split('-');
    final bool defaultBillingCheck =
        widget.editBillingAddress?.isSaveBillingInfoForNextTime == '1';
    final bool defaultShippingCheck =
        widget.editBillingAddress?.isSaveShippingInfoForNextTime == '1';
    phone.text = codeAndNumber?[1] ?? '';
    final String code = codeAndNumber?[0] ?? '';
    state.text = widget.editBillingAddress?.billingState ?? state.text;
    postalCode.text =
        widget.editBillingAddress?.billingPostalCode ?? postalCode.text;
    firstName.text =
        widget.editBillingAddress?.billingFirstName ?? firstName.text;
    lastName.text = widget.editBillingAddress?.billingLastName ?? lastName.text;
    email.text = widget.editBillingAddress?.billingEmail ?? email.text;
    address.text = widget.editBillingAddress?.billingAddress ?? address.text;
    city.text = widget.editBillingAddress?.billingCity ?? city.text;
    country.text = widget.editBillingAddress?.billingCountry ?? country.text;

    void showMandatoryAlert(String message) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: message,
              onPressed: () {},
            );
          });
    }

    bool shippingValid() {
      const bool isValid = true;
      if (firstName.text.isEmpty) {
        showMandatoryAlert('shipping_need_first_name'.tr);
        return false;
      }
      if (lastName.text.isEmpty) {
        showMandatoryAlert('shipping_need_last_name'.tr);
        return false;
      }

      if (email.text.isEmpty) {
        showMandatoryAlert('shipping_need_email'.tr);
        return false;
      }
      if (EmailValidator.validate(email.text) == false) {
        showMandatoryAlert('warning_dialog__email_format'.tr);
        return false;
      }
      if (phone.text.isEmpty) {
        showMandatoryAlert('shipping_need_phone_number'.tr);

        return false;
      }

      if (address.text.isEmpty) {
        showMandatoryAlert('shipping_need_address'.tr);
        return false;
      }
      if (country.text.isEmpty) {
        showMandatoryAlert('shipping_need_country'.tr);
        return false;
      }
      if (state.text.isEmpty) {
        showMandatoryAlert('shipping_need_state'.tr);
        return false;
      }
      if (city.text.isEmpty) {
        showMandatoryAlert('shipping_need_city'.tr);
        return false;
      }
      if (postalCode.text.isEmpty) {
        showMandatoryAlert('shipping_need_postal'.tr);
        return false;
      }

      return isValid;
    }

    // return Consumer<OrderIdProvider>(builder:
    //     (BuildContext context, OrderIdProvider orderIdProvider, Widget? child) {
    //   phone.text = orderIdProvider.shippingAddressHolder.phone ?? phone.text;
    //   state.text = orderIdProvider.shippingAddressHolder.state ?? state.text;
    //   postalCode.text =
    //       orderIdProvider.shippingAddressHolder.postalCode ?? postalCode.text;
    //   firstName.text =
    //       orderIdProvider.shippingAddressHolder.firstName ?? firstName.text;
    //   lastName.text =
    //       orderIdProvider.shippingAddressHolder.lastName ?? lastName.text;
    //   email.text = orderIdProvider.shippingAddressHolder.email ?? email.text;
    //   address.text =
    //       orderIdProvider.shippingAddressHolder.address ?? address.text;
    //   city.text = orderIdProvider.shippingAddressHolder.city ?? city.text;
    //   country.text =
    //       orderIdProvider.shippingAddressHolder.country ?? country.text;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          Navigator.pop(context, '0');
        }
      },
      child: Scaffold(
          appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
              ),
              title: Text('user_edit_address'.tr,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic900
                          : PsColors.achromatic50,
                      fontWeight: FontWeight.w500,
                      fontSize: PsDimens.space18))),
          body: MultiProvider(
              providers: <SingleChildWidget>[
                ChangeNotifierProvider<EditBillingAddressProvider?>(
                    lazy: false,
                    create: (BuildContext context) {
                      editBillingAddressProvider = EditBillingAddressProvider(
                          editBillingAddressRepository:
                              editBillingAddressRepository);
                      return editBillingAddressProvider;
                    }),
              ],
              child: Consumer<EditBillingAddressProvider>(builder:
                  (BuildContext context,
                      EditBillingAddressProvider editBillingAddressProvider,
                      Widget? child) {
                print('de=>${editBillingAddressProvider.defaultBillingCheck}');
                return ListView(
                  children: <Widget>[
                    PsTextFieldWidget(
                      textEditingController: firstName,
                      isStar: true,
                      titleText: 'edit_profile__first_name'.tr,
                      hintText: 'shipping_address_input_name'.tr,
                    ),
                    PsTextFieldWidget(
                      textEditingController: lastName,
                      isStar: true,
                      titleText: 'edit_profile__last_name'.tr,
                      hintText: 'shipping_address_input_name'.tr,
                    ),
                    PsTextFieldWidget(
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: email,
                      isStar: true,
                      titleText: 'edit_profile__email'.tr,
                      hintText: 'edit_profile__email'.tr,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: PsDimens.space16,
                          top: PsDimens.space12,
                          bottom: PsDimens.space12,
                          right: PsDimens.space16),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('shipping_address_phone'.tr,
                                  style:
                                      Theme.of(context).textTheme.titleMedium!),
                              Text('*',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: PsDimens.space44,
                      margin: const EdgeInsets.symmetric(
                          horizontal: PsDimens.space16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(PsDimens.space4),
                        border: Border.all(color: PsColors.text400),
                      ),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              final dynamic result = await Navigator.pushNamed(
                                  context, RoutePaths.billingPhoneCountryCode);

                              editBillingAddressProvider.billingPhoneCode =
                                  result.countryCode;
                            },
                            child: Container(
                              width: PsDimens.space50,
                              height: PsDimens.space44,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: PsDimens.space12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    editBillingAddressProvider
                                            .billingPhoneCode.isEmpty
                                        ? code
                                        : editBillingAddressProvider
                                            .billingPhoneCode,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Utils.isLightMode(context)
                                ? PsColors.text400
                                : PsColors.text300,
                            width: PsDimens.space1,
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                controller: phone,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                  hintText: 'shipping_address_phone'.tr,
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: PsColors.text400),
                                  contentPadding: const EdgeInsets.only(
                                      right: PsDimens.space12,
                                      left: PsDimens.space12,
                                      bottom: PsDimens.space4),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    PsTextFieldWidget(
                      textEditingController: address,
                      isStar: true,
                      titleText: 'edit_profile__address'.tr,
                      hintText: 'contact_us__contact_message_hint'.tr,
                      height: 124,
                    ),
                    PsTextFieldWidget(
                      textEditingController: country,
                      isStar: true,
                      titleText: 'edit_profile__country_name'.tr,
                      hintText: 'edit_profile__country_name'.tr,
                    ),
                    PsTextFieldWidget(
                      textEditingController: state,
                      isStar: true,
                      titleText: 'edit_profile__state_name'.tr,
                      hintText: 'edit_profile__state_name'.tr,
                    ),
                    PsTextFieldWidget(
                      textEditingController: city,
                      isStar: true,
                      titleText: 'edit_profile__city_name'.tr,
                      hintText: 'edit_profile__city_name'.tr,
                    ),
                    PsTextFieldWidget(
                      keyboardType: TextInputType.number,
                      textEditingController: postalCode,
                      isStar: true,
                      titleText: 'edit_profile__postal_code'.tr,
                      hintText: 'edit_profile__postal_code'.tr,
                    ),
                    CustomSaveAddressNextTimeWidget(
                      checkBoxTitle: 'user_set_default_shipping_address'.tr,
                      onChanged: (bool? p) {
                        editBillingAddressProvider.defaultShippingCheck = p!;
                      },
                      value: editBillingAddressProvider.defaultShippingCheck ??
                          defaultShippingCheck,
                    ),
                    CustomSaveAddressNextTimeWidget(
                      checkBoxTitle: 'user_set_default_billing_address'.tr,
                      onChanged: (bool? p) {
                        editBillingAddressProvider.defaultBillingCheck = p!;
                      },
                      value: editBillingAddressProvider.defaultBillingCheck ??
                          defaultBillingCheck,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: PSButtonWidgetRoundCorner(
                        titleTextColor: PsColors.achromatic50,
                        onPressed: () async {
                          final bool isValid = shippingValid();
                          if (isValid) {
                            await PsProgressDialog.showDialog(context);

                            final EditBillingAddress editBillingAddress =
                                EditBillingAddress(
                              id: widget.editBillingAddress?.id,
                              billingAddress: address.text,
                              billingCity: city.text,
                              billingCountry: country.text,
                              billingEmail: email.text,
                              billingFirstName: firstName.text,
                              billingLastName: lastName.text,
                              billingPhoneNo:
                                  '${editBillingAddressProvider.billingPhoneCode.isEmpty ? code : editBillingAddressProvider.billingPhoneCode}-${phone.text}',
                              billingPostalCode: postalCode.text,
                              billingState: state.text,
                              isSaveBillingInfoForNextTime:
                                  editBillingAddressProvider
                                              .defaultBillingCheck !=
                                          null
                                      ? editBillingAddressProvider
                                                  .defaultBillingCheck ==
                                              true
                                          ? '1'
                                          : '0'
                                      : defaultBillingCheck == true
                                          ? '1'
                                          : '0',
                              isSaveShippingInfoForNextTime:
                                  editBillingAddressProvider
                                              .defaultShippingCheck !=
                                          null
                                      ? editBillingAddressProvider
                                                  .defaultShippingCheck ==
                                              true
                                          ? '1'
                                          : '0'
                                      : defaultShippingCheck == true
                                          ? '1'
                                          : '0',
                            );
                            final PsResource<ApiStatus>? status =
                                await editBillingAddressProvider
                                    .editBillingAddress(
                                        requestBodyHolder: editBillingAddress,
                                        requestPathHolder: RequestPathHolder(
                                            loginUserId:
                                                psValueHolder.loginUserId,
                                            languageCode:
                                                psValueHolder.languageCode));

                            if (status?.data != null) {
                              PsProgressDialog.dismissDialog();
                              showDialog<dynamic>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SuccessDialog(
                                      title: status?.data?.status,
                                      message: status?.data?.message,
                                      onPressed: () {
                                        Navigator.pop(context, '0');
                                      },
                                    );
                                  });
                            }
                            // orderIdProvider.shippingAddressHolder = ShippingAddressHolder(
                            //     firstName: firstName.text,
                            //     lastName: lastName.text,
                            //     email: email.text,
                            //     phone: phone.text,
                            //     code: (orderIdProvider.shippingPhoneCode.isEmpty)
                            //         ? '+95'
                            //         : orderIdProvider.shippingPhoneCode,
                            //     state: state.text,
                            //     address: address.text,
                            //     country: country.text,
                            //     city: city.text,
                            //     postalCode: postalCode.text);
                            // Navigator.pop(context);
                          }
                        },
                        titleText: 'shipping_address_save'.tr,
                      ),
                    )
                  ],
                );
              }))),
    );
  }
}
// }
