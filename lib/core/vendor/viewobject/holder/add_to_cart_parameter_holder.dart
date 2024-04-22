import '../common/ps_holder.dart';

class AddToCartParameterHolder extends PsHolder<AddToCartParameterHolder> {
  AddToCartParameterHolder({
    this.vendorId,
    this.itemId,
    this.quantity,
    this.userId
  });

  String? vendorId;
  String? itemId;
  String? quantity;
  String? userId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['vendor_id'] = vendorId;
    map['item_id'] = itemId;
    map['quantity'] = quantity;
    map['user_id'] = userId;

    return map;
  }

    @override
  AddToCartParameterHolder fromMap(dynamic dynamicData) {
    return AddToCartParameterHolder(
      vendorId: dynamicData['vendor_id'],
      itemId: dynamicData['item_id'],
      quantity: dynamicData['quantity'],
      userId: dynamicData['userId']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (vendorId != '') {
      key += vendorId! + ':';
    }
    if (itemId != '') {
      key += itemId ?? '';
    }
    if (quantity != '') {
      key += quantity ?? '';
    }
    if (userId != '') {
      key += userId ?? '';
    }
    return key;
  }
}
