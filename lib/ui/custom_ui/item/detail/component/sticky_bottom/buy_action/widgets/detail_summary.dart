import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../vendor_ui/item/detail/component/sticky_bottom/buy_action/widgets/detail_summary.dart';

class CustomDetailSummary extends StatelessWidget {
  const CustomDetailSummary({Key? key, required this.product,this.quantity}) : super(key: key);
  final Product product;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return DetailSummary(
      product: product,
      quantity: quantity,
    );
  }
}
