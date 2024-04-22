import 'common/ps_object.dart';

class OrderId extends PsObject<OrderId> {
  OrderId({this.orderId});

  String? orderId;

  @override
  OrderId fromMap(dynamic dynamicData) {
    return OrderId(
      orderId: dynamicData['order_id'],
    );
  }

  @override
  List<OrderId> fromMapList(List<dynamic>? dynamicDataList) {
    final List<OrderId> list = <OrderId>[];
    if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        list.add(fromMap(element));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return orderId.toString();
  }

  @override
  Map<String, dynamic>? toMap(OrderId? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.orderId ?? '';

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<OrderId> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (OrderId? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }

//   bool get isPendingVendor {
//     return status == PsConst.ZERO;
//   }

//   bool get isRejectedVendor {
//     return status == PsConst.ONE;
//   }

//   bool get isOrderId {
//     return status == PsConst.TWO;
//   }
}
