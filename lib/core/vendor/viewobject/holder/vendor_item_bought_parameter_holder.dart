import '../common/ps_holder.dart';

class VendorItemBoughtParameterHolder
    extends PsHolder<VendorItemBoughtParameterHolder> {
  VendorItemBoughtParameterHolder({
    this.currencyId,
    this.isPaystack,
    this.orderId,
    this.paymentAmount,
    this.paymentMethod,
    this.paymentMethodNonce,
    this.razorId,
    this.userId,
    this.vendorId,
    this.isSingleCheckout
  });

  final String? userId;
  final String? paymentMethod;
  final String? paymentMethodNonce;
  final String? paymentAmount;
  final String? razorId;
  final String? isPaystack;
  final String? orderId;
  final String? vendorId;
  final String? currencyId;
  final String? isSingleCheckout;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['user_id'] = userId;
    map['payment_method'] = paymentMethod;
    map['payment_method_nonce'] = paymentMethodNonce;
    map['payment_amount'] = paymentAmount;
    map['razor_id'] = razorId;
    map['is_paystack'] = isPaystack;
    map['order_id'] = orderId;
    map['vendor_id'] = vendorId;
    map['currency_id'] = currencyId;
    map['is_single_checkout'] = isSingleCheckout;

    return map;
  }

  @override
  VendorItemBoughtParameterHolder fromMap(dynamic dynamicData) {
    return VendorItemBoughtParameterHolder(
      userId: dynamicData['user_id'],
      vendorId: dynamicData['vendor_id'],
      isPaystack: dynamicData['is_paystack'],
      paymentAmount: dynamicData['payment_amount'],
      razorId: dynamicData['razor_id'],
      paymentMethod: dynamicData['payment_method'],
      paymentMethodNonce: dynamicData['payment_method_nonce'],
      orderId: dynamicData['order_id'],
      currencyId: dynamicData['currency_id'],
      isSingleCheckout: dynamicData['is_single_checkout'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userId != '') {
      key += userId!;
    }
    if (paymentAmount != '') {
      key += paymentAmount!;
    }
    if (paymentMethod != '') {
      key += paymentMethod!;
    }
    if (paymentMethodNonce != '') {
      key += paymentMethodNonce!;
    }
    if (razorId != '') {
      key += razorId!;
    }
    if (orderId != '') {
      key += orderId!;
    }
    if (isPaystack != '') {
      key += isPaystack!;
    }
    if (isSingleCheckout != '') {
      key += isSingleCheckout!;
    }
    
    return key;
  }
}
