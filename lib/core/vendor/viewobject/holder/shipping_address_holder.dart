class ShippingAddressHolder {
  ShippingAddressHolder(
      {this.address,
      this.city,
      this.country,
      this.email,
      this.firstName,
      this.lastName,
      this.postalCode,
      this.state,
      this.phone,
      this.code});

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? address;
  final String? country;
  final String? state;
  final String? city;
  final String? postalCode;
  final String? phone;
  String? code;
}
