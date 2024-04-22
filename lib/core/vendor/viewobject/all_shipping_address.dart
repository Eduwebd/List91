import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class AllShippingAddress extends PsObject<AllShippingAddress> {
  AllShippingAddress({
this.id,

    this.shippingAddress,
    this.shippingEmail,
    this.shippingFirstName,
    this.shippingLastName,

    this.isSaveBillingInfoForNextTime,
    this.isSaveShippingInfoForNextTime,
    this.shippingCity,
    this.shippingCountry,
    this.shippingPhoneNo,
    this.shippingPostalCode,
    this.shippingState,
 
  });
  String? id;
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
  String? isSaveBillingInfoForNextTime;



  @override
  bool operator ==(dynamic other) =>
      other is AllShippingAddress && id == other.id;

  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  AllShippingAddress fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return AllShippingAddress(
      id: dynamicData['id'],
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
    
      data['is_save_billing_info_for_next_time'] =
          object.isSaveBillingInfoForNextTime;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<AllShippingAddress> fromMapList(List<dynamic> dynamicDataList) {
    final List<AllShippingAddress> newFeedList =
        <AllShippingAddress>[];
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
