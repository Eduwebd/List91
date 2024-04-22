
import 'common/ps_object.dart';

class VendorPaymentAttributes extends PsObject<VendorPaymentAttributes>{

  VendorPaymentAttributes({
    this.currencyShortForm,
    this.currencySymbol,
    this.discountPrice,
    this.isMostPopularPlan,
    this.salePrice,
    this.status,
    this.vendorDuration,
    
  });
  String? vendorDuration;
  String? salePrice;
  String? discountPrice;
  String? status;
  String? currencySymbol;
  String? currencyShortForm;
  String? isMostPopularPlan;
  
  @override
  VendorPaymentAttributes fromMap(dynamic dynamicData) {
      return VendorPaymentAttributes(
        vendorDuration: dynamicData['duration'],
        salePrice: dynamicData['sale_price'],
        status: dynamicData['status'],
        discountPrice: dynamicData ['discount_price'],
        currencyShortForm: dynamicData['currency_short_form'],
        currencySymbol: dynamicData['currency_symbol'],
        isMostPopularPlan: dynamicData['is_most_popular_plan']
      );
  }
  
  @override
  List<VendorPaymentAttributes> fromMapList(List<dynamic> dynamicDataList) {
     final List<VendorPaymentAttributes> blogList = <VendorPaymentAttributes>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        blogList.add(fromMap(dynamicData));
      }
    }
    return blogList;
  }
  
  @override
  String? getPrimaryKey() {
   return '';
  }
  
  @override
  Map<String, dynamic>? toMap(VendorPaymentAttributes? object) {
     if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['duration'] = object.vendorDuration;
      data['sale_price'] = object.salePrice;
      data['discount_price'] = object.discountPrice;
      data['status'] = object.status;
      data['currency_symbol'] = object.currencySymbol;
      data['currency_short_form'] = object.currencyShortForm;
      data['is_most_popular_plan'] =object.isMostPopularPlan;
      return data;
    } else {
      return null;
    }
  }
  
  @override
  List<Map<String, dynamic>?> toMapList(List<VendorPaymentAttributes?> objectList) {
   final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (VendorPaymentAttributes? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }



}