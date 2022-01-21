import 'package:shared_preferences/shared_preferences.dart';
import '../models/model.dart';

class Util {
  Future<void> storeUserInformation(UsersInfo userI) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', userI.toJson());
  }

  Future<UsersInfo?> getUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEncoded = prefs.getString('user');
    if (userEncoded != null) {
      UsersInfo? user = UsersInfo.fromJson(userEncoded);
      return user;
    }
  }

  Future<void> storeTokenAndExpiration(String expiry, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('expiry', expiry);
  }

  Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token')!;
  }

  Future<String> getExpiryTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token')!;
  }

  DateTime getDateTimeFromString(String dateString) {
    return DateTime.parse(dateString);
  }

  bool isExpired(String expiry) {
    int timeExpiry = int.parse(expiry);
    var date = new DateTime.fromMicrosecondsSinceEpoch(timeExpiry * 1000);
    if (date.isAfter(DateTime.now())) return false;
    return true;
  }
}
