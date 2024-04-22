import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/ps_colors.dart';
import '../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../core/vendor/api/common/ps_status.dart';
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

class SoldOutVerticalListView extends StatelessWidget {
  const SoldOutVerticalListView(
      {Key? key,
      required this.soldOutItemList,
      required this.vendorId,
      required this.isVedorExpired})
      : super(key: key);

  final List<ShoppingCartItem> soldOutItemList;
  final String vendorId;
  final int isVedorExpired;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final List<int> _soldOutCartIdList = <int>[];

    for (ShoppingCartItem value in soldOutItemList) {
      _soldOutCartIdList.add(int.parse(value.cartItemId.toString()));
    }
    return Consumer<AddToCartProvider>(
      builder: (_, AddToCartProvider provider, __) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: PsDimens.space8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('sold_out_items'.tr,
                      style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                          color: Utils.isLightMode(context)
                              ? PsColors.achromatic800
                              : PsColors.achromatic100,
                          fontWeight: FontWeight.w600)),
                ),
                GestureDetector(
                  onTap: () async {
                    await PsProgressDialog.showDialog(context);
                    final PsResource<ApiStatus> respone =
                        await provider.deleteItemFromCart(
                            _soldOutCartIdList,
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
                      style:
                          TextStyle(fontSize: 14, color: PsColors.primary500)),
                ),
              ],
            ),
          ),
        
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: soldOutItemList.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomShoppingCartItemWidget(
                  shoppingCartItem: soldOutItemList[index],
                  vendorId: vendorId,
                  isVedorExpired: isVedorExpired,
                );
              }),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
