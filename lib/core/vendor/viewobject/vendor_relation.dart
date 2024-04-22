import 'common/ps_object.dart';
import 'selected_value.dart';

class VendorRelation extends PsObject<VendorRelation> {
  VendorRelation({
    this.id,
    this.vendorId,
    this.value,
    this.coreKeyId,
    this.coreKeyName,
    this.isVisible,
    this.uiTypeId,
    this.addedDateStr,
    this.selectedValues,
  });

  String? id;
  String? vendorId;
  String? coreKeyId;
  String? coreKeyName;
  String? isVisible;
  String? value;
  String? uiTypeId;
  String? addedDateStr;
  List<SelectedValue>? selectedValues;

  @override
  VendorRelation fromMap(dynamic dynamicData) {
    return VendorRelation(
      id: dynamicData['id'],
      vendorId: dynamicData['vendor_id'],  
      coreKeyId: dynamicData['core_keys_id'],
      coreKeyName: dynamicData['core_key_name'],
      isVisible: dynamicData['isVisible'],
      value: dynamicData['value'],
      uiTypeId: dynamicData['ui_type_id'],
      addedDateStr: dynamicData['added_date_str'],
      selectedValues: SelectedValue().fromMapList(dynamicData['selectedValue']),
    );
  }

  @override
  List<VendorRelation> fromMapList(List<dynamic>? dynamicDataList) {
    final List<VendorRelation> list = <VendorRelation>[];
    if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        list.add(fromMap(element));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  @override
  Map<String, dynamic>? toMap(VendorRelation? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['vendor_id'] = object.vendorId;
      data['core_keys_id'] = object.coreKeyId;
      data['core_key_name'] = object.coreKeyName;
      data['isVisible'] = object.isVisible;
      data['value'] = object.value;
      data['ui_type_id'] = object.uiTypeId;
      data['added_date_str'] = object.addedDateStr;
      data['selectedValue'] = SelectedValue().toMapList(object.selectedValues!);

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<VendorRelation> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (VendorRelation? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }
}
