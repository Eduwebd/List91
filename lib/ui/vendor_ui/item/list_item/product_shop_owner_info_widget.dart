import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../common/ps_ui_widget.dart';

class ProductShopOwnerInfoWidget extends StatelessWidget {
  const ProductShopOwnerInfoWidget({
    Key? key,
    required this.product,
    required this.tagKey,
  }) : super(key: key);

  final Product product;
  final String tagKey;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(
        left: PsDimens.space4,
        top: PsDimens.space8,
      ),
      child: Row(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              child: SizedBox(
                width: PsDimens.space40,
                height: PsDimens.space40,
                child: Stack(
                  children: <Widget>[
                   
                     PsNetworkCircleImageForUser(
                        photoKey: '',
                        imagePath: product.vendorUser?.logo?.imgPath,
                        boxfit: BoxFit.cover,
                        onTap: () {
                          onDetailClick(context);
                        },
                      ),
                       if (product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI) Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PsColors.achromatic900.withOpacity(0.75),
                        ),
                        alignment: Alignment.center,
                        width: PsDimens.space40,
                        height: PsDimens.space40,
                        child: Text('Closed',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: PsColors.achromatic50))
                     
                        ) else const SizedBox(),
                  ],
                )
              ),
            ),
            if (product.vendorUser!.isVendorUser)
              Positioned(
                right: -1,
                bottom: -1,
                child: Icon(
                  Icons.verified_user,
                  color: PsColors.info500,
                  size: valueHolder.bluemarkSize,
                ),
              ),
          ]),
          const SizedBox(width: PsDimens.space8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: PsDimens.space8, top: PsDimens.space8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                            product.vendorUser?.name == ''
                                ? 'default__user_name'.tr
                                : '${product.vendorUser?.name}',
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                      const SizedBox(width: PsDimens.space4),
                      Image.asset(
                        'assets/images/storefont.png',
                        width: 20,
                      ),
                    ],
                  ),
                  Text('${product.addedDateStr}',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.text500
                              : PsColors.text400))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void onDetailClick(BuildContext context) {
    print(product.defaultPhoto!.imgPath);
    final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
        productId: product.id,
        heroTagImage: tagKey + product.id! + PsConst.HERO_TAG__IMAGE,
        heroTagTitle: tagKey + product.id! + PsConst.HERO_TAG__TITLE);
    Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
  }
}
