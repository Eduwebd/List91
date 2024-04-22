import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/list_with_filter/components/item/filter_item_list_view.dart';

class CustomFilterItemListView extends StatefulWidget {
  const CustomFilterItemListView(
      {Key? key, required this.animationController, required this.isGrid, this.onSubCategorySelected})
      : super(key: key);

  final AnimationController animationController;
  final bool isGrid;
 final Function(String?)? onSubCategorySelected;


  @override
  State<CustomFilterItemListView> createState() =>
      _CustomFilterItemListViewState();
}

class _CustomFilterItemListViewState extends State<CustomFilterItemListView> {
  @override
  Widget build(BuildContext context) {
    return FilterItemListView(
      onSubCategorySelected: widget.onSubCategorySelected,
        animationController: widget.animationController, isGrid: widget.isGrid);
  }
}
