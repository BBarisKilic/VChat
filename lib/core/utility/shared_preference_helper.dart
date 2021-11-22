import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String sharedPreferenceUserLoggedInKey = 'LOGGED_IN_KEY';
  static String sharedPreferenceUserNameKey = 'USER_NAME_KEY';
  static String sharedPreferenceUserEmailKey = 'USER_EMAIL_KEY';
  static String sharedPreferenceUserImageKey = 'USER_IMAGE_KEY';
  static String sharedPreferenceUserRegisterDateKey = 'USER_REGISTER_DATE_KEY';
  static String sharedPreferenceUserFCMTokenKey = 'USER_FCM_TOKEN_KEY';
  static String sharedPreferenceUserIdKey = 'USER_ID_KEY';

  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<bool> saveUserImageSharedPreference(String imageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserImageKey, imageUrl);
  }

  static Future<bool> saveUserRegisterDateSharedPreference(
      int registerDate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPreferenceUserRegisterDateKey, registerDate.toString());
  }

  static Future<bool> saveUserFCMTokenSharedPreference(String fcmToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPreferenceUserFCMTokenKey, fcmToken);
  }

  static Future<bool> saveUserIdSharedPreference(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserIdKey, userId);
  }

  static Future<bool?> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String?> getUserNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<String?> getUserEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserEmailKey);
  }

  static Future<String?> getUserImageSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserImageKey);
  }

  static Future<String?> getUserRegisterDatePreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserRegisterDateKey);
  }

  static Future<String?> getUserFCMTokenSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserFCMTokenKey);
  }

  static Future<String?> getUserIdSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserIdKey);
  }
}
