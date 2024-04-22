import 'common/ps_object.dart';

class VendorDeliverySetting extends PsObject<VendorDeliverySetting> {
  VendorDeliverySetting({
    this.deliverySetting,
    this.deliveryCharges,
  });

  String? deliverySetting;
  String? deliveryCharges;


  @override
  VendorDeliverySetting fromMap(dynamic dynamicData) {
    return VendorDeliverySetting(
      deliverySetting: dynamicData['delivery_setting'],
      deliveryCharges: dynamicData['delivery_charges'],
    );
  }

  @override
  List<VendorDeliverySetting> fromMapList(List<dynamic> dynamicDataList) {
    final List<VendorDeliverySetting> list = <VendorDeliverySetting>[];
    for (dynamic element in dynamicDataList) {
      list.add(VendorDeliverySetting().fromMap(element));
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return '';
  }

  @override
  Map<String, dynamic>? toMap(VendorDeliverySetting? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['delivery_setting'] = object.deliverySetting;
      data['delivery_charges'] = object.deliveryCharges;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<VendorDeliverySetting> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (VendorDeliverySetting? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }

}

