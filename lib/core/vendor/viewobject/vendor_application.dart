import 'common/ps_object.dart';

class VendorApplication extends PsObject<VendorApplication?> {
  VendorApplication({
    this.id,
    this.vendorId,
    this.userId,
    this.document,
    this.coverLetter,
    this.addedDateStr,

  });

  String? id;
  String? vendorId;
  String? userId;
  String? document;
  String? coverLetter;
  String? addedDateStr;


  @override
  VendorApplication? fromMap(dynamic dynamicData) {
     if (dynamicData != null) {
    return VendorApplication(
      id: dynamicData['id'] ?? '',
      vendorId: dynamicData['vendor_id'],  
      userId: dynamicData['user_id'],
      document: dynamicData['document'],
      coverLetter: dynamicData['cover_letter'],
      addedDateStr: dynamicData['added_date_str'],

    );
     }else {
      return null;
    }
  }

  @override
  List<VendorApplication?> fromMapList(List<dynamic> dynamicDataList) {
    final List<VendorApplication?> list = <VendorApplication?>[];
   // if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        list.add(fromMap(element));
    //  }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  @override
  Map<String, dynamic>? toMap(VendorApplication? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id ?? '';
      data['vendor_id'] = object.vendorId;
      data['user_id'] = object.userId;
      data['document'] = object.document;
      data['cover_letter'] = object.coverLetter;
      data['added_date_str'] = object.addedDateStr;


      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<VendorApplication?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (VendorApplication? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }
}
