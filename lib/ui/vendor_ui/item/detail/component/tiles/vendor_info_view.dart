import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/vendor_user_intent_holder.dart';
import '../../../../common/bluemark_icon.dart';
import '../../../../common/ps_ui_widget.dart';

class VendorInfoView extends StatefulWidget {
  @override
  State<VendorInfoView> createState() => _VendorInfoViewState();
}

class _VendorInfoViewState extends State<VendorInfoView> {
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);
    final Product product = provider.product;
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);

    if (psValueHolder.vendorFeatureSetting != PsConst.ONE ||
            provider.product.vendorUser == null ||
            provider.product.vendorId == '' //item is not from vendor
        ) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () {
          onSellerInfoClick(context, provider.product);
        },
        child: Container(
          margin: const EdgeInsets.only(
              left: PsDimens.space16,
              right: PsDimens.space16,
              top: PsDimens.space16),
          decoration: BoxDecoration(
            color: Utils.isLightMode(context)
                ? PsColors.text50
                : PsColors.achromatic700,
            borderRadius:
                const BorderRadius.all(Radius.circular(PsDimens.space4)),
          ),
          child: Padding(
              padding: const EdgeInsets.only(
                  top: PsDimens.space16,
                  bottom: PsDimens.space16,
                  left: PsDimens.space16,
                  right: PsDimens.space16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //image
                  Stack(
                    children: <Widget>[
                      Container(
                        width: PsDimens.space50,
                        height: PsDimens.space50,
                        child: product.vendorUser?.expiredStatus ==
                                PsConst.EXPIRED_NOTI
                            ? Container(
                                decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:PsColors.achromatic900,
                                ),
                                alignment: Alignment.center,
                                width: PsDimens.space40,
                                height: PsDimens.space40,
                                child: Text(
                                  'Closed',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: PsColors.text50),
                                ),
                              )
                            : PsNetworkCircleImageForUser(
                                photoKey: '',
                                imagePath: product.vendorUser!.logo?.imgPath,
                                boxfit: BoxFit.cover,
                              ),
                      ),
                      if (product.vendorUser!.isVendorUser)
                        const Positioned(
                            right: -1, bottom: -1, child: BluemarkIcon()),
                    ],
                  ),
                  const SizedBox(
                    width: PsDimens.space16,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, bottom: 4.0),
                                  child: Text(
                                    provider.product.vendorUser!.name == ''
                                        ? 'default__user_name'.tr
                                        : provider.product.vendorUser!.name ??
                                            '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 16),
                                  )),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: PsDimens.space2, right: PsDimens.space4),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(PsDimens.space4),
                              color: PsColors.warning500),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: PsDimens.space4,
                                  vertical: PsDimens.space2),
                              child: Text('vendor'.tr,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: PsColors.achromatic50))),
                        ),
                      ],
                    ),
                  ),
                  //)
                ],
              )),
        ),
      ),
    );
  }

  void onSellerInfoClick(BuildContext context, Product product) {
    Navigator.pushNamed(context, RoutePaths.userVendorDetail,
        arguments: VendorUserIntentHolder(
            vendorId: product.vendorUser!.id,
            vendorUserId: product.vendorUser!.ownerUserId,
            vendorUserName: product.vendorUser!.name ?? ''));
  }
}
