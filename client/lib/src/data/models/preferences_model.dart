class PreferencesModel {
  String? token;
  String? username;
  String? userID;
  String? storeID;
  String? address;
  bool isBringBack;

  PreferencesModel({
    this.token,
    this.username,
    this.userID,
    this.storeID,
    this.address,
    this.isBringBack = false,
  });
}
