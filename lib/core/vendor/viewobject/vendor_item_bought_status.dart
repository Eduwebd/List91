import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class VendorItemBoughtApiStatus extends PsObject<VendorItemBoughtApiStatus?> {
  VendorItemBoughtApiStatus({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  @override
  bool operator ==(dynamic other) =>
      other is VendorItemBoughtApiStatus && status == other.status;

  @override
  int get hashCode => hash2(status.hashCode, status.hashCode);

  @override
  String? getPrimaryKey() {
    return status;
  }

  @override
  List<VendorItemBoughtApiStatus?> fromMapList(List<dynamic> dynamicDataList) {
    final List<VendorItemBoughtApiStatus?> subCategoryList =
        <VendorItemBoughtApiStatus?>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subCategoryList.add(fromMap(dynamicData));
      }
    }
    // }
    return subCategoryList;
  }

  @override
  VendorItemBoughtApiStatus? fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return VendorItemBoughtApiStatus(
        status: dynamicData['status'],
        message: dynamicData['message'],
      );
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toMap(VendorItemBoughtApiStatus? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['status'] = object.status;
      data['message'] = object.message;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(
      List<VendorItemBoughtApiStatus?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (VendorItemBoughtApiStatus? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }
    return mapList;
  }
}
