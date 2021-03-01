import 'dart:convert';
import 'dart:async';
import 'dart:io';
import '../models/http_exception.dart';
import '../models/user.dart';
import '../util/util.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class RoleDataProvider {
  final http.Client httpClient;

  RoleDataProvider({@required this.httpClient}) : assert(httpClient != null);

  List<Role> roles = [];
  Util util = new Util();

  Future<List<Role>> getAndSetRoles() async {
    final url = 'http://192.168.137.1:8080/v1/role';
    try {
      String token = await util.getUserToken();
      String expiry = await util.getExpiryTime();
      final response = await httpClient.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
        'expiry': expiry
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        if (extractedData == null) {
          return null;
        }
        roles = extractedData.map<Role>((json) => Role.fromJson(json)).toList();
        print(roles);
      }
    } catch (e) {
      throw e;
    }
    return roles;
  }

  Future<Role> postRole(Role role) async {
    Role _role;
    final url = 'http://192.168.137.1:8080/v1/role';
    Util util = new Util();
    String token = await util.getUserToken();
    try {
      final response = await httpClient.post(
        url,
        body: json.encode(
          {
            'name': role.name,
          },
        ),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      print("POSTING ROLE.........");
      print(response.statusCode);

      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        _role = Role.fromJson(extractedData);
      } else {
        throw HttpException('Error Occurred');
      }
    } catch (e) {
      throw e;
    }
    return _role;
  }

  Future<Role> getRole(String clubId) async {
    Role role;
    final url = 'http://192.168.137.1:8080/v1/role';
    try {
      final response = await httpClient.get(
        url,
      );
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else if (response.statusCode == 404) {
        throw HttpException('Result Not Found');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        role = Role.fromJson(extractedData);
        print(role);
      }
    } catch (e) {
      throw e;
    }
    return role;
  }

  Future<Role> putRole(Role role) async {
    Role cl;
    final url = 'http://192.168.137.1:8080/v1/role/${role.id}';
    try {
      final response = await httpClient.put(
        url,
        body: json.encode({
          'id': role.id,
          'name': role.name,
        }),
      );
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        cl = Role.fromJson(extractedData);
      }
    } catch (e) {
      throw e;
    }
    return cl;
  }

  Future<void> deleteRole(String id) async {
    final url = 'http://192.168.137.1:8080/v1/role/$id';
    Util util = new Util();
    String token = await util.getUserToken();
    try {
      final response = await httpClient.delete(
        url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      print(response.statusCode);
      print(response.statusCode);
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else if (response.statusCode == 404) {
        throw HttpException('Fixture Not Found');
      } else {
        return;
      }
    } catch (e) {
      throw e;
    }
  }
}
