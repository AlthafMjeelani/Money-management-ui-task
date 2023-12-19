import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static FlutterSecureStorage storage = const FlutterSecureStorage();
  //keys
  static String userLoggedinKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userMoileKey = "USERMOBILEKEY";
  static String userPPInKey = "LOGGEDPPKEY";
  static String nameKey = "NAMEKEY";

  // saving the data to SF

  static Future<void> saveUserLoggedInStatus(String isUserLoggedIn) async {
    storage.write(key: userLoggedinKey, value: isUserLoggedIn);
  }

  static Future<void> saveNameSF(String name) async {
    return await storage.write(key: nameKey, value: name);
  }

  static Future<void> saveUserEmailSF(String userEmail) async {
    return await storage.write(key: userEmailKey, value: userEmail);
  }

  static Future<void> saveUserMobileSF(String mobile) async {
    return await storage.write(key: userMoileKey, value: mobile);
  }

  static Future<void> saveUserPPSF(String userPP) async {
    return await storage.write(key: userPPInKey, value: userPP);
  }

  // getting the data from SF

  static Future<String?> getUserLoggedInStatus() async {
    return storage.read(key: userLoggedinKey);
  }

  static Future<String?> getNameSF() async {
    return storage.read(key: nameKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    return storage.read(key: userEmailKey);
  }

  static Future<String?> getUserMobileFromSF() async {
    return storage.read(key: userMoileKey);
  }

  static Future<String?> getUserPPSF() async {
    return storage.read(key: userPPInKey);
  }
}
