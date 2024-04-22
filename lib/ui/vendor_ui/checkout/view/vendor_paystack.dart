import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../../../config/ps_config.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/provider/vendor_item_bought/vendor_item_bought_provider.dart';
import '../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/holder/vendor_item_bought_parameter_holder.dart';
import '../../../../core/vendor/viewobject/vendor_item_bought_status.dart';
import '../../common/base/ps_widget_with_appbar_with_no_provider.dart';
import '../../common/dialog/error_dialog.dart';
import '../../common/dialog/warning_dialog_view.dart';
import '../../common/ps_button_widget.dart';
import '../../common/ps_credit_card_form_for_pay_stack.dart';

class VendorPayStackView extends StatefulWidget {
  const VendorPayStackView(
      {Key? key,
      this.vendorItemBoughtProvider,
      this.currencyId,
      this.orderId,
      this.amount,
      this.userId,
      this.vendorId,
      this.isSingleCheckout,
      this.vendorPayStackKey,
      this.userProvider,
      this.itemDetailProvider})
      : super(key: key);

  final VendorItemBoughtProvider? vendorItemBoughtProvider;
  final String? vendorId;
  final String? currencyId;
  final String? userId;
  final String? amount;
  final String? vendorPayStackKey;
  final String? orderId;
  final String? isSingleCheckout;
  final UserProvider? userProvider;
  final ItemDetailProvider? itemDetailProvider;
  @override
  State<StatefulWidget> createState() {
    return VendorPayStackViewState();
  }
}

PaymentCard callCard(
  String cardNumber,
  String expiryDate,
  String cardHolderName,
  String cvvCode,
) {
  final List<String> monthAndYear = expiryDate.split('/');
  return PaymentCard(
      number: cardNumber,
      expiryMonth: int.parse(monthAndYear[0]),
      expiryYear: int.parse(monthAndYear[1]),
      name: cardHolderName,
      cvc: cvvCode);
}

dynamic callPaidAdSubmitApi(
    BuildContext context,
    String? orderId,
    String? paymentAmount,
    String? currencyId,
    String? vendorId,
    VendorItemBoughtProvider? vendorItemBoughtProvider,
    String? userId,
    String? isSingleCheckout,
    String? token) async {
  if (await Utils.checkInternetConnectivity()) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final PsResource<VendorItemBoughtApiStatus>? status =
        await vendorItemBoughtProvider?.vendorItemBought(
            requestBodyHolder: VendorItemBoughtParameterHolder(
                currencyId: currencyId,
                isPaystack: PsConst.ONE,
                orderId: orderId,
                paymentAmount: paymentAmount,
                paymentMethod: PsConst.PAYMENT_PAY_STACK_METHOD,
                paymentMethodNonce: Platform.isIOS ? token : token,
                razorId: '',
                userId: userId,
                vendorId: vendorId,
                isSingleCheckout: isSingleCheckout),
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(psValueHolder),
                headerToken: psValueHolder.headerToken,
                languageCode: psValueHolder.languageCode ?? 'en'));

    if (status?.data?.status == 'success') {
      PsProgressDialog.dismissDialog();
      Navigator.of(context).pushReplacementNamed(RoutePaths.orderSuccessful,
          arguments: <String, dynamic>{
            'orderId': orderId,
            'vendorId':vendorId
          });
    } else {
      PsProgressDialog.dismissDialog();
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: status?.data?.message,
            );
          });
    }
  } else {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: 'error_dialog__no_internet'.tr,
          );
        });
  }
}

class VendorPayStackViewState extends State<VendorPayStackView> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final PaystackPlugin plugin = PaystackPlugin();
  @override
  void initState() {
    plugin.initialize(publicKey: widget.vendorPayStackKey ?? '');

    super.initState();
  }

  void setError(dynamic error) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: error.toString().tr,
          );
        });
  }

  dynamic callWarningDialog(BuildContext context, String text) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            message: text.tr,
            onPressed: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    dynamic payStackNow(String token) async {
      await PsProgressDialog.showDialog(context);
      callPaidAdSubmitApi(
          context,
          widget.orderId,
          widget.amount,
          widget.currencyId,
          widget.vendorId,
          widget.vendorItemBoughtProvider,
          widget.userId,
          widget.isSingleCheckout,
          token);
    }

    return PsWidgetWithAppBarWithNoProvider(
      appBarTitle: 'item_promote__pay_stack'.tr,
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  height: 175,
                  width: MediaQuery.of(context).size.width,
                  animationDuration: PsConfig.animation_duration,
                  onCreditCardWidgetChange: (dynamic data) {},
                ),
                PsCreditCardFormForPayStack(
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: PsDimens.space12, right: PsDimens.space12),
                  child: PSButtonWidget(
                    hasShadow: true,
                    width: double.infinity,
                    titleText: 'credit_card__pay'.tr,
                    onPressed: () async {
                      if (cardNumber.isEmpty) {
                        callWarningDialog(
                            context, 'warning_dialog__input_number'.tr);
                      } else if (expiryDate.isEmpty) {
                        callWarningDialog(
                            context, 'warning_dialog__input_date'.tr);
                      } else if (cardHolderName.isEmpty) {
                        callWarningDialog(
                            context, 'warning_dialog__input_holder_name'.tr);
                      } else if (cvvCode.isEmpty) {
                        callWarningDialog(
                            context, 'warning_dialog__input_cvv'.tr);
                      } else {
                        if (cardNumber.isEmpty) {
                          callWarningDialog(
                              context, 'warning_dialog__input_number'.tr);
                        } else if (expiryDate.isEmpty) {
                          callWarningDialog(
                              context, 'warning_dialog__input_date'.tr);
                        } else if (cardHolderName.isEmpty) {
                          callWarningDialog(
                              context, 'warning_dialog__input_holder_name'.tr);
                        } else if (cvvCode.isEmpty) {
                          callWarningDialog(
                              context, 'warning_dialog__input_cvv'.tr);
                        } else {
                          bool isLight = Utils.isLightMode(context);

                          if (!isLight) {
                            await ThemeManager.of(context)
                                .setBrightnessPreference(
                                    BrightnessPreference.light);
                          }

                          final Charge charge = Charge()
                            ..amount = (double.parse(Utils.getPriceTwoDecimal(
                                        widget.amount!)) *
                                    100)
                                .round()
                            ..email = widget.userProvider?.user.data!.userEmail
                            ..reference = _getReference()
                            ..currency = widget.itemDetailProvider?.product
                                .itemCurrency!.currencyShortForm!
                            ..card = callCard(cardNumber, expiryDate,
                                cardHolderName, cvvCode);

                          try {
                            final CheckoutResponse response =
                                await plugin.checkout(
                              context,
                              method: CheckoutMethod.card,
                              charge: charge,
                              fullscreen: false,
                            );
                            if (!isLight) {
                              await ThemeManager.of(context)
                                  .setBrightnessPreference(
                                      BrightnessPreference.dark);
                              isLight = true;
                            }
                            if (response.status) {
                              payStackNow(response.reference!);
                            }
                          } catch (e) {
                            print('Check console for error');
                            rethrow;
                          }
                          if (!isLight) {
                            await ThemeManager.of(context)
                                .setBrightnessPreference(
                                    BrightnessPreference.dark);
                          }
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: PsDimens.space40)
              ],
            )),
          ),
        ],
      ),
    );
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    if (creditCardModel != null) {
      setState(() {
        cardNumber = creditCardModel.cardNumber;
        expiryDate = creditCardModel.expiryDate;
        cardHolderName = creditCardModel.cardHolderName;
        cvvCode = creditCardModel.cvvCode;
        isCvvFocused = creditCardModel.isCvvFocused;
      });
    }
  }
}
