import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/vendor_user.dart';
import '../../../../../../vendor_ui/user/profile/component/my_vendor/widget/my_vendor_list_grid_item.dart';

class CustomMyVendorListGridItem extends StatefulWidget {
  const CustomMyVendorListGridItem(
      {Key? key,
      required this.vendorUser,
      this.animation,
      this.animationController,
      this.isLoading = false,
      this.width})
      : super(key: key);

  final VendorUser vendorUser; 
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;
  final double? width;

  @override
  State<CustomMyVendorListGridItem> createState() => _MyStoreListItemState();
}

class _MyStoreListItemState extends State<CustomMyVendorListGridItem> {
  @override
  Widget build(BuildContext context) {
    
    return MyVendorListGridItem(
      vendorUser: widget.vendorUser,
      animation: widget.animation,
      animationController: widget.animationController,
      isLoading: widget.isLoading,
      width: widget.width,
    );
  }
}
