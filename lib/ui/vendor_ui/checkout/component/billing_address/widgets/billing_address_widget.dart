import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/add_new_billing_address/add_new_billing_address_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/repository/add_new_billing_address_repository.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/new_billing_address.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../custom_ui/checkout/component/shipping_address/widgets/save_address_next_time.dart';
import '../../../../common/dialog/success_dialog.dart';
import '../../../../common/dialog/warning_dialog_view.dart';
import '../../../../common/ps_button_widget_with_round_corner.dart';
import '../../../../common/ps_textfield_widget.dart';

class BillingAddressWidget extends StatefulWidget {
  const BillingAddressWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BillingAddressWidget> createState() => _BillingAddressWidgetState();
}

class _BillingAddressWidgetState extends State<BillingAddressWidget> {
  PsValueHolder? psValueHolder;

  final TextEditingController phone = TextEditingController();

  final TextEditingController state = TextEditingController();

  final TextEditingController postalCode = TextEditingController();

  final TextEditingController firstName = TextEditingController();

  final TextEditingController lastName = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController address = TextEditingController();

  final TextEditingController city = TextEditingController();

  final TextEditingController country = TextEditingController();

  AddNewBillingAddressProvider? addNewBillingAddressProvider;

  AddNewBillingAddressRepository? addNewBillingAddressRepository;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
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

    bool billingValidate() {
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

    addNewBillingAddressRepository =
        Provider.of<AddNewBillingAddressRepository>(context);

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<AddNewBillingAddressProvider?>(
            lazy: false,
            create: (BuildContext context) {
              addNewBillingAddressProvider = AddNewBillingAddressProvider(
                  addNewBillingAddressRepository:
                      addNewBillingAddressRepository);
              return addNewBillingAddressProvider;
            }),
      ],
      child: Consumer<AddNewBillingAddressProvider>(
        builder: (BuildContext context,
            AddNewBillingAddressProvider addNewBillingAddressProvider,
            Widget? child) {
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
                            style: Theme.of(context).textTheme.titleMedium!),
                        Text('*',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Theme.of(context).primaryColor))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: PsDimens.space44,
                margin:
                    const EdgeInsets.symmetric(horizontal: PsDimens.space16),
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
                        addNewBillingAddressProvider.billingPhoneCode =
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
                              (addNewBillingAddressProvider
                                          .billingPhoneCode.isNotEmpty ||
                                      addNewBillingAddressProvider
                                              .billingPhoneCode !=
                                          '')
                                  ? addNewBillingAddressProvider
                                      .billingPhoneCode
                                  : '+95',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.normal),
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
                textEditingController: postalCode,
                isStar: true,
                keyboardType: TextInputType.number,
                titleText: 'edit_profile__postal_code'.tr,
                hintText: 'edit_profile__postal_code'.tr,
              ),
              CustomSaveAddressNextTimeWidget(
                checkBoxTitle: 'user_set_default_shipping_address'.tr,
                onChanged: (bool? p) {
                  addNewBillingAddressProvider.defaultShippingCheck = p!;
                },
                value: addNewBillingAddressProvider.defaultShippingCheck,
              ),
              CustomSaveAddressNextTimeWidget(
                checkBoxTitle: 'user_set_default_billing_address'.tr,
                onChanged: (bool? p) {
                  addNewBillingAddressProvider.defaultBillingCheck = p!;
                },
                value: addNewBillingAddressProvider.defaultBillingCheck,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PsDimens.space16, vertical: PsDimens.space12),
                child: PSButtonWidgetRoundCorner(
                  onPressed: () async {
                    final bool isValid = billingValidate();
                    if (isValid) {
                      await PsProgressDialog.showDialog(context);

                      final NewBillingAddress newBillingAddress =
                          NewBillingAddress(
                        billingAddress: address.text,
                        billingCity: city.text,
                        billingCountry: country.text,
                        billingEmail: email.text,
                        billingFirstName: firstName.text,
                        billingLastName: lastName.text,
                        billingPhoneNo:
                            '${(addNewBillingAddressProvider.billingPhoneCode.isNotEmpty || addNewBillingAddressProvider.billingPhoneCode != '') ? addNewBillingAddressProvider.billingPhoneCode : '+95'}-${phone.text}',
                        billingPostalCode: postalCode.text,
                        billingState: state.text,
                        isSaveBillingInfoForNextTime:
                            addNewBillingAddressProvider.defaultBillingCheck ==
                                    true
                                ? '1'
                                : '0',
                        isSaveShippingInfoForNextTime:
                            addNewBillingAddressProvider.defaultShippingCheck ==
                                    true
                                ? '1'
                                : '0',
                      );
                      final PsResource<ApiStatus>? status =
                          await addNewBillingAddressProvider
                              .addNewBillingAddress(
                                  requestBodyHolder: newBillingAddress,
                                  requestPathHolder: RequestPathHolder(
                                      loginUserId: psValueHolder?.loginUserId,
                                      languageCode:
                                          psValueHolder?.languageCode ?? 'en'));

                      if (status?.data != null) {
                        PsProgressDialog.dismissDialog();
                        showDialog<dynamic>(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessDialog(
                                title: status?.data?.status,
                                message: status?.data?.message,
                                onPressed: () async {
                                  Navigator.pop(context, '1');
                                },
                              );
                            });
                      }
                    }
                  },
                  titleText: 'shipping_address_save'.tr,
                  titleTextColor: PsColors.achromatic50,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
