import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;

class Address {
  String name;
  String phone;
  String country;
  String province;
  String district;
  String ward;
  String address;

  Address({
    required this.address,
    required this.phone,
    required this.name,
    required this.country,
    required this.province,
    required this.district,
    required this.ward,
  });

  String getAddress() => "$address, $ward, $district, $province, $country";
}

class AddressAPI {
  String? name;
  String? phone;
  String? country;
  dvhcvn.Level1? province;
  dvhcvn.Level2? district;
  dvhcvn.Level3? ward;
  String? address;

  AddressAPI({
    this.address,
    this.phone,
    this.name,
    this.country = "Việt Nam",
    this.province,
    this.district,
    this.ward,
  });

  factory AddressAPI.fromAddress(Address address) {
    return AddressAPI(
      phone: address.phone,
      name: address.name,
      address: address.address,
      province: dvhcvn.findLevel1ByName(address.province),
      district: dvhcvn
          .findLevel1ByName(address.province)!
          .findLevel2ByName(address.district),
      ward: dvhcvn
          .findLevel1ByName(address.province)!
          .findLevel2ByName(address.district)!
          .findLevel3ByName(address.ward),
      country: address.country,
    );
  }

  bool checkNull() => province == null || district == null || ward == null;

  AddressAPI copyWith({
    String? name,
    String? phone,
    String? country,
    dvhcvn.Level1? province,
    dvhcvn.Level2? district,
    dvhcvn.Level3? ward,
    String? address,
    bool isProvince = true,
    bool isDistrict = true,
    bool isWard = true,
  }) {
    return AddressAPI(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      address: address ?? this.address,
      district: isDistrict ? district : district ?? this.district,
      province: isProvince ? province : province ?? this.province,
      ward: isWard ? ward : ward ?? this.ward,
    );
  }

  Address toAddress() {
    return Address(
      address: address ?? "",
      phone: phone ?? "",
      name: name ?? "",
      country: country ?? "Việt Nam",
      province: province?.name ?? "",
      district: district?.name ?? "",
      ward: ward?.name ?? "",
    );
  }
}
