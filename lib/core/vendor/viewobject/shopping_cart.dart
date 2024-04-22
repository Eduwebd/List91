import 'common/ps_object.dart';
import 'shopping_cart_item.dart';

class ShoppingCart extends PsObject<ShoppingCart> {
  ShoppingCart(
      {this.items,
      this.vendorId,
      this.vendorName,
      this.vendorCurrencySymbol,
      this.vendorCurrencyShortForm,
      this.subTotal,
      this.totalDiscount,
      this.deliveryFee,
      this.total});

  List<ShoppingCartItem>? items;
  String? vendorId;
  String? vendorName;
  String? vendorCurrencySymbol;
  String? vendorCurrencyShortForm;
  String? subTotal;
  String? totalDiscount;
  String? deliveryFee;
  String? total;

  @override
  ShoppingCart fromMap(dynamic dynamicData) {
    return ShoppingCart(
        items: ShoppingCartItem().fromMapList(dynamicData['items']),
        vendorId: dynamicData['vendor_id'],
        vendorName: dynamicData['vendor_name'],
        vendorCurrencySymbol: dynamicData['vendor_currency_symbol'],
        vendorCurrencyShortForm: dynamicData['vendor_currency_short_form'],
        subTotal: dynamicData['sub_total'],
        totalDiscount: dynamicData['total_discount'],
        deliveryFee: dynamicData['delivery_fee'],
        total: dynamicData['total']);
  }

  @override
  List<ShoppingCart> fromMapList(List<dynamic>? dynamicDataList) {
    final List<ShoppingCart> list = <ShoppingCart>[];
    if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        list.add(fromMap(element));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return '';
  }

  @override
  Map<String, dynamic>? toMap(ShoppingCart? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['items'] = ShoppingCartItem().toMapList(object.items!);
      data['vendor_id'] = object.vendorId;
      data['vendor_name'] = object.vendorName;
      data['vendor_currency_symbol'] = object.vendorCurrencySymbol;
      data['vendor_currency_short_form'] = object.vendorCurrencyShortForm;
      data['sub_total'] = object.subTotal;
      data['total_discount'] = object.totalDiscount;
      data['delivery_fee'] = object.deliveryFee;
      data['total'] = object.total;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ShoppingCart> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (ShoppingCart? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }
}
