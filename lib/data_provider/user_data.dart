import 'dart:convert';
import 'dart:async';
import 'dart:io';
import '../models/http_exception.dart';
import '../models/user.dart';
import '../util/util.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final http.Client httpClient;

  UserDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Util util = new Util();
  Future<List<User>> getUsers() async {
    final url = 'http://192.168.137.1:8080/v1/admin/users';
    List<User> users;
    try {
      String token = await util.getUserToken();
      String expiry = await util.getExpiryTime();
      final response = await httpClient.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
        'expiry': expiry
      });

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        if (extractedData == null) {
          return null;
        }
        users = extractedData.map<User>((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw e;
    }
    return users;
  }

  Future<User> login(User user) async {
    User user1;
    final urlLogin = 'http://192.168.137.1:8080/v1/user/login';
    try {
      final response = await http.post(
        urlLogin,
        body: json.encode({
          'id': user.id,
          'email': user.email,
          'full_name': user.email,
          'phone': user.phone,
          'password': user.password,
          'role_id': user.roleId,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 422) {
        throw HttpException('Invalid Input');
      } else if (response.statusCode == 404) {
        throw HttpException('Incorrect username or password');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        user1 = User.fromJson(extractedData);
        print(user1.role.name);
        String token = response.headers['token'].toString();
        String expiry = response.headers['expiry_date'].toString();

        await util.storeUserInformation(user1);
        await util.storeTokenAndExpiration(expiry, token);
      }
    } catch (e) {
      throw e;
    }
    return user1;
  }

  Future<User> signUp(User user) async {
    final urlEmailCheck = 'http://192.168.137.1:8080/v1/user/email/${user.email}';
    final urlPhoneCheck = 'http://192.168.137.1:8080/v1/user/phone/${user.phone}';
    final urlPostUser = 'http://192.168.137.1:8080/v1/user/signup';
    User user1;
    try {
      var response = await httpClient.get(
        urlEmailCheck,
      );
      if (response.statusCode == 200) {
        final isEmailExist = json.decode(response.body) as bool;
        if (isEmailExist) {
          throw HttpException('Email already exists!');
        } else {
          response = await httpClient.get(urlPhoneCheck);

          if (response.statusCode == 500) {
            throw HttpException('Error occurred !');
          } else {
            final isPhoneExist = json.decode(response.body) as bool;
            if (isPhoneExist) {
              throw HttpException('Phone No already exists!');
            } else {
              response = await httpClient.post(
                urlPostUser,
                body: json.encode({
                  'id': user.id,
                  'email': user.email,
                  'password': user.password,
                  'full_name': user.fullName,
                  'phone': user.phone,
                  'role_id': user.roleId,
                }),
                headers: {
                  HttpHeaders.contentTypeHeader: "application/json",
                },
              );

              if (response.statusCode == 200) {
                final extractedData =
                    json.decode(response.body) as Map<String, dynamic>;
                user1 = User.fromJson(extractedData);
                String token = response.headers['Token'].toString();
                String expiry = response.headers['Expiry_date'].toString();
                await util.storeUserInformation(user1);
                await util.storeTokenAndExpiration(expiry, token);
              } else {
                throw HttpException('Error occurred');
              }
            }
          }
        }
      } else {
        throw HttpException('Error occurred !');
      }
    } catch (e) {
      throw e;
    }
    return user1;
  }

  Future<User> updateUser(User user) async {
    User updated;
    final url = 'http://192.168.137.1:8080/user/users/${user.id}';
    try {
      String token = await util.getUserToken();
      String expiry = await util.getExpiryTime();
      final response = await httpClient.put(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
          'expiry': expiry
        },
        body: json.encode({
          'id': user.id,
          'email': user.email,
          'password': user.password,
          'full_name': user.fullName,
          'phone': user.phone,
          'role_id': user.roleId,
        }),
      );
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        updated = User.fromJson(extractedData);
      } else {
        throw HttpException('Error Occurred');
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
    return updated;
  }

  Future<User> updateUserPassword(User user, String oldPassword) async {
    User updated;
    final url = 'http://192.168.137.1:8080/v1/user/users/${user.id}';
    final urlCheckPassword = 'http://192.168.137.1:8080/v1/user/password/${user.id}';
    try {
      String token = await util.getUserToken();
      String expiry = await util.getExpiryTime();
      final response = await httpClient.post(
        urlCheckPassword,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
          'expiry': expiry
        },
        body: json.encode({
          'id': user.id,
          'email': user.email,
          'password': oldPassword,
          'full_name': user.fullName,
          'phone': user.phone,
          'role_id': user.roleId,
        }),
      );
      if (response.statusCode == 200) {
        final response2 = await httpClient.put(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token",
            'expiry': expiry
          },
          body: json.encode({
            'id': user.id,
            'email': user.email,
            'password': user.password,
            'full_name': user.fullName,
            'phone': user.phone,
            'role_id': user.roleId,
          }),
        );
        if (response2.statusCode == 200) {
          final extractedData =
              json.decode(response2.body) as Map<String, dynamic>;
          updated = User.fromJson(extractedData);
        } else {
          throw HttpException('Error Occurred');
        }
      } else if (response.statusCode == 404) {
        throw HttpException('Incorrect Old Password');
      } else {
        throw HttpException('Error Occurred');
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
    return updated;
  }
}
