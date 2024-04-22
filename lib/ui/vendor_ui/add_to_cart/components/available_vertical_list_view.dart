import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/ps_colors.dart';
import '../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../core/vendor/api/common/ps_status.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/api_status.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../custom_ui/add_to_cart/components/widgets/shopping_cart_item_widget.dart';
import '../../common/dialog/error_dialog.dart';
import '../../item/detail/component/info_widgets/vendor_expired_widget.dart';

class AvailableVerticalListView extends StatelessWidget {
  const AvailableVerticalListView({
    Key? key,
    required this.availableItemList,
    required this.title,
    required this.vendorId,
    required this.isVedorExpired,
  }) : super(key: key);

  final List<ShoppingCartItem> availableItemList;
  final String title, vendorId;
  final int isVedorExpired;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final List<int> _availableCartIdList = <int>[];

    for (ShoppingCartItem value in availableItemList) {
      _availableCartIdList.add(int.parse(value.cartItemId.toString()));
    }

    return Consumer<AddToCartProvider>(
        builder: (_, AddToCartProvider provider, __) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          color: Utils.isLightMode(context)
                              ? PsColors.achromatic800
                              : PsColors.achromatic100,
                          fontWeight: FontWeight.w600)),
                ),
                if (provider.selectedAvaliableCartId.isNotEmpty)
                  GestureDetector(
                    onTap: () async {
                      await PsProgressDialog.showDialog(context);
                      final PsResource<ApiStatus> respone =
                          await provider.deleteItemFromCart(
                              provider.selectedAvaliableCartId,
                              psValueHolder.loginUserId,
                              psValueHolder.languageCode);
                      if (respone.status == PsStatus.SUCCESS) {
                        await provider.loadData(
                            dataConfig: DataConfiguration(
                                dataSourceType: DataSourceType.SERVER_DIRECT),
                            requestPathHolder: RequestPathHolder(
                                loginUserId: psValueHolder.loginUserId,
                                languageCode: psValueHolder.languageCode));
                        PsProgressDialog.dismissDialog();
                      } else {
                        PsProgressDialog.dismissDialog();
                        showDialog<dynamic>(
                            context: context,
                            builder: (BuildContext context) {
                              return ErrorDialog(message: respone.message);
                            });
                      }
                    },
                    child: Text('delete_selected_items'.tr,
                        style: TextStyle(
                            fontSize: 14, color: PsColors.primary500)),
                  )
                else
                  GestureDetector(
                    onTap: () async {
                      await PsProgressDialog.showDialog(context);
                      final PsResource<ApiStatus> respone =
                          await provider.deleteItemFromCart(
                              _availableCartIdList,
                              psValueHolder.loginUserId,
                              psValueHolder.languageCode);
                      if (respone.status == PsStatus.SUCCESS) {
                        await provider.loadData(
                            dataConfig: DataConfiguration(
                                dataSourceType: DataSourceType.SERVER_DIRECT),
                            requestPathHolder: RequestPathHolder(
                                loginUserId: psValueHolder.loginUserId,
                                languageCode: psValueHolder.languageCode));
                        PsProgressDialog.dismissDialog();
                      } else {
                        PsProgressDialog.dismissDialog();
                        showDialog<dynamic>(
                            context: context,
                            builder: (BuildContext context) {
                              return ErrorDialog(message: respone.message);
                            });
                      }
                    },
                    child: Text('delete_all'.tr,
                        style: TextStyle(
                            fontSize: 12, color: PsColors.primary500)),
                  ),
              ],
            ),
          ),
          if (isVedorExpired == PsConst.EXPIRED_NOTI)
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: PsDimens.space8, horizontal: PsDimens.space16),
              child: VendorExpiredWidget(
                  vendorExpText: 'vendor_expired_text_for_shopping_cart'.tr),
            )
          else
            const SizedBox(),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: availableItemList.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomShoppingCartItemWidget(
                  shoppingCartItem: availableItemList[index],
                  vendorId: vendorId,
                  isVedorExpired: isVedorExpired,
                );
              }),
          const SizedBox(height: PsDimens.space10),
        ],
      );
    });
  }
}
