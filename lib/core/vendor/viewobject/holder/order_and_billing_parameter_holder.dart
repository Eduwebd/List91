import '../common/ps_holder.dart';
import '../item_info.dart';

class OrderAndBillingParameterHolder
    extends PsHolder<OrderAndBillingParameterHolder> {
  OrderAndBillingParameterHolder(
      {required this.vendorId,
      required this.billingAddress,
      required this.shippingAddress,
      required this.billingCity,
      required this.billingCountry,
      required this.billingEmail,
      required this.billingFirstName,
      required this.billingLastName,
      required this.billingPhoneNo,
      required this.billingPostalCode,
      required this.billingState,
      required this.isSaveBillingInfoForNextTime,
      required this.isSaveShippingInfoForNextTime,
      required this.shippingCity,
      required this.shippingCountry,
      required this.shippingEmail,
      required this.shippingFirstName,
      required this.shippingLastName,
      required this.shippingPhoneNo,
      required this.shippingPostalCode,
      required this.shippingState,
      required this.totalPrice,
      required this.itemInfo});
  final String? vendorId;
  final String? shippingFirstName;
  final String? shippingLastName;
  final String? shippingEmail;
  final String? shippingPhoneNo;
  final String? shippingAddress;
  final String? shippingCountry;
  final String? shippingState;
  final String? shippingCity;
  final String? shippingPostalCode;
  final String? isSaveShippingInfoForNextTime;
  final String? billingFirstName;
  final String? billingLastName;
  final String? billingEmail;
  final String? billingPhoneNo;
  final String? billingAddress;
  final String? billingCountry;
  final String? billingState;
  final String? billingCity;
  final String? billingPostalCode;
  final String? isSaveBillingInfoForNextTime;
  final String? totalPrice;
  final List<ItemInfo> itemInfo;
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    //
    map['vendor_id'] = vendorId;
    map['shipping_first_name'] = shippingFirstName;
    map['shipping_last_name'] = shippingLastName;
    map['shipping_email'] = shippingEmail;
    map['shipping_phone_no'] = shippingPhoneNo;
    map['shipping_address'] = shippingAddress;
    map['shipping_country'] = shippingCountry;
    map['shipping_state'] = shippingState;
    map['shipping_city'] = shippingCity;
    map['shipping_postal_code'] = shippingPostalCode;
    map['is_save_shipping_info_for_next_time'] = isSaveShippingInfoForNextTime;
    map['billing_first_name'] = billingFirstName;
    map['billing_last_name'] = billingLastName;
    map['billing_email'] = billingEmail;
    map['billing_phone_no'] = billingPhoneNo;
    map['billing_address'] = billingAddress;
    map['billing_country'] = billingCountry;
    map['billing_state'] = billingState;
    map['billing_city'] = billingCity;
    map['billing_postal_code'] = billingPostalCode;
    map['is_save_billing_info_for_next_time'] = isSaveBillingInfoForNextTime;
    map['total_price'] = totalPrice;
    map['order_summary'] = ItemInfo().toMapList(itemInfo);

    return map;
  }

  @override
  OrderAndBillingParameterHolder fromMap(dynamic dynamicData) {
    return OrderAndBillingParameterHolder(

        ///
        vendorId: dynamicData['vendor_id'],
        shippingFirstName: dynamicData['shipping_first_name'],
        shippingLastName: dynamicData['shipping_last_name'],
        shippingEmail: dynamicData['shipping_email'],
        shippingPhoneNo: dynamicData['shipping_phone_no'],
        shippingAddress: dynamicData['shipping_address'],
        shippingCountry: dynamicData['shipping_country'],
        shippingState: dynamicData['shipping_state'],
        shippingCity: dynamicData['shipping_city'],
        shippingPostalCode: dynamicData['shipping_postal_code'],
        isSaveShippingInfoForNextTime:
            dynamicData['is_save_shipping_info_for_next_time'],
        billingFirstName: dynamicData['billing_first_name'],
        billingLastName: dynamicData['billing_last_name'],
        billingEmail: dynamicData['billing_email'],
        billingPhoneNo: dynamicData['billing_phone_no'],
        billingAddress: dynamicData['billing_address'],
        billingCountry: dynamicData['billing_country'],
        billingState: dynamicData['billing_state'],
        billingCity: dynamicData['billing_city'],
        billingPostalCode: dynamicData['billing_postal_code'],
        isSaveBillingInfoForNextTime:
            dynamicData['is_save_billing_info_for_next_time'],
        totalPrice: dynamicData['total_price'],
        itemInfo: ItemInfo().fromMapList(dynamicData['order_summary']));
  }

  @override
  String getParamKey() {
    String key = '';

    if (shippingAddress != '') {
      key += shippingAddress!;
    }
    if (shippingEmail != '') {
      key += shippingEmail!;
    }
    // if (message != '') {
    //   key += message!;
    // }
    // if (phone != '') {
    //   key += phone!;
    // }

    return key;
  }
}
