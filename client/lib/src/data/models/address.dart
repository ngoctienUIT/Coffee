class Address {
  String name;
  String phone;
  String country;
  String province;
  String district;
  String ward;
  String address;
  bool isDefault;

  Address({
    required this.address,
    required this.phone,
    required this.name,
    required this.country,
    required this.province,
    required this.district,
    required this.ward,
    this.isDefault = false,
  });
}
