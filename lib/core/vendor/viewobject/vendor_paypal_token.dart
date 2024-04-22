import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class VendorPaypalToken extends PsObject<VendorPaypalToken?> {
  VendorPaypalToken({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  @override
  bool operator ==(dynamic other) =>
      other is VendorPaypalToken && status == other.status;

  @override
  int get hashCode => hash2(status.hashCode, status.hashCode);

  @override
  String? getPrimaryKey() {
    return status;
  }

  @override
  List<VendorPaypalToken?> fromMapList(List<dynamic> dynamicDataList) {
    final List<VendorPaypalToken?> subCategoryList = <VendorPaypalToken?>[];

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
  VendorPaypalToken? fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return VendorPaypalToken(
        status: dynamicData['status'],
        message: dynamicData['message'],
      );
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toMap(VendorPaypalToken? object) {
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
  List<Map<String, dynamic>?> toMapList(List<VendorPaypalToken?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (VendorPaypalToken? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }
    return mapList;
  }
}
