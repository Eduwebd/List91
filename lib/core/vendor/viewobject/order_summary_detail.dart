import 'package:quiver/core.dart';

import 'common/ps_object.dart';
import 'item_info.dart';

class OrderSummaryDetail extends PsObject<OrderSummaryDetail> {
  OrderSummaryDetail(
      {this.billingAddress,
      this.orderCode,
      this.paymentMethod,
      this.paymentStatus,
      this.shippingAddress,
      this.shippingEmail,
      this.shippingFirstName,
      this.shippingLastName,
      this.vendorName,
      this.total,
      this.itemInfo,
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
      this.paymentDate,
      this.subTotal,
      this.deliveryFee,
      this.totalDiscount});
  String? orderCode;
  String? shippingFirstName;
  String? shippingLastName;
  String? shippingEmail;
  String? shippingPhoneNo;
  String? shippingAddress;
  String? shippingCountry;
  String? shippingCity;
  String? shippingState;
  String? shippingPostalCode;
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

  String? paymentMethod;
  String? paymentStatus;
  String? paymentDate;
  String? vendorName;
  List<ItemInfo>? itemInfo;

  String? subTotal;
  String? totalDiscount;
  String? deliveryFee;
  String? total;

  @override
  bool operator ==(dynamic other) =>
      other is OrderSummaryDetail && orderCode == other.orderCode;

  @override
  int get hashCode => hash2(orderCode.hashCode, orderCode.hashCode);

  @override
  String? getPrimaryKey() {
    return orderCode;
  }

  @override
  OrderSummaryDetail fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return OrderSummaryDetail(
      orderCode: dynamicData['order_code'],
      shippingFirstName: dynamicData['shipping_first_name'],
      shippingLastName: dynamicData['shipping_last_name'],
      shippingEmail: dynamicData['shipping_email'],
      paymentStatus: dynamicData['payment_status'],
      paymentMethod: dynamicData['payment_method'],
      shippingAddress: dynamicData['shipping_address'],
      billingAddress: dynamicData['billing_address'],
      vendorName: dynamicData['vendor_name'],
      paymentDate: dynamicData['payment_date'],
      total: dynamicData['total'],
      itemInfo: dynamicData['item_info'] != null
          ? ItemInfo().fromMapList(dynamicData['item_info'])
          : null,
      shippingPhoneNo: dynamicData['shipping_phone_no'],
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
      billingCountry: dynamicData['billing_country'],
      billingState: dynamicData['billing_state'],
      billingCity: dynamicData['billing_city'],
      billingPostalCode: dynamicData['billing_postal_code'],
      isSaveBillingInfoForNextTime:
          dynamicData['is_save_billing_info_for_next_time'],
      subTotal: dynamicData['sub_total'],
      totalDiscount: dynamicData['total_discount'],
      deliveryFee: dynamicData['delivery_fee'],
    );
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};

      // data['id'] = object.aboutId;
      data['order_code'] = object.orderCode;
      data['shipping_first_name'] = object.shippingFirstName;
      data['shipping_last_name'] = object.shippingLastName;
      data['shipping_email'] = object.shippingEmail;
      data['payment_date'] = object.paymentDate;
      data['payment_status'] = object.paymentStatus;
      data['payment_method'] = object.paymentMethod;
      data['shipping_address'] = object.shippingAddress;
      data['billing_address'] = object.billingAddress;
      data['vendor_name'] = object.vendorName;
      data['total'] = object.total;
      data['item_info'] = ItemInfo().toMapList(object.itemInfo);

      data['shipping_phone_no'] = object.shippingPhoneNo;
      data['shipping_country'] = object.shippingCountry;
      data['shipping_state'] = object.shippingState;
      data['shipping_city'] = object.shippingCity;
      data['shipping_postal_code'] = object.shippingPostalCode;
      data['is_save_shipping_info_for_next_time'] =
          object.isSaveBillingInfoForNextTime;
      data['billing_first_name'] = object.billingFirstName;
      data['billing_last_name'] = object.billingLastName;
      data['billing_email'] = object.billingEmail;
      data['billing_phone_no'] = object.billingPhoneNo;
      data['billing_country'] = object.billingCountry;
      data['billing_state'] = object.billingState;
      data['billing_city'] = object.billingCity;
      data['billing_postal_code'] = object.billingPostalCode;
      data['is_save_billing_info_for_next_time'] =
          object.isSaveBillingInfoForNextTime;
      data['sub_total'] = object.subTotal;
      data['total_discount'] = object.totalDiscount;
      data['delivery_fee'] = object.deliveryFee;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<OrderSummaryDetail> fromMapList(List<dynamic> dynamicDataList) {
    final List<OrderSummaryDetail> newFeedList = <OrderSummaryDetail>[];
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
