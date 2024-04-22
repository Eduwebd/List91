import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class DefaultBillingAndShipping extends PsObject<DefaultBillingAndShipping> {
  DefaultBillingAndShipping({
    this.billingAddress,
    this.shippingAddress,
    this.shippingEmail,
    this.shippingFirstName,
    this.shippingLastName,
    this.billingCity,
    this.billingCountry,
    this.billingEmail,
    this.billingFirstName,
    this.billingLastName,
    this.billingPhoneNo,
    this.billingPostalCode,
    this.billingState,
    this.isSaveBillingInfoForNextTime,
    this.isSaveShippingInfoForNextTime,
    this.shippingCity,
    this.shippingCountry,
    this.shippingPhoneNo,
    this.shippingPostalCode,
    this.shippingState,
    this.shippingId,
    this.billingId
  });
  String? shippingId;
  String? shippingFirstName;
  String? shippingLastName;
  String? shippingEmail;
  String? shippingPhoneNo;
  String? shippingAddress;
  String? shippingCountry;
  String? shippingState;
  String? shippingCity;
  String? shippingPostalCode;
  String? isSaveShippingInfoForNextTime;
  String? billingId;
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
  bool operator ==(dynamic other) =>
      other is DefaultBillingAndShipping && shippingId == other.shippingId;

  @override
  int get hashCode => hash2(shippingId.hashCode, shippingId.hashCode);

  @override
  String? getPrimaryKey() {
    return shippingId;
  }

  @override
  DefaultBillingAndShipping fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return DefaultBillingAndShipping(
      shippingId: dynamicData['shipping_id'],
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
          billingId: dynamicData['billing_id'],
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
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};

      data['shipping_id'] = object.shippingId;
      data['shipping_first_name'] = object.shippingFirstName;
      data['shipping_last_name'] = object.shippingLastName;
      data['shipping_email'] = object.shippingEmail;
      data['shipping_phone_no'] = object.shippingPhoneNo;
      data['shipping_address'] = object.shippingAddress;
      data['shipping_country'] = object.shippingCountry;
      data['shipping_state'] = object.shippingState;
      data['shipping_city'] = object.shippingCity;
      data['shipping_postal_code'] = object.shippingPostalCode;
      data['is_save_shipping_info_for_next_time'] =
          object.isSaveShippingInfoForNextTime;
          data['billing_id']=object.billingId;
      data['billing_first_name'] = object.billingFirstName;
      data['billing_last_name'] = object.billingLastName;
      data['billing_email'] = object.billingEmail;
      data['billing_phone_no'] = object.billingPhoneNo;
      data['billing_address'] = object.billingAddress;
      data['billing_country'] = object.billingCountry;
      data['billing_state'] = object.billingState;
      data['billing_city'] = object.billingState;
      data['billing_postal_code'] = object.billingPostalCode;
      data['is_save_billing_info_for_next_time'] =
          object.isSaveBillingInfoForNextTime;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<DefaultBillingAndShipping> fromMapList(List<dynamic> dynamicDataList) {
    final List<DefaultBillingAndShipping> newFeedList =
        <DefaultBillingAndShipping>[];
    // if (dynamicDataList != null) {
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        newFeedList.add(fromMap(json));
      }
    }
    // }
    return newFeedList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    final List<Map<String, dynamic>?> dynamicList = <Map<String, dynamic>?>[];

    // if (objectList != null) {
    for (dynamic data in objectList) {
      if (data != null) {
        dynamicList.add(toMap(data));
      }
    }
    // }
    return dynamicList;
  }
}
