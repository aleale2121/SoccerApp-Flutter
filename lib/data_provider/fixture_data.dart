import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:soccer_app/shared/constants.dart';

import '../models/http_exception.dart';
import '../models/fixture.dart';
import 'package:http/http.dart' as http;
import '../util/util.dart';
import 'package:meta/meta.dart';

class FixtureDataProvider {
  final http.Client httpClient;

  FixtureDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Fixture>> getAndSetFixtures() async {
    List<Fixture> fixtures = [];
    final url = '$baseUrl/fixture';
    try {
      final response = await httpClient.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        if (extractedData == null) {
          return null;
        }
        fixtures = extractedData
            .map<Fixture>((json) => Fixture.fromJson(json))
            .toList();
        print(fixtures);
      } else {
        throw HttpException("Error Occurred");
      }
    } catch (e) {
      throw e;
    }
    return fixtures;
  }

  Future<Fixture> getFixture(String fixtureId) async {
    Fixture fixture;
    final url = '$baseUrl/fixture';
    try {
      final response = await httpClient.get(
        Uri.parse(url),
      );
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else if (response.statusCode == 404) {
        throw HttpException('Fixture Not Found');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        fixture = Fixture.fromJson(extractedData);
      }
    } catch (e) {
      throw e;
    }
    return fixture;
  }

  Future<Fixture> postFixture(Fixture fixture) async {
    Fixture fxtr;
    final url = '$baseUrl/fixture';
    Util util = new Util();
    String token = await util.getUserToken();
    try {
      List<Map> clubs = fixture.clubs != null
          ? fixture.clubs.map((club) => club.toJson()).toList()
          : null;
      final response = await httpClient.post(
        Uri.parse(url),
        body: json.encode(
          {
            'id': fixture.id,
            'starting_date':
                fixture.startingDate.millisecondsSinceEpoch.toString(),
            'clubs': clubs,
            'stadium_latitude': fixture.stadiumLatitude,
            'stadium_longitude': fixture.stadiumLongitude,
            'referee_name': fixture.stadiumName,
          },
        ),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        fxtr = Fixture.fromJson(extractedData);
      } else {
        throw HttpException('Error Occurred');
      }
    } catch (e) {
      throw e;
    }
    return fxtr;
  }

  Future<Fixture> putFixture(Fixture fixture) async {
    Fixture fxtr;
    final url = '$baseUrl/fixture/${fixture.id}';
    String token = await util.getUserToken();
    try {
      List<Map> clubs = fixture.clubs != null
          ? fixture.clubs.map((club) => club.toJson()).toList()
          : null;
      final response = await httpClient.put(
        Uri.parse(url),
        body: json.encode(
          {
            'id': fixture.id,
            'starting_date':
                fixture.startingDate.millisecondsSinceEpoch.toString(),
            'clubs': clubs,
            'stadium_latitude': fixture.stadiumLatitude,
            'stadium_longitude': fixture.stadiumLongitude,
            'referee_name': fixture.stadiumName,
          },
        ),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        fxtr = Fixture.fromJson(extractedData);
      }
    } catch (e) {
      throw e;
    }
    return fxtr;
  }

  Future<void> deleteFixture(String id) async {
    final url = '$baseUrl/fixture/$id';
    Util util = new Util();
    String token = await util.getUserToken();
    try {
      final response = await httpClient.delete(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
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
