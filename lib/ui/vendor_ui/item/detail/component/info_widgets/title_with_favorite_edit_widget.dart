import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/favourite_item_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/favourite_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/item_entry_intent_holder.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../custom_ui/item/detail/component/info_widgets/quantity_warning_widget.dart';
import '../../../../common/dialog/check_item_dialog.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/ps_hero.dart';
import 'vendor_expired_widget.dart';

class TitleWithEditAndFavoriteWidget extends StatefulWidget {
  const TitleWithEditAndFavoriteWidget({Key? key, required this.heroTagTitle})
      : super(key: key);

  final String? heroTagTitle;

  @override
  TitleWithEditAndFavoriteWidgetState<TitleWithEditAndFavoriteWidget>
      createState() =>
          TitleWithEditAndFavoriteWidgetState<TitleWithEditAndFavoriteWidget>();
}

class TitleWithEditAndFavoriteWidgetState<
        T extends TitleWithEditAndFavoriteWidget>
    extends State<TitleWithEditAndFavoriteWidget> {
  bool showEditButton = true; //to wait images loading
  late PsValueHolder psValueHolder;
  late ItemDetailProvider itemDetailProvider;
  late FavouriteItemProvider favouriteItemProvider;
  late GalleryProvider galleryProvider;
  String? loginUserId = '';
  late Product product;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    itemDetailProvider = Provider.of<ItemDetailProvider>(context);
    favouriteItemProvider = Provider.of<FavouriteItemProvider>(context);
    galleryProvider = Provider.of<GalleryProvider>(context);
    loginUserId = Utils.checkUserLoginId(psValueHolder);
    product = itemDetailProvider.product;

    return SliverToBoxAdapter(
      child: Column(children: <Widget>[
        if (itemDetailProvider.product.vendorUser!.isVendorUser)
          itemDetailProvider.product.vendorUser?.expiredStatus ==
                  PsConst.EXPIRED_NOTI
              ?  Padding(
                  padding: const EdgeInsets.only(
                      top: PsDimens.space16,
                      left: PsDimens.space16,
                      right: PsDimens.space16),
                  child: VendorExpiredWidget(vendorExpText: 'vendor_expired_text'.tr))
              : const SizedBox(),
        // productStore.item?.data?.user?.userId == loginUserId
        if (itemDetailProvider.product.user?.userId == loginUserId &&
            (itemDetailProvider.quantity == null ||
                itemDetailProvider.quantity == 0) &&
            itemDetailProvider.product.vendorUser!.isVendorUser)
          const CustomQuantiryWarningWidget(),
        Container(
          margin: const EdgeInsets.only(
              top: PsDimens.space16,
              left: PsDimens.space16,
              right: PsDimens.space16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: PsHero(
                      tag: widget.heroTagTitle!,
                      child: Text(itemDetailProvider.product.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall),
                    ),
                  ),
                  if (Utils.isOwnerItem(
                      psValueHolder, product)) //show owner's edit_button
                    Visibility(
                      visible: showEditButton,
                      child: InkWell(
                          onTap: () {
                            final String currencyId = itemDetailProvider
                                    .itemDetail.data?.vendorUser?.currencyId ??
                                '';
                            final String vendorId = itemDetailProvider
                                    .itemDetail.data?.vendorUser?.id ??
                                '';
                            if (currencyId == '' && vendorId != '') {
                              showDialog<dynamic>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CheckOutDialog(
                                      title: 'vendor_set_default_currency'.tr,
                                      message:
                                          'vendor_set_default_currency_description'
                                              .tr,
                                    );
                                  });
                            } else {
                              onOwnerEditButtonClick();
                            }
                          },
                          child: const Icon(Icons.edit)),
                    )
                  else //show favorite
                    GestureDetector(
                        onTap: () {
                          onFavoriteClick();
                        },
                        child: Icon(product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border)),
                ],
              ),
              //),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> onFavoriteClick() async {
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    if (await Utils.checkInternetConnectivity()) {
      Utils.navigateOnUserVerificationView(context, () async {
        if (product.isFavorite) {
          setState(() {
            itemDetailProvider.product.isFavourited = '0';
          });
        } else {
          setState(() {
            itemDetailProvider.product.isFavourited = '1';
          });
        }

        final FavouriteParameterHolder favouriteParameterHolder =
            FavouriteParameterHolder(
          userId: loginUserId,
          itemId: itemDetailProvider.product.id,
        );
        await favouriteItemProvider.postFavourite(
            favouriteParameterHolder.toMap(),
            loginUserId!,
            psValueHolder.headerToken!,
            langProvider.currentLocale.languageCode);
      });
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

  Future<void> onOwnerEditButtonClick() async {
    final dynamic entryData = await Navigator.pushNamed(
        context, RoutePaths.itemEntry,
        arguments: ItemEntryIntentHolder(
            categoryId: product.catId,
            flag: PsConst.EDIT_ITEM,
            item: itemDetailProvider.product));
    if (entryData != null && entryData is bool && entryData) {
      setState(() {
        showEditButton = false;
      });
      await galleryProvider.loadDataList(
          requestPathHolder: RequestPathHolder(
              parentImgId: itemDetailProvider.product.id,
              imageType: PsConst.ITEM_IMAGE_TYPE));
      itemDetailProvider.loadData(
          requestPathHolder: RequestPathHolder(
              itemId: itemDetailProvider.product.id, loginUserId: loginUserId));
    }
    setState(() {
      showEditButton = true;
    });
  }
}
