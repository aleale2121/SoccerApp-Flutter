import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:soccer_app/models/club.dart';
import 'package:soccer_app/shared/constants.dart';

import '../models/http_exception.dart';
import 'package:http/http.dart' as http;

class ClubDataProvider {
  final http.Client httpClient;

  ClubDataProvider({@required this.httpClient}) : assert(httpClient != null);

  List<Club> clubs = [];
  Future<List<Club>> getAndSetClubs() async {
    final url = '$baseUrl/club';
    try {
      final response = await httpClient.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        if (extractedData == null) {
          return null;
        }
        clubs = extractedData.map<Club>((json) => Club.fromJson(json)).toList();
      } else {
        throw HttpException("Error Occurred");
      }
    } catch (e) {
      throw e;
    }
    return clubs;
  }

  Future<Club> getClub(String clubId) async {
    Club club;
    final url = '$baseUrl/club';
    try {
      final response = await httpClient.get(Uri.parse(url));
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else if (response.statusCode == 404) {
        throw HttpException('Result Not Found');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        club = Club.fromJson(extractedData);
      }
    } catch (e) {
      throw e;
    }
    return club;
  }

  Future<Club> postClub(Club club) async {
    Club cl;
    final url = '$baseUrl/club';
    try {
      final response = await httpClient.post(
        Uri.parse(url),
        body: json.encode({
          'id': club.id,
          'club_name': club.name,
        }),
      );
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        cl = Club.fromJson(extractedData);
      }
    } catch (e) {
      throw e;
    }
    return cl;
  }

  Future<Club> putClub(Club club) async {
    Club cl;
    final url = '$baseUrl/club/${club.id}';
    try {
      final response = await httpClient.put(
        Uri.parse(url),
        body: json.encode({
          'id': club.id,
          'club_name': club.name,
        }),
      );
      if (response.statusCode == 500) {
        throw HttpException('Error Occurred');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        cl = Club.fromJson(extractedData);
      }
    } catch (e) {
      throw e;
    }
    return cl;
  }

  Future<void> deleteClub(String id) async {
    final url = '$baseUrl/club/$id';
    try {
      final response = await httpClient.delete(Uri.parse(url));
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
