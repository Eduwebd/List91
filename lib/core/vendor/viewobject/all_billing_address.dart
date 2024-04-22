import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class AllBillingAddress extends PsObject<AllBillingAddress> {
  AllBillingAddress({
this.id,

    this.billingAddress,
    this.billingEmail,
    this.billingFirstName,
    this.billingLastName,

    this.isSaveBillingInfoForNextTime,
    this.isSaveShippingInfoForNextTime,
    this.billingCity,
    this.billingCountry,
    this.billingPhoneNo,
    this.billingPostalCode,
    this.billingState,
 
  });
  String? id;
  String? billingFirstName;
  String? billingLastName;
  String? billingEmail;
  String? billingPhoneNo;
  String? billingAddress;
  String? billingCountry;
  String? billingState;
  String? billingCity;
  String? billingPostalCode;
  String? isSaveShippingInfoForNextTime;
  String? isSaveBillingInfoForNextTime;



  @override
  bool operator ==(dynamic other) =>
      other is AllBillingAddress && id == other.id;

  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  AllBillingAddress fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return AllBillingAddress(
      id: dynamicData['id'],
      billingFirstName: dynamicData['billing_first_name'],
      billingLastName: dynamicData['billing_last_name'],
      billingEmail: dynamicData['billing_email'],
      billingPhoneNo: dynamicData['billing_phone_no'],
      billingAddress: dynamicData['billing_address'],
      billingCountry: dynamicData['billing_country'],
      billingState: dynamicData['billing_state'],
      billingCity: dynamicData['billing_city'],
      billingPostalCode: dynamicData['billing_postal_code'],
      isSaveShippingInfoForNextTime:
          dynamicData['is_save_shipping_info_for_next_time'],
        
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

      data['id'] = object.id;
      data['billing_first_name'] = object.billingFirstName;
      data['billing_last_name'] = object.billingLastName;
      data['billing_email'] = object.billingEmail;
      data['billing_phone_no'] = object.billingPhoneNo;
      data['billing_address'] = object.billingAddress;
      data['billing_country'] = object.billingCountry;
      data['billing_state'] = object.billingState;
      data['billing_city'] = object.billingCity;
      data['billing_postal_code'] = object.billingPostalCode;
      data['is_save_shipping_info_for_next_time'] =
          object.isSaveShippingInfoForNextTime;
    
      data['is_save_billing_info_for_next_time'] =
          object.isSaveBillingInfoForNextTime;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<AllBillingAddress> fromMapList(List<dynamic> dynamicDataList) {
    final List<AllBillingAddress> newFeedList =
        <AllBillingAddress>[];
    // if (dynamicDataList != null) {
    // for (dynamic json in dynamicDataList) {
    //   if (json != null) {
    //     newFeedList.add(fromMap(json));
    //   }
    // }
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
