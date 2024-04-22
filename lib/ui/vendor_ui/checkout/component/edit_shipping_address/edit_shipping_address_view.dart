import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/edit_shipping_address/edit_shipping_address_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/repository/edit_shipping_address_repository.dart';
import '../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/all_shipping_address.dart';
import '../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/edit_shipping_address_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/checkout/component/shipping_address/widgets/save_address_next_time.dart';
import '../../../common/dialog/success_dialog.dart';
import '../../../common/dialog/warning_dialog_view.dart';
import '../../../common/ps_button_widget_with_round_corner.dart';
import '../../../common/ps_textfield_widget.dart';
import '../../../vendor/view/latest_vendor_filter_view.dart';

class EditShippingAddressView extends StatefulWidget {
  const EditShippingAddressView({Key? key, this.editShippingAddress})
      : super(key: key);
  final AllShippingAddress? editShippingAddress;
  @override
  State<EditShippingAddressView> createState() =>
      _EditShippingAddressViewState();
}

class _EditShippingAddressViewState extends State<EditShippingAddressView> {
  // OrderIdProvider? orderIdProvider;
  PsValueHolder? valueHolder;

  // ProductRepository? repo1;
  EditShippingAddressProvider? editShippingAddressProvider;

  EditShippingAddressRepository? editShippingAddressRepository;
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
    editShippingAddressRepository =
        Provider.of<EditShippingAddressRepository>(context);
    final List<String>? codeAndNumber =
        widget.editShippingAddress?.shippingPhoneNo?.split('-');
    final bool defaultBillingCheck =
        widget.editShippingAddress?.isSaveBillingInfoForNextTime == '1';
    final bool defaultShippingCheck =
        widget.editShippingAddress?.isSaveShippingInfoForNextTime == '1';
    phone.text = codeAndNumber?[1] ?? '';
    final String code = codeAndNumber?[0] ?? '';
    state.text = widget.editShippingAddress?.shippingState ?? state.text;
    postalCode.text =
        widget.editShippingAddress?.shippingPostalCode ?? postalCode.text;
    firstName.text =
        widget.editShippingAddress?.shippingFirstName ?? firstName.text;
    lastName.text =
        widget.editShippingAddress?.shippingLastName ?? lastName.text;
    email.text = widget.editShippingAddress?.shippingEmail ?? email.text;
    address.text = widget.editShippingAddress?.shippingAddress ?? address.text;
    city.text = widget.editShippingAddress?.shippingCity ?? city.text;
    country.text = widget.editShippingAddress?.shippingCountry ?? country.text;

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
                ChangeNotifierProvider<EditShippingAddressProvider?>(
                    lazy: false,
                    create: (BuildContext context) {
                      editShippingAddressProvider = EditShippingAddressProvider(
                          editShippingAddressRepository:
                              editShippingAddressRepository);
                      return editShippingAddressProvider;
                    }),
              ],
              child: Consumer<EditShippingAddressProvider>(builder:
                  (BuildContext context,
                      EditShippingAddressProvider editShippingAddressProvider,
                      Widget? child) {
                print('de=>${editShippingAddressProvider.defaultBillingCheck}');
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
                                  context, RoutePaths.shippingPhoneCountryCode);

                              editShippingAddressProvider.shippingPhoneCode =
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
                                    editShippingAddressProvider
                                            .shippingPhoneCode.isEmpty
                                        ? code
                                        : editShippingAddressProvider
                                            .shippingPhoneCode,
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
                        editShippingAddressProvider.defaultShippingCheck = p!;
                      },
                      value: editShippingAddressProvider.defaultShippingCheck ??
                          defaultShippingCheck,
                    ),
                    CustomSaveAddressNextTimeWidget(
                      checkBoxTitle: 'user_set_default_billing_address'.tr,
                      onChanged: (bool? p) {
                        editShippingAddressProvider.defaultBillingCheck = p!;
                      },
                      value: editShippingAddressProvider.defaultBillingCheck ??
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
                            final EditShippingAddress editShippingAddress =
                                EditShippingAddress(
                              id: widget.editShippingAddress?.id,
                              shippingAddress: address.text,
                              shippingCity: city.text,
                              shippingCountry: country.text,
                              shippingEmail: email.text,
                              shippingFirstName: firstName.text,
                              shippingLastName: lastName.text,
                              shippingPhoneNo:
                                  '${editShippingAddressProvider.shippingPhoneCode.isEmpty ? code : editShippingAddressProvider.shippingPhoneCode}-${phone.text}',
                              shippingPostalCode: postalCode.text,
                              shippingState: state.text,
                              isSaveBillingInfoForNextTime:
                                  editShippingAddressProvider
                                              .defaultBillingCheck !=
                                          null
                                      ? editShippingAddressProvider
                                                  .defaultBillingCheck ==
                                              true
                                          ? '1'
                                          : '0'
                                      : defaultBillingCheck == true
                                          ? '1'
                                          : '0',
                              isSaveShippingInfoForNextTime:
                                  editShippingAddressProvider
                                              .defaultShippingCheck !=
                                          null
                                      ? editShippingAddressProvider
                                                  .defaultShippingCheck ==
                                              true
                                          ? '1'
                                          : '0'
                                      : defaultShippingCheck == true
                                          ? '1'
                                          : '0',
                            );
                            final PsResource<ApiStatus>? status =
                                await editShippingAddressProvider
                                    .editShippingAddress(
                                        requestBodyHolder: editShippingAddress,
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
