import 'package:flutter/material.dart';
import '../../../../../../../config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/item/widgets/category_icon.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/item/widgets/filter_icon.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/item/widgets/filter_item_type.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/item/widgets/map_icon.dart';

class FilterNavItems extends StatefulWidget {
  const FilterNavItems({this.changeAppBarTitle, required this.onSubCategorySelected});

  final Function? changeAppBarTitle;
   final Function(String?)? onSubCategorySelected;

  @override
  State<FilterNavItems> createState() => _FilterNavItemsState();
}

class _FilterNavItemsState extends State<FilterNavItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
      padding: const EdgeInsets.only(
        left: PsDimens.space16,
        top: PsDimens.space8,
        bottom: PsDimens.space12,
        right: PsDimens.space16,
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         const CustomFilterProductItemTypeWidget(),
          Row(
            children: <Widget>[
              CustomCategoryIconWidget(onSubCategorySelected: widget.onSubCategorySelected,),
            const  SizedBox(width: PsDimens.space10),
            const  CustomFilterIconWidget(),
            const  SizedBox(width: PsDimens.space10),
            const  CustomMapIconWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
