import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:soccer_app/shared/constants.dart';

import '../models/http_exception.dart';
import '../models/user.dart';
import '../util/util.dart';

class RoleDataProvider {
  final http.Client httpClient;


  List<Role> roles = [];
  RoleDataProvider({
    required this.httpClient,
  });
  Util util = new Util();

  Future<List<Role>> getAndSetRoles() async {
    final url = '$baseUrl/role';
    try {
      String token = await util.getUserToken();
      String expiry = await util.getExpiryTime();
      final response = await httpClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
        'expiry': expiry
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        if (extractedData == null) {
          return [];
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
    final url = '$baseUrl/role';
    Util util = new Util();
    String token = await util.getUserToken();
    try {
      final response = await httpClient.post(
        Uri.parse(url),
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
        _role = Role.fromMap(extractedData);
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
    final url = '$baseUrl/role';
    try {
      final response = await httpClient.get(
        Uri.parse(url),
      );
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else if (response.statusCode == 404) {
        throw HttpException('Result Not Found');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        role = Role.fromMap(extractedData);
        print(role);
      }
    } catch (e) {
      throw e;
    }
    return role;
  }

  Future<Role> putRole(Role role) async {
    Role cl;
    final url = '$baseUrl/role/${role.id}';
    try {
      final response = await httpClient.put(
        Uri.parse(url),
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
        cl = Role.fromMap(extractedData);
      }
    } catch (e) {
      throw e;
    }
    return cl;
  }

  Future<void> deleteRole(String id) async {
    final url = '$baseUrl/role/$id';
    Util util = new Util();
    String token = await util.getUserToken();
    try {
      final response = await httpClient.delete(
        Uri.parse(url),
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
