import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../common/ps_button_widget_with_round_corner.dart';

class ShoppingCartEmptyBox extends StatelessWidget {
  const ShoppingCartEmptyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: PsDimens.space100,
          left: PsDimens.space16,
          right: PsDimens.space16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: PsDimens.space260,
              height: PsDimens.space200,
              child: SvgPicture.asset(
                'assets/images/empty_cart.svg',
              ),
            ),
            const SizedBox(
              height: PsDimens.space32,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: PsDimens.space20, right: PsDimens.space20),
              child: Text(            
                'empty_cart_title'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
            ),
            const SizedBox(
              height: PsDimens.space8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: PsDimens.space14),
              child: Text(
                    'empty_cart_text'.tr
                    .tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            PSButtonWidgetRoundCorner(
              titleTextColor: PsColors.achromatic50,
              titleText: 'explore_now'.tr,
              onPressed: (){
                Navigator.pushReplacementNamed(context, RoutePaths.home);
              },
            )
          ],
        ),
      ),
    );
  }
}
