import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/order_id/order_id_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/add_to_cart_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../../core/vendor/viewobject/product_relation.dart';
import '../../../../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../../../../custom_ui/item/detail/component/sticky_bottom/buy_action/widgets/detail_summary.dart';
import '../../../../../../vendor_ui/common/dialog/confirm_dialog_view.dart';
import '../../../../../common/dialog/check_item_dialog.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/ps_button_widget_with_round_corner.dart';
import 'widgets/buy_button_widget.dart';
import 'widgets/quantity_widget.dart';

class BuyAction extends StatefulWidget {
  const BuyAction({
    Key? key,
  }) : super(key: key);

  @override
  State<BuyAction> createState() => _BuyActionState();
}

class _BuyActionState extends State<BuyAction> {
  late ItemDetailProvider itemDetailProvider;
  late OrderIdProvider orderIdProvider;
  late AddToCartProvider addToCartProvider;

  late PsValueHolder psValueHolder;
  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    orderIdProvider = Provider.of<OrderIdProvider>(context);
    itemDetailProvider = Provider.of<ItemDetailProvider>(context);
    addToCartProvider = Provider.of<AddToCartProvider>(context);

    final String currencyId =
        itemDetailProvider.itemDetail.data?.vendorUser?.currencyId ?? '';

    itemDetailProvider.product.productRelation?.forEach(
      (ProductRelation element) {
        if (element.coreKeyId == 'ps-itm00046') {
          itemDetailProvider.quantity =
              int.tryParse(element.selectedValues![0].value.toString());
        }
      },
    );

    return IgnorePointer(
      ignoring: itemDetailProvider.product.isSoldOutItem ||
          itemDetailProvider.product.vendorUser?.expiredStatus ==
              PsConst.EXPIRED_NOTI,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: PSButtonWidgetRoundCorner(
                titleText: 'product_buy_now'.tr,
                colorData: Utils.isLightMode(context)
                    ? PsColors.achromatic100
                    : PsColors.achromatic700,
                titleTextColor: itemDetailProvider.product.isSoldOutItem ||
                        itemDetailProvider.product.vendorUser?.expiredStatus ==
                            PsConst.EXPIRED_NOTI
                    ? PsColors.achromatic400
                    : Utils.isLightMode(context)
                        ? PsColors.achromatic800
                        : PsColors.achromatic50,
                onPressed: () {
                  orderIdProvider.count = 1;
                  if (currencyId == '') {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return CheckOutDialog(
                            title: 'vendor_set_default_currency'.tr,
                            message:
                                'vendor_set_default_currency_description'.tr,
                          );
                        });
                  } else {
                    _showBottomSheet(context, true);
                  }
                },
              )),
              const SizedBox(width: PsDimens.space10),
              Expanded(
                  child: PSButtonWidgetRoundCorner(
                titleText: 'add_to_cart'.tr,
                colorData: itemDetailProvider.product.isSoldOutItem ||
                        itemDetailProvider.product.vendorUser?.expiredStatus ==
                            PsConst.EXPIRED_NOTI
                    ? Utils.isLightMode(context)
                        ? PsColors.achromatic100
                        : PsColors.achromatic700
                    : PsColors.primary500,
                titleTextColor: itemDetailProvider.product.isSoldOutItem ||
                        itemDetailProvider.product.vendorUser?.expiredStatus ==
                            PsConst.EXPIRED_NOTI
                    ? PsColors.achromatic400
                    : PsColors.achromatic50,
                onPressed: () {
                  orderIdProvider.count = 1;
                  if (currencyId == '') {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return CheckOutDialog(
                            title: 'vendor_set_default_currency'.tr,
                            message:
                                'vendor_set_default_currency_description'.tr,
                          );
                        });
                  } else {
                    _showBottomSheet(context, false);
                  }
                },
              )),
            ],
          )),
    );
  }

  void _showBottomSheet(BuildContext context, bool isBuyNow) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.maxFinite,
          height: 300,
          padding: const EdgeInsets.all(PsDimens.space6),
          decoration: BoxDecoration(
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic50
                  : PsColors.achromatic800,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(PsDimens.space10),
                  topRight: Radius.circular(PsDimens.space10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                child: Container(
                  width: PsDimens.space40,
                  height: PsDimens.space4,
                  margin: const EdgeInsets.only(bottom: PsDimens.space10),
                  decoration: BoxDecoration(
                    color: PsColors.achromatic200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              //// Summary
              CustomDetailSummary(
                product: itemDetailProvider.product,
                quantity: itemDetailProvider.quantity,
              ),

              const SizedBox(height: PsDimens.space4),

              /// Quantity Title
              Text('transaction_detail__qty'.tr,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic900
                          : PsColors.achromatic50)),

              const SizedBox(height: PsDimens.space4),
              Selector<OrderIdProvider, int?>(
                  selector: (_, OrderIdProvider provider) => provider.count,
                  builder: (_, int? count, __) {
                    final int qty = count ?? 0;
                    return Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if ((itemDetailProvider.product.isSoldOutItem !=
                                        true ||
                                    itemDetailProvider.quantity != null) &&
                                (itemDetailProvider.quantity != null &&
                                    orderIdProvider.count.toDouble() > 1)) {
                              orderIdProvider.decrement();
                            }
                          },
                          child: QuantityWidget(
                              icon: Icons.remove,
                              color:
                                  (itemDetailProvider.product.isSoldOutItem ||
                                          qty == 1)
                                      ? Utils.isLightMode(context)
                                          ? PsColors.achromatic100
                                          : PsColors.achromatic600
                                      : PsColors.primary500),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PsDimens.space10),
                          child: Text(
                            count.toString(),
                            style: Theme.of(context).textTheme.titleLarge!,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if ((itemDetailProvider.product.isSoldOutItem !=
                                        true ||
                                    itemDetailProvider.quantity != null) &&
                                (itemDetailProvider.quantity != null &&
                                    itemDetailProvider.quantity!.toDouble() >
                                        orderIdProvider.count.toDouble()))
                              orderIdProvider.increment();
                          },
                          child: QuantityWidget(
                              icon: Icons.add,
                              color:
                                  (itemDetailProvider.product.isSoldOutItem ||
                                          qty >= itemDetailProvider.quantity!)
                                      ? Utils.isLightMode(context)
                                          ? PsColors.achromatic100
                                          : PsColors.achromatic600
                                      : PsColors.primary500),
                        ),
                      ],
                    );
                  }),

              const SizedBox(height: PsDimens.space16),

              if (isBuyNow)
                BuyButtonWidget(
                  onPressed: () {
                    if (itemDetailProvider.product.isSoldOutItem == true) {
                    } else if (itemDetailProvider.quantity == null) {
                      Navigator.of(context).pop();
                      showDialog<dynamic>(
                          context: context,
                          builder: (BuildContext context) {
                            return ErrorDialog(
                              message:
                                  'you_are_unable_to_purchase_this_item'.tr,
                            );
                          });
                    } else {
                      Navigator.of(context).pop();
                      final String discountPrice = (double.parse(
                                  itemDetailProvider.product.originalPrice
                                      .toString()) -
                              double.parse(itemDetailProvider
                                  .product.currentPrice
                                  .toString()))
                          .toStringAsFixed(2)
                          .toString();

                      final String subTotal = (double.parse(itemDetailProvider
                                  .product.originalPrice
                                  .toString()) *
                              orderIdProvider.count)
                          .toStringAsFixed(2)
                          .toString();

                      final List<ShoppingCartItem> shoppingCartItemList =
                          <ShoppingCartItem>[
                        ShoppingCartItem(
                            availableQuantity:
                                itemDetailProvider.quantity.toString(),
                            defaultPhoto:
                                itemDetailProvider.product.defaultPhoto,
                            discountPrice: discountPrice,
                            isSoldOut: '0',
                            itemId: itemDetailProvider.product.id,
                            itemName: itemDetailProvider.product.title,
                            originalPrice:
                                itemDetailProvider.product.originalPrice,
                            quantity: orderIdProvider.count.toString(),
                            salePrice: itemDetailProvider.product.currentPrice,
                            vendorCurrencySymbol: itemDetailProvider
                                .product.itemCurrency?.currencySymbol,
                            subTotal: subTotal)
                      ];

                      Utils.navigateOnUserVerificationView(context, () {
                        Navigator.pushNamed(context, RoutePaths.checkout,
                            arguments: <String, dynamic>{
                              'vendorId': itemDetailProvider.product.vendorId,
                              'checkoutItemList': shoppingCartItemList,
                              'isSingleItemCheckout': true
                            });
                      });
                    }
                  },
                )
              else
                PSButtonWidgetRoundCorner(
                  titleText: 'add_to_cart'.tr,
                  titleTextColor: PsColors.achromatic50,
                  onPressed: () async {
                    final String addToCartVendorId =
                        addToCartProvider.shoppingCart.data?.vendorId ?? '';
                    final String itemVendorId =
                        itemDetailProvider.product.vendorId;

                    final List<ShoppingCartItem> list =
                        addToCartProvider.shoppingCart.data?.items ??
                            <ShoppingCartItem>[];
                    for (ShoppingCartItem item in list) {
                      addToCartProvider
                          .addAllShoppingCartId(item.cartItemId ?? '');
                    }

                    final List<int> getAllCartIdList =
                        addToCartProvider.getAllShoppingCartId.toSet().toList();

                    if (addToCartVendorId != '' &&
                        addToCartVendorId != itemVendorId) {
                      showDialog<dynamic>(
                          context: context,
                          builder: (BuildContext context) {
                            return ConfirmDialogView(
                              title:
                                  'add_different_vendors_item_to_cart_title'.tr,
                              description:
                                  'add_different_vendors_item_to_cart_description'
                                      .tr,
                              rightButtonText: 'intro_slider_lets_explore'.tr,
                              leftButtonText: 'dialog__cancel'.tr,
                              onAgreeTap: () async {
                                Navigator.of(context).pop();

                                Navigator.of(context).pop();
                                await PsProgressDialog.showDialog(context);
                                await addToCartProvider.deleteItemFromCart(
                                    getAllCartIdList,
                                    psValueHolder.loginUserId,
                                    psValueHolder.languageCode);
                                _addToCart();
                              },
                            );
                          });
                    } else {
                      Navigator.of(context).pop();
                      await PsProgressDialog.showDialog(context);
                      _addToCart();
                    }
                  },
                )
            ],
          ),
        );
      },
    );
  }

  Future<void> _addToCart() async {
    final AddToCartParameterHolder jsonMap = AddToCartParameterHolder(
        vendorId: itemDetailProvider.product.vendorId,
        itemId: itemDetailProvider.product.id,
        quantity: orderIdProvider.count.toString(),
        userId: psValueHolder.loginUserId);

    final PsResource<ApiStatus> respone =
        await addToCartProvider.submitAddToCart(jsonMap.toMap(),
            psValueHolder.loginUserId, psValueHolder.languageCode);

    if (respone.status == PsStatus.SUCCESS) {
      await addToCartProvider.loadData(
          requestPathHolder: RequestPathHolder(
              loginUserId: psValueHolder.loginUserId ?? '',
              languageCode: psValueHolder.languageCode ?? ''));
      PsProgressDialog.dismissDialog();
      showInSnackBar('successfully_added_to_cart'.tr);
    } else if (respone.status == PsStatus.ERROR) {
      PsProgressDialog.dismissDialog();
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: respone.message);
          });
    }
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Utils.isLightMode(context)
            ? PsColors.achromatic50
            : PsColors.achromatic700,
        margin: const EdgeInsets.symmetric(
            vertical: PsDimens.space50, horizontal: PsDimens.space16),
        content: Row(
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: PsColors.success500,
            ),
            Text(
              message,
              style: TextStyle(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic900
                      : PsColors.achromatic50),
            ),
          ],
        )));
  }
}
