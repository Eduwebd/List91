import 'common/ps_object.dart';
import 'vendor_delivery_setting.dart';

class VendorInfo extends PsObject<VendorInfo> {
  VendorInfo(
      {this.vendorPaypalEnabled,
      this.vendorPaystackEnabled,
      this.vendorPaystackKey,
      this.vendorRazorEnabled,
      this.vendorRazorKey,
      this.vendorStripeEnabled,
      this.vendorStripePublishableKey,
      this.vendorCurrencyId,
      this.vendorDeliverySetting});

  String? vendorStripeEnabled;
  String? vendorPaypalEnabled;
  String? vendorRazorEnabled;
  String? vendorPaystackEnabled;
  String? vendorRazorKey;
  String? vendorStripePublishableKey;
  String? vendorPaystackKey;
  String? vendorCurrencyId;
  VendorDeliverySetting? vendorDeliverySetting;

  @override
  String? getPrimaryKey() {
    return '';
  }

  @override
  VendorInfo fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return VendorInfo(
      vendorStripeEnabled: dynamicData['vendor_stripe_enabled'],
      vendorPaypalEnabled: dynamicData['vendor_paypal_enabled'],
      vendorRazorEnabled: dynamicData['vendor_razor_enabled'],
      vendorPaystackEnabled: dynamicData['vendor_paystack_enabled'],
      vendorRazorKey: dynamicData['vendor_razor_key'],
      vendorStripePublishableKey: dynamicData['vendor_stripe_publishable_key'],
      vendorPaystackKey: dynamicData['vendor_paystack_key'],
      vendorCurrencyId: dynamicData['currency_id'],
      vendorDeliverySetting: VendorDeliverySetting().fromMap(dynamicData['vendor_delivery_setting'])
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};

      data['vendor_stripe_enabled'] = object.vendorStripeEnabled;
      data['vendor_paypal_enabled'] = object.vendorPaypalEnabled;
      data['vendor_razor_enabled'] = object.vendorRazorEnabled;
      data['vendor_paystack_enabled'] = object.vendorPaystackEnabled;
      data['vendor_razor_key'] = object.vendorRazorKey;
      data['vendor_stripe_publishable_key'] = object.vendorStripePublishableKey;
      data['vendor_paystack_key'] = object.vendorPaystackKey;
      data['currency_id'] = object.vendorCurrencyId;
      data['vendor_delivery_setting'] = VendorDeliverySetting().toMap(object.vendorDeliverySetting);

      return data;
    } else {
      return null;
    }
  }

  @override
  List<VendorInfo> fromMapList(List<dynamic> dynamicDataList) {
    final List<VendorInfo> vendorInfo = <VendorInfo>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        vendorInfo.add(fromMap(dynamicData));
      }
    }
    // }
    return vendorInfo;
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
