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
    return AddressAPI(
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

  AddressAPI copyWith({
    String? country,
    dvhcvn.Level1? province,
    dvhcvn.Level2? district,
    dvhcvn.Level3? ward,
    String? address,
  }) {
    return AddressAPI(
      country: country ?? this.country,
      address: address ?? this.address,
      district: district ?? this.district,
      province: province ?? this.province,
      ward: ward ?? this.ward,
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
