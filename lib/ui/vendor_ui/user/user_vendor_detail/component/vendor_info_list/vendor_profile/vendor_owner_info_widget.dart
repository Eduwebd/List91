import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../common/ps_ui_widget.dart';

class VendorOwnerProfilePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final VendorUserDetailProvider provider =
        Provider.of<VendorUserDetailProvider>(context);
    return Container(
      padding: const EdgeInsets.only(
        left: PsDimens.space12,
        top: PsDimens.space8,
      ),
      child: Row(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              child: SizedBox(
                width: PsDimens.space80,
                height: PsDimens.space80,
                child: PsNetworkCircleImageForUser(
                  photoKey: '',
                  imagePath: provider.vendorUserDetail.data!.logo!.imgPath,
                  // width: PsDimens.space40,
                  // height: PsDimens.space40,
                  boxfit: BoxFit.cover,
                  onTap: () {
                    //onDetailClick(context);
                  },
                ),
              ),
            ),
            if (provider.vendorUserDetail.data!.isVendorUser)
              Positioned(
                right: -1,
                bottom: -1,
                child: Icon(
                  Icons.verified_user,
                  color: PsColors.info500,
                  size: 20,
                ),
              ),
          ]),
          const SizedBox(width: PsDimens.space8),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(provider.vendorUserDetail.data!.name ?? '',
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: PsDimens.space4),
                  Row(
                    children: <Widget>[
                      Text(provider.vendorUserDetail.data!.productCount ?? '0',
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text500
                                        : PsColors.text400,
                                  )),
                      const SizedBox(width: PsDimens.space4),
                      Text('vendor_page_products'.tr,
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text500
                                        : PsColors.text400,
                                  )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: PsDimens.space10),
                        child: Container(
                          height: PsDimens.space20,
                          child: VerticalDivider(
                            color: PsColors.text300,
                            thickness: 1,
                          ),
                        ),
                      ),
                      Text('vendor_page_joned_date'.tr,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Utils.isLightMode(context)
                                      ? PsColors.text500
                                      : PsColors.text400)),
                      const SizedBox(width: PsDimens.space4),
                      Flexible(
                        child: Text(
                            provider.vendorUserDetail.data!.addedDate == ''
                                ? ''
                                : Utils.getDateFormat(
                                    provider.vendorUserDetail.data!.addedDate!,
                                    psValueHolder.dateFormat!),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text500
                                        : PsColors.text400)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
        //),
      ),
    );
  }
}
