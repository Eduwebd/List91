import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/vendor_subscription_plan.dart';
import '../../../vendor_ui/vendor_subscription/component/vendor_subscription_card.dart';

class CustomVendorSubscriptionCard extends StatelessWidget {
  const CustomVendorSubscriptionCard({Key? key, required this.vendorSubscriptionPlan,required this.priceWithCurrency,required this.onTap}) : super(key: key);

  final VendorSubscriptionPlan vendorSubscriptionPlan;
  final String? priceWithCurrency;
// final PsValueHolder psValueHolder;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return VendorSubscriptionCard(
      onTap: onTap,
      priceWithCurrency:priceWithCurrency,
      // psValueHolder: widget.psValueHolder,
      vendorSubscriptionPlan: vendorSubscriptionPlan,
    );
  }
}
