import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:soccer_app/shared/constants.dart';
import 'package:soccer_app/util/util.dart';

import '../models/http_exception.dart';
import '../models/result.dart';

class ResultDataProvider {
  final http.Client httpClient;


  List<Result> results = [];
  ResultDataProvider({
    required this.httpClient,
  });
  Future<List<Result>> getAndSetResults() async {
    print('------------fetching result------');

    final url = '$baseUrl/result';
    try {
      final response = await httpClient.get(
        Uri.parse(url)
      );

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        if (extractedData == null) {
          return [];
        }
        results =
            extractedData.map<Result>((json) => Result.fromJson(json)).toList();
      } else {
        print('------------error------');
        throw HttpException("Error Occurred");
      }
    } catch (e) {
      print('------------error------');
      print(e.toString());
      throw e;
    }
    return results;
  }

  Future<Result> getResult(String resultId) async {
    Result result;
    final url = '$baseUrl/result';
    try {
      final response = await httpClient.get(
       Uri.parse(url)
      );
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else if (response.statusCode == 404) {
        throw HttpException('Result Not Found');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        result = Result.fromMap(extractedData);
      }
    } catch (e) {
      throw e;
    }
    return result;
  }

  Future<Result> postResult(Result result) async {
    Result res;
    Util util = new Util();
    String token = await util.getUserToken();
    final url = '$baseUrl/result';
    try {
      final response = await httpClient.post(
        Uri.parse(url),
        body: json.encode({
          'fixture_id': result.fixtureId,
          'first_club_score': result.firstClubScore,
          'second_club_score': result.secondClubScore,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        final extractedData =
        json.decode(response.body) as Map<String, dynamic>;
        res = Result.fromMap(extractedData);
      } else {
        print('-----status code');
        print(response.statusCode);
        throw HttpException('Error Occurred');
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
    return res;
  }

  Future<Result> putResult(Result result) async {
    Result res;
    Util util = new Util();
    String token = await util.getUserToken();
    final url = '$baseUrl/result/${result.id}';
    try {
      final response = await httpClient.put(
        Uri.parse(url),
        body: json.encode({
          'id': result.id,
          'fixture_id': result.fixtureId,
          'first_club_score': result.firstClubScore,
          'second_club_score': result.secondClubScore,
          'scorers': [],
        }),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        res = Result.fromMap(extractedData);
      }
    } catch (e) {
      throw e;
    }
    return res;
  }

  Future<void> deleteResult(String id) async {
    final url = '$baseUrl/result/$id';
    Util util = new Util();
    String token = await util.getUserToken();
    try {
      final response = await httpClient.delete(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else if (response.statusCode == 404) {
        throw HttpException('Result Not Found');
      } else {
        return;
      }
    } catch (e) {
      throw e;
    }
  }
}
