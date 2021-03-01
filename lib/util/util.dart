import 'package:shared_preferences/shared_preferences.dart';
import '../models/model.dart';

class Util {
  Future<void> storeUserInformation(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', user.id);
    await prefs.setInt('role_id', user.roleId);
    await prefs.setString('full_name', user.fullName);
    await prefs.setString('email', user.email);
    await prefs.setString('password', user.password);
    await prefs.setString('phone', user.phone);
    await prefs.setString('role_name', user.role.name);
  }

  Future<User> getUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = new User.fullInfo(
        id: prefs.getInt('id'),
        role: Role(id: prefs.getInt('id'), name: prefs.getString('role_name')),
        password: prefs.getString('password'),
        email: prefs.getString('email'),
        phone: prefs.getString('phone'),
        roleId: prefs.getInt('role_id'),
        fullName: prefs.getString('full_name'));
    return user;
  }

  Future<void> storeTokenAndExpiration(String expiry, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('expiry', expiry);
  }

  Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String> getExpiryTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
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
