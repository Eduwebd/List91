import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class OtherUserVendorJoinDateTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VendorUserDetailProvider provider =
        Provider.of<VendorUserDetailProvider>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: PsDimens.space8),
        child: Column(
          children: <Widget>[
            Text(
              provider.vendorUserDetail.data!.addedDate == ''
                  ? ''
                  : Utils.getDateFormat(
                      provider.vendorUserDetail.data!.addedDate!,
                      psValueHolder.dateFormat!),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                  ),
              maxLines: 1,
            ),
            Text(
              'vendor_page_joned_date'.tr,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                  ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
