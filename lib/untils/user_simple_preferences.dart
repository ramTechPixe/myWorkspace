import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  static const String isUserLoggedIn = 'isuserloggedin';
  static const String isFacebook = 'isFacebook';
  static const String isTwitter = 'isTwitter';
  static const String isLinkedIn = 'isLinkedIn';
  static const String isTumblr = 'isTumblr';
  static const String isPinterest = 'isPinterest';
  static const String isGoogleBusinessProfile = 'isGoogleBusinessProfile';
  static const String isInstagram = 'isInstagram';
  static const String isYouTube = 'isYouTube';
  static const String isWordPress = 'isWordPress';
  static const String isToken = 'token';

  static const String userDataLocal = 'userData';
  static const String isRefreshToken = 'refresh_token';
  static const String isFingerprint = 'true';
  static const String fcmToken = 'fcmToken';
  static const String uniquecode = 'uniquecode';

  ///
  static const String isUserId = 'userId';

  ///
  static const String clientName = 'clientName';
  static const String clientId = 'clientId';
  static const String role = 'role';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setLoginStatus({required bool loginStatus}) async {
    await _preferences.setBool(isUserLoggedIn, loginStatus);
  }

  static bool? getLoginStatus() {
    return _preferences.getBool(isUserLoggedIn);
  }
  // for networks

//
  static Future setfcmToken(String? token) async {
    await _preferences.setString(fcmToken, token!);
  }

  static String? getfcmToken() {
    return (_preferences.getString(fcmToken));
  }

  static Future setuniquecode(String? identifier) async {
    await _preferences.setString(uniquecode, identifier!);
  }

  static String? getuniquecode() {
    return (_preferences.getString(uniquecode));
  }

  static Future setUserdata({required String userData}) async {
    await _preferences.setString(userDataLocal, userData);
  }

  static String? getUserdata() {
    return (_preferences.getString(userDataLocal));
  }

  static Future setfingerprintdata({required String userData}) async {
    await _preferences.setString(isFingerprint, userData);
  }

  static Future setRefreshToken({required String refreshToken}) async {
    await _preferences.setString(isRefreshToken, refreshToken);
  }

  static String? getRefreshToken() {
    return _preferences.getString(isRefreshToken);
  }

  static String? getfingerprintdata() {
    return (_preferences.getString(isFingerprint));
  }

  static Future setToken({required String token}) async {
    await _preferences.setString(isToken, token);
  }

  static String? getToken() {
    return _preferences.getString(isToken);
  }

  /////
  static Future setUserid({required String userId}) async {
    await _preferences.setString(isUserId, userId);
  }

  static String? getUserid() {
    return _preferences.getString(isUserId);
  }

  //new for workspace
  static Future setClientName({required String name}) async {
    await _preferences.setString(clientName, name);
  }

  static String? getClientName() {
    return _preferences.getString(clientName);
  }

  static Future setClientId({required String id}) async {
    await _preferences.setString(clientId, id);
  }

  static String? getClientId() {
    return _preferences.getString(clientId);
  }

  static Future setRole({required String userRole}) async {
    await _preferences.setString(role, userRole);
  }

  static String? getRole() {
    return _preferences.getString(role);
  }

  static void clearAllData() {
    _preferences.clear();
  }
}
