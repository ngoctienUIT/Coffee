import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;

class Address {
  String country;
  String province;
  String district;
  String ward;
  String address;

  Address({
    required this.address,
    this.country = "Việt Nam",
    required this.province,
    required this.district,
    required this.ward,
  });

  String getAddress() => "$address, $ward, $district, $province, $country";
}

class AddressAPI {
  String? country;
  dvhcvn.Level1? province;
  dvhcvn.Level2? district;
  dvhcvn.Level3? ward;
  String? address;

  AddressAPI({
    this.address,
    this.country = "Việt Nam",
    this.province,
    this.district,
    this.ward,
  });

  factory AddressAPI.fromAddress(Address address) {
    dvhcvn.Level1? province = dvhcvn.findLevel1ByName(address.province);
    dvhcvn.Level2? district = province!.findLevel2ByName(address.district);
    dvhcvn.Level3? ward = district!.findLevel3ByName(address.ward);
    return AddressAPI(
      address: address.address,
      country: address.country,
      province: province,
      district: district,
      ward: ward,
    );
  }

  AddressAPI copyWith({
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
      country: country ?? "Việt Nam",
      province: province != null ? province!.name : "",
      district: district != null ? district!.name : "",
      ward: ward != null ? ward!.name : "",
    );
  }

  bool checkNull() =>
      province == null ||
      district == null ||
      ward == null ||
      address == null ||
      address!.isEmpty;
}
