import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/order_id/order_id_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../common/ps_button_widget_with_round_corner.dart';
import 'order_success_photo_widget.dart';

class OrderSuccessfulWidget extends StatelessWidget {
  const OrderSuccessfulWidget(
      {Key? key, required this.orderId, required this.vendorId})
      : super(key: key);
  final String orderId;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    padding: const EdgeInsets.only(top:PsDimens.space40,right: PsDimens.space10),
                    icon: Icon(
                      Icons.close,
                      color: Utils.isLightMode(context)
                          ? PsColors.text800
                          : PsColors.text50,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RoutePaths.home);
                      Provider.of<OrderIdProvider>(context, listen: false)
                          .clearAddress();
                    }
                    // onClose,
                    ),
              ],
            ),
            const SizedBox(
              height: PsDimens.space104,
            ),

            OrderSuccessfulPhotoWidget(),
            const SizedBox(
              height: PsDimens.space10,
            ),
            Text('order_successfully_completed'.tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Utils.isLightMode(context)
                        ? PsColors.text800
                        : PsColors.achromatic50)),
            const SizedBox(
              height: PsDimens.space20,
            ),
            Text('order_successfully_completed_message'.tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: PsColors.text400)),
            const SizedBox(
              height: PsDimens.space20,
            ),
            PSButtonWidgetRoundCorner(
              titleTextColor: Utils.isLightMode(context)
                  ? PsColors.text50
                  : PsColors.text50,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(RoutePaths.home);
                Provider.of<OrderIdProvider>(context, listen: false)
                    .clearAddress();
              },
              titleText: 'order_successful_continue_shopping'.tr,
            ),
            const SizedBox(
              height: PsDimens.space20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RoutePaths.orderDetail,
                    arguments: <String, dynamic>{
                      'orderId': orderId,
                      'vendorId': vendorId
                    });
              },
              child: Text(
                // 'View Order Details',
                'order_successful_order_detail'.tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: PsColors.primary500),
              ),
            )
            // CustomSelectCityWidget(
            //     searchCityNameController: searchCityNameController,
            //     searchTownshipNameController: searchTownshipNameController),
            // if (valueHolder.isSubLocation == PsConst.ONE)
            //   CustomSelectTownshipWidget(
            //       searchTownshipNameController:
            //           searchTownshipNameController),
            // CustomExploreWidget(),
          ],
        ),
      ),
    );
  }
}
