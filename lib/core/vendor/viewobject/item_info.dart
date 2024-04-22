import 'package:quiver/core.dart';

import 'common/ps_object.dart';
import 'default_photo.dart';

class ItemInfo extends PsObject<ItemInfo> {
  ItemInfo(
      {this.itemId,
      this.discountPrice,
      this.itemName,
      this.originalPrice,
      this.quantity,
      this.salePrice,
      this.subTotal,
      this.defaultPhoto});
  String? itemId;
  String? itemName;
  String? originalPrice;
  String? salePrice;
  String? discountPrice;
  String? quantity;
  String? subTotal;
  DefaultPhoto? defaultPhoto;

  @override
  bool operator ==(dynamic other) =>
      other is ItemInfo && itemId == other.itemId;

  @override
  int get hashCode => hash2(itemId.hashCode, itemId.hashCode);

  @override
  String? getPrimaryKey() {
    return itemId;
  }

  @override
  ItemInfo fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return ItemInfo(
      itemId: dynamicData['item_id'],
      itemName: dynamicData['item_name'],
      originalPrice: dynamicData['original_price'],
      salePrice: dynamicData['sale_price'],
      discountPrice: dynamicData['discount_price'],
      quantity: dynamicData['quantity'],
      subTotal: dynamicData['sub_total'],
      defaultPhoto: DefaultPhoto().fromMap(dynamicData['default_photo']),
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};

      data['item_id'] = object.itemId;
      data['item_name'] = object.itemName;
      data['original_price'] = object.originalPrice;
      data['sale_price'] = object.salePrice;
      data['discount_price'] = object.discountPrice;
      data['quantity'] = object.quantity;
      data['sub_total'] = object.subTotal;
      data['default_photo'] = DefaultPhoto().toMap(object.defaultPhoto);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<ItemInfo> fromMapList(List<dynamic> dynamicDataList) {
    final List<ItemInfo> newFeedList = <ItemInfo>[];
    // if (dynamicDataList != null) {
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        newFeedList.add(fromMap(json));
      }
    }
    print('newFeedList=>$newFeedList');
    // }
    return newFeedList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ItemInfo> objectList) {
    final List<Map<String, dynamic>?> dynamicList = <Map<String, dynamic>?>[];

    // if (objectList != null) {
    for (dynamic data in objectList) {
      if (data != null) {
        dynamicList.add(toMap(data));
      }
    }
    // }
    return dynamicList;
  }
}
