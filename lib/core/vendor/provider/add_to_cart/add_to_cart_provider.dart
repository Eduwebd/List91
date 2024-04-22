import '../../../../core/vendor/repository/add_to_cart_repository.dart';
import '../../../../core/vendor/viewobject/shopping_cart.dart';
import '../../../../core/vendor/viewobject/shopping_cart_item.dart';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../viewobject/api_status.dart';
import '../common/ps_provider.dart';

class AddToCartProvider extends PsProvider<ShoppingCart> {
  AddToCartProvider({required AddToCartRepository repo, int limit = 0})
      : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  PsResource<ApiStatus> _addToCartStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);

  PsResource<ApiStatus> _deleteItemFromCartStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);

  final List<int> _selectedAvaliableCartId = <int>[];
  final List<int> _getAllShoppingCartId = <int>[];

  List<ShoppingCartItem> _availableShoppingCartList = <ShoppingCartItem>[];
  List<ShoppingCartItem> _soldOutShoppingCartList = <ShoppingCartItem>[];

  ShoppingCartItem _singleItemCheckoutItem = ShoppingCartItem();

  PsResource<ShoppingCart> get shoppingCart => super.data;

  PsResource<ApiStatus> get addToCartStatus => _addToCartStatus;

  PsResource<ApiStatus> get deleteItemFromCartStatus =>
      _deleteItemFromCartStatus;

  List<ShoppingCartItem> get availableShoppingCartList =>
      _availableShoppingCartList;
  List<ShoppingCartItem> get soldOutShoppingCartList =>
      _soldOutShoppingCartList;
  ShoppingCartItem get singleItemCheckoutItem => _singleItemCheckoutItem;

  List<int> get selectedAvaliableCartId => _selectedAvaliableCartId;
  List<int> get getAllShoppingCartId => _getAllShoppingCartId;

  late AddToCartRepository _repo;

  void addSelectedAvaliaveItem(String selectedCartId) {
    _selectedAvaliableCartId.add(int.parse(selectedCartId));
    notifyListeners();
  }

  void removeSelectedAvaliaveItem(String selectedCartId) {
    _selectedAvaliableCartId.remove(int.parse(selectedCartId));
    notifyListeners();
  }

  void addAvaliavleShoppingCartList(List<ShoppingCartItem> list) {
    _availableShoppingCartList = list;
  }

  void addSoldOutShoppingCartList(List<ShoppingCartItem> list) {
    _soldOutShoppingCartList = list;
  }

  void addSingleItemCheckoutItem(ShoppingCartItem item) {
    _singleItemCheckoutItem = item;
    notifyListeners();
  }

  void addAllShoppingCartId(String id) {
    _getAllShoppingCartId.add(int.parse(id));
    notifyListeners();
  }

  Future<dynamic> submitAddToCart(Map<dynamic, dynamic> jsonMap,
      String? loginUserId, String? languageCode) async {
    _addToCartStatus =
        await _repo.submitAddToCart(jsonMap, loginUserId, languageCode);

    return _addToCartStatus;
  }

  Future<dynamic> deleteItemFromCart(List<int> deleteCartList,
      String? loginUserId, String? languageCode) async {
    // ignore: always_specify_types
    final Map jsonMap = <String, dynamic>{'cart_item_ids': deleteCartList};
    _deleteItemFromCartStatus =
        await _repo.deleteItemFromCart(jsonMap, loginUserId, languageCode);

    return _deleteItemFromCartStatus;
  }
}
