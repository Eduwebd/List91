
import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/list_with_filter/components/item/widgets/category_icon.dart';

class CustomCategoryIconWidget extends StatelessWidget {
  const CustomCategoryIconWidget({Key? key, required this.onSubCategorySelected}) : super(key: key);
  final Function(String?)? onSubCategorySelected;

  @override
  Widget build(BuildContext context) {
    return  CategoryIconWidget(onSubCategorySelected: onSubCategorySelected);
  }
}
