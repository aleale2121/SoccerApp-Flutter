import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:soccer_app/util/util.dart';
import '../models/http_exception.dart';
import '../models/result.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class ResultDataProvider {
  final http.Client httpClient;

  ResultDataProvider({@required this.httpClient}) : assert(httpClient != null);

  List<Result> results = [];
  Future<List<Result>> getAndSetResults() async {
    print('------------fetching result------');

    final url = 'http://192.168.137.1:8080/v1/result';
    try {
      final response = await httpClient.get(
        url,
      );

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        if (extractedData == null) {
          return null;
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
    final url = 'http://192.168.137.1:8080/v1/result';
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
        result = Result.fromJson(extractedData);
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
    final url = 'http://192.168.137.1:8080/v1/result';
    try {
      final response = await httpClient.post(
        url,
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
        res = Result.fromJson(extractedData);
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
    final url = 'http://192.168.137.1:8080/v1/result/${result.id}';
    try {
      final response = await httpClient.put(
        url,
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
        res = Result.fromJson(extractedData);
      }
    } catch (e) {
      throw e;
    }
    return res;
  }

  Future<void> deleteResult(String id) async {
    final url = 'http://192.168.137.1:8080/v1/result/$id';
    Util util = new Util();
    String token = await util.getUserToken();
    try {
      final response = await httpClient.delete(
        url,
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
