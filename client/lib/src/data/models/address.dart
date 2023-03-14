import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;

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

class AddressAPI {
  String? name;
  String? phone;
  String? country;
  dvhcvn.Level1? province;
  dvhcvn.Level2? district;
  dvhcvn.Level3? ward;
  String? address;
  bool isDefault;

  AddressAPI({
    this.address,
    this.phone,
    this.name,
    this.country = "Việt Nam",
    this.province,
    this.district,
    this.ward,
    this.isDefault = false,
  });

  AddressAPI copyWith({
    String? name,
    String? phone,
    String? country,
    dvhcvn.Level1? province,
    dvhcvn.Level2? district,
    dvhcvn.Level3? ward,
    String? address,
    bool? isDefault,
  }) {
    return AddressAPI(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      address: address ?? this.address,
      isDefault: isDefault ?? this.isDefault,
      district: district,
      province: province,
      ward: ward,
    );
  }

  Address toAddress() {
    return Address(
      address: address ?? "",
      phone: phone ?? "",
      name: name ?? "",
      country: country ?? "Việt Nam",
      province: province != null ? province!.name : "",
      district: district != null ? district!.name : "",
      ward: ward != null ? ward!.name : "",
    );
  }
}
