import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../common/ps_ui_widget.dart';

class OtherUserVendorBannerPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VendorUserDetailProvider userProvider = Provider.of<VendorUserDetailProvider>(context);
    return Container(
      // width:MediaQuery.of(context).size.width,
      // height: PsDimens.space140,
      child: PsNetworkImageWithUrl(
         width: double.infinity,
         height: PsDimens.space140,
        photoKey: '',
        imagePath: userProvider.vendorUserDetail.data!.banner1!.imgPath,
        imageAspectRation: PsConst.Aspect_Ratio_1x,
        boxfit: BoxFit.cover,
        onTap: () {},
      ),
    );
  }
}
