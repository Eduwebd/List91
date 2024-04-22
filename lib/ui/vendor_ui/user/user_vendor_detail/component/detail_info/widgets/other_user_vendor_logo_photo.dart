import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../common/ps_ui_widget.dart';

class OtherUserVendorLogoPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VendorUserDetailProvider userProvider =
        Provider.of<VendorUserDetailProvider>(context);
    return Container(
      width: PsDimens.space80,
      height: PsDimens.space80,
      child:Stack(
        children: <Widget>[
          PsNetworkCircleImageForUser(
              photoKey: '',
              imagePath: userProvider.vendorUserDetail.data!.logo!.imgPath,
              boxfit: BoxFit.cover,
              onTap: () {},
            ),
           if ( userProvider.vendorUserDetail.data?.expiredStatus ==
              PsConst.EXPIRED_NOTI)
           Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PsColors.achromatic900.withOpacity(0.75),
              ),
              alignment: Alignment.center,
             
              child: Text('Closed',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: PsColors.text50)),
            ) else const SizedBox()
        ],
      )
      
      
    );
  }
}
