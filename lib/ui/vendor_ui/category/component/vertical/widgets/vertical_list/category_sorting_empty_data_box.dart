import 'package:flutter/material.dart';

import '../../../../../../custom_ui/item/list_with_filter/components/item/widgets/item_list_empty_box.dart';

class CategorySortingEmptyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        child: CustomItemListEmptyBox(),
    ));
  }
}
