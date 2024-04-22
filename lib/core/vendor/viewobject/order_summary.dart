import 'package:quiver/core.dart';

import 'common/ps_object.dart';
import 'order_summary_detail.dart';

class OrderSummaryModel extends PsObject<OrderSummaryModel> {
  OrderSummaryModel({this.orderSummaryDetail});
  OrderSummaryDetail? orderSummaryDetail;
  @override
  bool operator ==(dynamic other) =>
      other is OrderSummaryModel &&
      orderSummaryDetail == other.orderSummaryDetail;

  @override
  int get hashCode =>
      hash2(orderSummaryDetail.hashCode, orderSummaryDetail.hashCode);

  @override
  String? getPrimaryKey() {
    return orderSummaryDetail.toString();
  }

  @override
  OrderSummaryModel fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return OrderSummaryModel(
      orderSummaryDetail:
          OrderSummaryDetail().fromMap(dynamicData['order_summary']),
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};

      data['order_summary'] =
          OrderSummaryDetail().toMap(object.orderSummaryDetail);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<OrderSummaryModel> fromMapList(List<dynamic> dynamicDataList) {
    final List<OrderSummaryModel> newFeedList = <OrderSummaryModel>[];
    // if (dynamicDataList != null) {
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        newFeedList.add(fromMap(json));
      }
    }
    // }
    return newFeedList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
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
