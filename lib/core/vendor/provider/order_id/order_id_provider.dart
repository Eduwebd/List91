import 'package:flutter/material.dart';

import '../../viewobject/all_billing_address.dart';
import '../../viewobject/all_shipping_address.dart';
import '../../viewobject/default_billing_and_shipping.dart';
import '../../viewobject/holder/billing_address_holder.dart';
import '../../viewobject/holder/shipping_address_holder.dart';

class OrderIdProvider extends ChangeNotifier {
  OrderIdProvider._singleton();

  static OrderIdProvider get instance => OrderIdProvider._singleton();

  String _shippingPhoneCode = '';
  String _billingPhoneCode = '';

  String get shippingPhoneCode => _shippingPhoneCode;
  String get billingPhoneCode => _billingPhoneCode;
  List<AllBillingAddress>? _allBillingAddress;
  List<AllBillingAddress>? get allBillingAddress => _allBillingAddress;

  AllBillingAddress? _chooseBillingAddress;
  AllBillingAddress? get chooseBillingAddress => _chooseBillingAddress;
  set chooseBillingAddress(AllBillingAddress? val) {
    _chooseBillingAddress = val;
    notifyListeners();
  }

  AllShippingAddress? _chooseShippingAddress;
  AllShippingAddress? get chooseShippingAddress => _chooseShippingAddress;
  set chooseShippingAddress(AllShippingAddress? val) {
    _chooseShippingAddress = val;
    notifyListeners();
  }

  set allBillingAddress(List<AllBillingAddress>? val) {
    _allBillingAddress = val;
    notifyListeners();
  }

  set shippingPhoneCode(String value) {
    _shippingPhoneCode = value;
    notifyListeners();
  }

  set billingPhoneCode(String value) {
    _billingPhoneCode = value;
    notifyListeners();
  }

  DefaultBillingAndShipping? _defaultBillingAndShipping;
  DefaultBillingAndShipping get defaultBillingAndShipping =>
      _defaultBillingAndShipping ?? DefaultBillingAndShipping();
  set defaultBillingAndShipping(DefaultBillingAndShipping? val) {
    _defaultBillingAndShipping = val;
    notifyListeners();
  }

  //itemCount
  int _count = 1;
  int get count => _count;
  set count(int value) {
    _count = value;
    notifyListeners();
  }

//update paymentMethods
  int _selectedValue = 0;
  int get selectedValue => _selectedValue;
  set selectedValue(int val) {
    _selectedValue = val;
    notifyListeners();
  }

  //Same as ShippingAddress
  // bool _isSameAsShippingAddress = false;
  // bool get isSameAsShippingAddress => _isSameAsShippingAddress;
  // set isSameAsShippingAddress(bool val) => _isSameAsShippingAddress = val;

//Billing
  BillingAddressHolder _billingAddressHolder = BillingAddressHolder();
  BillingAddressHolder get billingAddressHolder => _billingAddressHolder;
  set billingAddressHolder(BillingAddressHolder value) {
    _billingAddressHolder = value;
    notifyListeners();
  }

//Shipping
  ShippingAddressHolder _shippingAddressHolder = ShippingAddressHolder();
  ShippingAddressHolder get shippingAddressHolder => _shippingAddressHolder;
  set shippingAddressHolder(ShippingAddressHolder value) {
    _shippingAddressHolder = value;
    notifyListeners();
  }

//Update PaymentMethod
  void updateSelectedValue(int value) {
    selectedValue = value;
    notifyListeners();
  }

//Same as ShippingAddress
  // bool checkisSameAsShippingAddress(bool value) {
  //   _isSameAsShippingAddress = value;
  //   notifyListeners();
  //   return _isSameAsShippingAddress;
  // }

  void increment() {
    count = _count + 1;
    notifyListeners();
  }

  void decrement() {
    count = _count - 1;
    notifyListeners();
  }

  void clearAddress() {
    _shippingAddressHolder = ShippingAddressHolder();
    _billingAddressHolder = BillingAddressHolder();

    notifyListeners();
  }
}
