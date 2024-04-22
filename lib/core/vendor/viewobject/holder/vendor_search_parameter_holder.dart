import '../../constant/ps_constants.dart';
import '../common/ps_holder.dart';
import '../vendor_product_relation.dart';

class VendorSearchParameterHolder
    extends PsHolder<VendorSearchParameterHolder> {
  VendorSearchParameterHolder(
      {this.searchterm,
      this.ownerUserId,
      this.orderBy,
      this.orderType,
      this.status,
      this.productRelation});

  String? searchterm;
  String? ownerUserId;
  String? orderBy;
  String? orderType;
  String? status;
  List<VendorProductRelation>? productRelation;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['searchterm'] = searchterm;
    map['owner_user_id'] = ownerUserId;
    map['order_by'] = orderBy;
    map['order_type'] = orderType;
    map['status'] = status;
    map['product_relation'] = productRelation;

    return map;
  }

  @override
  VendorSearchParameterHolder fromMap(dynamic dynamicData) {
    return VendorSearchParameterHolder(
      searchterm: dynamicData['searchterm'],
      ownerUserId: dynamicData['owner_user_id'],
      orderBy: dynamicData['order_by'],
      orderType: dynamicData['order_type'],
      status: dynamicData['status'],
      productRelation: dynamicData['product_relation'],
    );
  }

  VendorSearchParameterHolder getAllVendor() {
    return VendorSearchParameterHolder(
      searchterm: '',
      ownerUserId: '',
      orderBy: PsConst.FILTERING__NAME,
      orderType: PsConst.FILTERING__DESC,
      status: '2',
      productRelation: <VendorProductRelation>[]
    );
  }
  VendorSearchParameterHolder getDesc() {
    return VendorSearchParameterHolder(
      searchterm: '',
      ownerUserId: '',
      orderBy: PsConst.FILTERING__NAME,
      orderType: PsConst.FILTERING__DESC,
      status: '2',
      productRelation: <VendorProductRelation>[]
    );
  }
  VendorSearchParameterHolder getAsc() {
    return VendorSearchParameterHolder(
      searchterm: '',
      ownerUserId: '',
      orderBy: PsConst.FILTERING__NAME,
      orderType: PsConst.FILTERING__ASC,
      status: '2',
      productRelation: <VendorProductRelation>[]
    );
  }

  @override
  String getParamKey() {
    return '';
  }
}
