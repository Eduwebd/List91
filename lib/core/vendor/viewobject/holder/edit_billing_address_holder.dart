import '../common/ps_holder.dart';

class EditBillingAddress extends PsHolder<EditBillingAddress> {
  EditBillingAddress({
    required this.id,
    required this.billingAddress,
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
  });
  String? id;
  String? isSaveShippingInfoForNextTime;
  String? billingFirstName;
  String? billingLastName;
  String? billingEmail;
  String? billingPhoneNo;
  String? billingAddress;
  String? billingCountry;
  String? billingState;
  String? billingCity;
  String? billingPostalCode;
  String? isSaveBillingInfoForNextTime;
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['is_save_shipping_info_for_next_time'] = isSaveShippingInfoForNextTime;
    map['id'] = id;
    map['billing_first_name'] = billingFirstName;
    map['billing_last_name'] = billingLastName;
    map['billing_email'] = billingEmail;
    map['billing_phone_no'] = billingPhoneNo;
    map['billing_address'] = billingAddress;
    map['billing_country'] = billingCountry;
    map['billing_state'] = billingState;
    map['billing_city'] = billingState;
    map['billing_postal_code'] = billingPostalCode;
    map['is_save_billing_info_for_next_time'] = isSaveBillingInfoForNextTime;

    return map;
  }

  @override
  EditBillingAddress fromMap(dynamic dynamicData) {
    return EditBillingAddress(
        id: dynamicData['id'],
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
            dynamicData['is_save_billing_info_for_next_time']);
  }

  @override
  String getParamKey() {
    String key = '';

    if (billingAddress != '') {
      key += billingAddress!;
    }
    if (billingEmail != '') {
      key += billingEmail!;
    }

    return key;
  }
}
