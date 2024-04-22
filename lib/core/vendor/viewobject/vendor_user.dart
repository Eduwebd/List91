import '../constant/ps_constants.dart';
import 'common/ps_object.dart';
import 'default_photo.dart';
import 'vendor_application.dart';
import 'vendor_relation.dart';

class VendorUser extends PsObject<VendorUser> {
  VendorUser(
      {this.id,
      this.ownerUserId,
      this.status,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.description,
      this.website,
      this.facebook,
      this.instagram,
      this.addedDate,
      this.currencyId,
      this.expiredDate,
      this.expiredStatus,
      this.addedDateStr,
      this.updatedFlag,
      this.productCount,
      this.vendorRelation,
      this.logo,
      this.banner1,
      this.banner2,
      this.vendorApplication});

  String? id;
  String? ownerUserId;
  String? status;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? description;
  String? website;
  String? facebook;
  String? instagram;
  String? addedDate;
  String? currencyId;
  String? expiredDate;
  int? expiredStatus;
  // String? addedUserId;
  // String? updatedUserId;
  String? addedDateStr;
  String? updatedFlag;
  String? productCount;
  DefaultPhoto? logo;
  DefaultPhoto? banner1;
  DefaultPhoto? banner2;
  VendorApplication? vendorApplication;
  List<VendorRelation>? vendorRelation;

  @override
  VendorUser fromMap(dynamic dynamicData) {
    return VendorUser(
      id: dynamicData['id'] ?? '',
      ownerUserId: dynamicData['owner_user_id'],
      status: dynamicData['status'],
      name: dynamicData['name'],
      phone: dynamicData['phone'],
      email: dynamicData['email'],
      address: dynamicData['address'],
      description: dynamicData['description'],
      website: dynamicData['website'],
      facebook: dynamicData['facebook'],
      instagram: dynamicData['instagram'],
      addedDate: dynamicData['added_date'],
      expiredDate: dynamicData['expired_date'],
      expiredStatus: dynamicData['expire_status'],
      addedDateStr: dynamicData['added_date_str'],
      currencyId: dynamicData['currency_id'],
      updatedFlag: dynamicData['updated_flag'],
      productCount: dynamicData['product_count'],
      logo: DefaultPhoto().fromMap(dynamicData['logo']),
      banner1: DefaultPhoto().fromMap(dynamicData['banner_1']),
      banner2: DefaultPhoto().fromMap(dynamicData['banner_2']),
      vendorApplication:
          VendorApplication().fromMap(dynamicData['vendor_application']),
      vendorRelation:
          VendorRelation().fromMapList(dynamicData['vendorRelation']),
    );
  }

  @override
  List<VendorUser> fromMapList(List<dynamic>? dynamicDataList) {
    final List<VendorUser> list = <VendorUser>[];
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
  Map<String, dynamic>? toMap(VendorUser? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id ?? '';
      data['owner_user_id'] = object.ownerUserId;
      data['status'] = object.status;
      data['name'] = object.name;
      data['phone'] = object.phone;
      data['email'] = object.email;
      data['address'] = object.address;
      data['description'] = object.description;
      data['website'] = object.website;
      data['facebook'] = object.facebook;
      data['instagram'] = object.instagram;
      data['added_date'] = object.addedDate;
      data['expired_date'] = object.expiredDate;
      data['expire_status'] = object.expiredStatus;
      data['added_date_str'] = object.addedDateStr;
      data['currency_id'] = object.currencyId;
      data['updated_flag'] = object.updatedFlag;
      data['product_count'] = object.productCount;
      data['logo'] = DefaultPhoto().toMap(object.logo);
      data['banner_1'] = DefaultPhoto().toMap(object.banner1);
      data['banner_2'] = DefaultPhoto().toMap(object.banner2);
      data['vendor_application'] =
          VendorApplication().toMap(object.vendorApplication);
      data['vendorRelation'] =
          VendorRelation().toMapList(object.vendorRelation!);

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<VendorUser> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (VendorUser? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }

  bool get isPendingVendor {
    return status == PsConst.ZERO;
  }

  bool get isRejectedVendor {
    return status == PsConst.ONE;
  }

  bool get isVendorUser {
    return status == PsConst.TWO;
  }
}
