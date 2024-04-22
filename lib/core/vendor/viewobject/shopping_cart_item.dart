import 'common/ps_object.dart';
import 'default_photo.dart';

class ShoppingCartItem extends PsObject<ShoppingCartItem> {
  ShoppingCartItem(
      {this.cartItemId,
      this.itemId,
      this.itemName,
      this.originalPrice,
      this.salePrice,
      this.discountPrice,
      this.vendorCurrencySymbol,
      this.quantity,
      this.availableQuantity,
      this.subTotal,
      this.isSoldOut,
      this.defaultPhoto});

  String? cartItemId;
  String? itemId;
  String? itemName;
  String? originalPrice;
  String? salePrice;
  String? discountPrice;
  String? vendorCurrencySymbol;
  String? quantity;
  String? availableQuantity;
  String? subTotal;
  String? isSoldOut;
  DefaultPhoto? defaultPhoto;

  @override
  ShoppingCartItem fromMap(dynamic dynamicData) {
    return ShoppingCartItem(
      cartItemId: dynamicData['cart_item_id'],
      itemId: dynamicData['item_id'],
      itemName: dynamicData['item_name'],
      originalPrice: dynamicData['original_price'],
      salePrice: dynamicData['sale_price'],
      discountPrice: dynamicData['discount_price'],
      vendorCurrencySymbol: dynamicData['vendor_currency_symbol'],
      quantity: dynamicData['quantity'],
      availableQuantity: dynamicData['available_quantity'],
      subTotal: dynamicData['sub_total'],
      isSoldOut: dynamicData['is_sold_out'],
      defaultPhoto: DefaultPhoto().fromMap(dynamicData['default_photo']),
    );
  }

  @override
  List<ShoppingCartItem> fromMapList(List<dynamic>? dynamicDataList) {
    final List<ShoppingCartItem> list = <ShoppingCartItem>[];
    if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        list.add(fromMap(element));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return cartItemId.toString();
  }

  @override
  Map<String, dynamic>? toMap(ShoppingCartItem? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['cart_item_id'] = object.cartItemId;
      data['item_id'] = object.itemId;
      data['item_name'] = object.itemName;
      data['original_price'] = object.originalPrice;
      data['sale_price'] = object.salePrice;
      data['discount_price'] = object.discountPrice;
      data['vendor_currency_symbol'] = object.vendorCurrencySymbol;
      data['quantity'] = object.quantity;
      data['available_quantity'] = object.availableQuantity;
      data['sub_total'] = object.subTotal;
      data['is_sold_out'] = object.isSoldOut;
      data['default_photo'] = DefaultPhoto().toMap(object.defaultPhoto);

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ShoppingCartItem> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (ShoppingCartItem? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }
}
