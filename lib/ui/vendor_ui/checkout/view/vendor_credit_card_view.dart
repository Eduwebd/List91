import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/provider/vendor_item_bought/vendor_item_bought_provider.dart';
import '../../../../core/vendor/viewobject/holder/vendor_item_bought_parameter_holder.dart';
import '../../../../core/vendor/viewobject/vendor_item_bought_status.dart';
import '../../common/base/ps_widget_with_appbar_with_no_provider.dart';
import '../../common/dialog/error_dialog.dart';
import '../../common/dialog/warning_dialog_view.dart';
import '../../common/ps_button_widget.dart';

class VendorCreditCardView extends StatefulWidget {
  const VendorCreditCardView(
      {Key? key,
      this.vendorItemBoughtProvider,
      this.vendorStripePulicKey,
      this.currencyId,
      this.orderId,
      this.paymentAmount,
      this.userId,
      this.vendorId,
      this.itemId,
      this.isSingleCheckout})
      : super(key: key);

  final VendorItemBoughtProvider? vendorItemBoughtProvider;
  final String? vendorStripePulicKey;
  final String? currencyId;

  final String? orderId;
  final String? paymentAmount;

  final String? userId;
  final String? vendorId;
  final String? itemId;
  final String? isSingleCheckout;

  @override
  State<StatefulWidget> createState() {
    return VendorCreditCardViewState();
  }
}

class VendorCreditCardViewState extends State<VendorCreditCardView> {
  CardFieldInputDetails? cardData;

  @override
  void initState() {
    super.initState();
    loadStripe();
  }

  Future<void> loadStripe() async {
    Stripe.publishableKey = widget.vendorStripePulicKey ?? '';
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    Stripe.urlScheme = 'flutterstripe';
    await Stripe.instance.applySettings();
  }

  @override
  Widget build(BuildContext context) {
    return PsWidgetWithAppBarWithNoProvider(
      appBarTitle: 'item_promote__credit_card_title'.tr,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(PsDimens.space16),
            child: CardField(
              autofocus: false,
              onCardChanged: (CardFieldInputDetails? card) async {
                setState(() {
                  cardData = card;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: PsDimens.space12, right: PsDimens.space12),
            child: PSButtonWidget(
              hasShadow: true,
              width: double.infinity,
              titleText: 'credit_card__pay'.tr,
              onPressed: () async {
                if (cardData != null && cardData!.complete) {
                  await PsProgressDialog.showDialog(context);

                  const PaymentMethodParams paymentMethodParams =
                      PaymentMethodParams.card(
                          paymentMethodData: PaymentMethodData(
                              billingDetails: BillingDetails()));

                  final PaymentMethod paymentMethod = await Stripe.instance
                      .createPaymentMethod(params: paymentMethodParams);
                  Utils.psPrint(paymentMethod.id);
                  print('stripe token=>${paymentMethod.id}');

                  await stripeNow(paymentMethod.id,
                      widget.vendorItemBoughtProvider, widget.itemId);
                } else {
                  callWarningDialog(context, 'contact_us__fail'.tr);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  dynamic callPaidAdSubmitApi(
    VendorItemBoughtProvider? vendorItemBoughtProvider,
    String? itemId,
    String token,
  ) async {
    if (await Utils.checkInternetConnectivity()) {
      final PsValueHolder psValueHolder =
          Provider.of<PsValueHolder>(context, listen: false);

      final PsResource<VendorItemBoughtApiStatus>? status =
          await vendorItemBoughtProvider?.vendorItemBought(
              requestBodyHolder: VendorItemBoughtParameterHolder(
                  currencyId: widget.currencyId,
                  isPaystack: PsConst.ZERO,
                  orderId: widget.orderId,
                  paymentAmount: widget.paymentAmount,
                  paymentMethod: PsConst.PAYMENT_STRIPE_METHOD,
                  paymentMethodNonce: token,
                  razorId: '',
                  userId: widget.userId,
                  vendorId: widget.vendorId,
                  isSingleCheckout: widget.isSingleCheckout),
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder),
                  headerToken: psValueHolder.headerToken,
                  languageCode: psValueHolder.languageCode ?? 'en'));
      if (status?.data?.status == null) {
        PsProgressDialog.dismissDialog();
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'check_out_payment_fail_message'.tr,
              );
            });
      } else if (status?.data?.status == 'success') {
        PsProgressDialog.dismissDialog();
        Navigator.of(context).pushReplacementNamed(RoutePaths.orderSuccessful,
            arguments: <String, dynamic>{
              'orderId': widget.orderId,
              'productId': itemId,
              'vendorId': widget.vendorId
            });
      } else {
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

  dynamic stripeNow(
      String token,
      VendorItemBoughtProvider? vendorItemBoughtProvider,
      String? itemId) async {
    callPaidAdSubmitApi(
      vendorItemBoughtProvider,
      itemId,
      token,
    );
  }
}
