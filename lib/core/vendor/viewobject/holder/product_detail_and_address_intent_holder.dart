
import 'billing_address_holder.dart';
import 'intent_holder/product_detail_intent_holder.dart';
import 'shipping_address_holder.dart';

class ProductDetailAndAddress {
  const ProductDetailAndAddress(
      {required this.productDetailIntentHolder,
      required this.shippingAddressHolder,
      required this.billingAddressHolder});

  final ProductDetailIntentHolder? productDetailIntentHolder;
  final ShippingAddressHolder? shippingAddressHolder;
  final BillingAddressHolder? billingAddressHolder;
}
