import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';

class OtherUserVendorItemCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VendorUserDetailProvider provider = Provider.of<VendorUserDetailProvider>(context);

    return Expanded(
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(context, RoutePaths.userItemList,
          //     arguments: ItemListIntentHolder(
          //         userId: provider.vendorUserDetail.data!.productCount,
          //         status: '1',
          //         title: 'profile__listing'.tr));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: PsDimens.space8),
          child: Column(
            children: <Widget>[
              Text(
                provider.vendorUserDetail.data!.productCount ?? '0',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge,
                maxLines: 1,
              ),
              Text(
                'vendor_page_products'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16,),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
