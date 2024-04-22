import 'package:flutter/material.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';

import '../../../../config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../common/ps_button_widget.dart';

class VendorRegisterationSuccessView extends StatefulWidget {
  const VendorRegisterationSuccessView({Key? key}) : super(key: key);

  @override
  State<VendorRegisterationSuccessView> createState() =>
      _VendorRegisterationSuccessViewState();
}

class _VendorRegisterationSuccessViewState
    extends State<VendorRegisterationSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: PsDimens.space28, horizontal: PsDimens.space16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Align(
                alignment: (Directionality.of(context) == TextDirection.rtl)
                    ? Alignment.topLeft
                    : Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      // ignore: always_specify_types
                      Navigator.popUntil(
                          // ignore: always_specify_types
                          context, (Route route) => route.isFirst);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic800
                          : PsColors.achromatic50,
                      size: PsDimens.space28,
                      weight: 300,
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  //bottom: PsDimens.space32,
                  top: PsDimens.space150),
              child: Image.asset(
                'assets/images/vendor_registeration_success.png',
                // width: 125,
                //height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: PsDimens.space36, bottom: PsDimens.space20),
              child: Text(
                'vendor_registeration_success_title'.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              'vendor_registeration_success_desc'.tr,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Utils.isLightMode(context)
                      ? PsColors.text600
                      : PsColors.text300),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: PsDimens.space20),
              child: PSButtonWidget(
                onPressed: () {
                  // ignore: always_specify_types
                  Navigator.popUntil(context, (Route route) => route.isFirst);
                },
                titleText: 'vendor_registeration_got_it'.tr,
              ),
            )
          ],
        ),
      )),
    );
  }
}
