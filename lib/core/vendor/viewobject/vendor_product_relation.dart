import 'common/ps_object.dart';

class VendorProductRelation extends PsObject<VendorProductRelation> {
  VendorProductRelation(
      {
      this.coreKeyId,
      this.value,});

  String? coreKeyId;
  String? value;

  @override
  VendorProductRelation fromMap(dynamic dynamicData) {
    return VendorProductRelation(
      coreKeyId: dynamicData['core_keys_id'],
      value: dynamicData['value'],
    );
  }

  @override
  List<VendorProductRelation> fromMapList(List<dynamic>? dynamicDataList) {
    final List<VendorProductRelation> list = <VendorProductRelation>[];
    if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        list.add(fromMap(element));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return coreKeyId.toString();
  }

  @override
  Map<String, dynamic>? toMap(VendorProductRelation? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['core_keys_id'] = object.coreKeyId;
      data['value'] = object.value;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<VendorProductRelation> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (VendorProductRelation? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }
}
