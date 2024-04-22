
import '../../constant/ps_constants.dart';
import '../common/ps_holder.dart';

class VendorBranchParameterHolder extends PsHolder<dynamic> {
  VendorBranchParameterHolder() {
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    keyword = '';
    vendorId= '';
  }

  String? orderBy;
  String? orderType;
  String? keyword;
  String? vendorId;


  VendorBranchParameterHolder getVendorParameterHolder() {
    orderBy = PsConst.CATEGORY_FILTERING__TRENDING;
    orderType = PsConst.FILTERING__DESC;
    keyword = '';
    vendorId= '';
    
    return this;
  }
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['order_by'] = orderBy;
    map['order_type'] = orderType;
    map['keyword'] = keyword;
    map['vendor_id'] = vendorId;

    return map;
  }

  @override
  dynamic fromMap(dynamic dynamicData) {
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    keyword = dynamicData['keyword'];
    vendorId = dynamicData['vendor_id'];

    return this;
  }

  @override
  String getParamKey() {
    String result = '';

    if (orderBy != '') {
      result += orderBy! + ':';
    }
    if (orderType != '') {
      result += orderType! + ':';
    }
    if (keyword != '') {
      result += keyword!;
    }
        if (vendorId != '') {
      result += vendorId! + ':';
    }

    return result;
  }
}
