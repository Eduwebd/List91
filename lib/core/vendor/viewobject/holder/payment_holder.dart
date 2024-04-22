
import '../../provider/product/product_provider.dart';
import '../../provider/user/user_provider.dart';
import '../../provider/vendor_item_bought/vendor_item_bought_provider.dart';

class PaymentHolder {
  const PaymentHolder(
      {this.currencyId,
      this.isPaystack,
      this.orderId,
      this.paymentAmount,
      this.paymentMethod,
      this.paymentMethodNonce,
      this.razorId,
      this.userId,
      this.vendorId,
      this.isSingleCheckout,
      this.vendorItemBoughtProvider,
      this.paymentStripeKey,
      this.userProvider,
      this.itemDetailProvider});

  final String? userId;
  final String? paymentMethod;
  final String? paymentMethodNonce;
  final String? paymentAmount;
  final String? razorId;
  final String? isPaystack;
  final String? orderId;
  final String? vendorId;
  final String? currencyId;
  final String? paymentStripeKey;
  final String? isSingleCheckout;
  final VendorItemBoughtProvider? vendorItemBoughtProvider;
  final UserProvider? userProvider;
  final ItemDetailProvider? itemDetailProvider;
}
