import '../common/ps_holder.dart';

class VendorSubScriptionBoughtParameterHolder
    extends PsHolder<VendorSubScriptionBoughtParameterHolder> {
  VendorSubScriptionBoughtParameterHolder({
     this.userId,
     this.subscriptionPlanId,
     this.paymentMethod,
     this.price,
     this.razorId,
     this.isPaystack,
     this.vendorId

  });

  final String? userId;
  final String? subscriptionPlanId;
  final String? paymentMethod;
  final String? price;
  final String? razorId;
  final String? isPaystack;
  final String? vendorId;
  // final String? paymentMethodOnce;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['user_id'] = userId;
    map['subscription_plan_id'] = subscriptionPlanId;
    map['payment_method'] = paymentMethod;
    map['price'] = price;
    map['razor_id'] = razorId;
    map['is_paystack'] = isPaystack;
    map['vendor_id'] = vendorId;

    return map;
  }

  @override
  VendorSubScriptionBoughtParameterHolder fromMap(dynamic dynamicData) {
    return VendorSubScriptionBoughtParameterHolder(
      userId: dynamicData['user_id'],
      subscriptionPlanId: dynamicData['subscription_plan_id'],
      paymentMethod: dynamicData['payment_method'],
      price: dynamicData['price'],
      razorId: dynamicData['razor_id'],
      isPaystack: dynamicData['is_paystack'],
      vendorId: dynamicData['vendor_id']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userId != '') {
      key += userId!;
    }
    if (subscriptionPlanId != '') {
      key += subscriptionPlanId!;
    }
    if (paymentMethod != '') {
      key += paymentMethod!;
    }
    if (price != '') {
      key += price!;
    }
    if (razorId != '') {
      key += razorId!;
    }
    if (isPaystack != '') {
      key += isPaystack!;
    }
    if(vendorId !=''){
      key += vendorId!;
    }
    
    return key;
  }
}
