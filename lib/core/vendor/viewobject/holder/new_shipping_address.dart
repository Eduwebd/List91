import '../common/ps_holder.dart';

class NewShippingAddress extends PsHolder<NewShippingAddress> {
  NewShippingAddress({
    required this.shippingAddress,
    required this.shippingCity,
    required this.shippingCountry,
    required this.shippingEmail,
    required this.shippingFirstName,
    required this.shippingLastName,
    required this.shippingPhoneNo,
    required this.shippingPostalCode,
    required this.shippingState,
    required this.isSaveBillingInfoForNextTime,
    required this.isSaveShippingInfoForNextTime,
  });
  String? isSaveShippingInfoForNextTime;
  String? shippingFirstName;
  String? shippingLastName;
  String? shippingEmail;
  String? shippingPhoneNo;
  String? shippingAddress;
  String? shippingCountry;
  String? shippingState;
  String? shippingCity;
  String? shippingPostalCode;
  String? isSaveBillingInfoForNextTime;
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    //
    map['is_save_shipping_info_for_next_time'] = isSaveShippingInfoForNextTime;

    map['shipping_first_name'] = shippingFirstName;
    map['shipping_last_name'] = shippingLastName;
    map['shipping_email'] = shippingEmail;
    map['shipping_phone_no'] = shippingPhoneNo;
    map['shipping_address'] = shippingAddress;
    map['shipping_country'] = shippingCountry;
    map['shipping_state'] = shippingState;
    map['shipping_city'] = shippingState;
    map['shipping_postal_code'] = shippingPostalCode;
    map['is_save_billing_info_for_next_time'] = isSaveBillingInfoForNextTime;

    return map;
  }

  @override
  NewShippingAddress fromMap(dynamic dynamicData) {
    return NewShippingAddress(
        isSaveShippingInfoForNextTime:
            dynamicData['is_save_shipping_info_for_next_time'],
        shippingFirstName: dynamicData['shipping_first_name'],
        shippingLastName: dynamicData['shipping_last_name'],
        shippingEmail: dynamicData['shipping_email'],
        shippingPhoneNo: dynamicData['shipping_phone_no'],
        shippingAddress: dynamicData['shipping_address'],
        shippingCountry: dynamicData['shipping_country'],
        shippingState: dynamicData['shipping_state'],
        shippingCity: dynamicData['shipping_city'],
        shippingPostalCode: dynamicData['shipping_postal_code'],
        isSaveBillingInfoForNextTime:
            dynamicData['is_save_billing_info_for_next_time']);
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

    return key;
  }
}
