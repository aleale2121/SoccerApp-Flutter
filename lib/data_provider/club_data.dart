import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:soccer_app/models/club.dart';
import 'package:soccer_app/shared/constants.dart';

import '../models/http_exception.dart';

class ClubDataProvider {
  final http.Client httpClient;

  List<Club> clubs = [];
  ClubDataProvider({
    required this.httpClient,
  });
  Future<List<Club>> getAndSetClubs() async {
    final url = '$baseUrl/club';
    try {
      final response = await httpClient.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        if (extractedData == null) {
          return [];
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
        club = Club.fromMap(extractedData);
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
        cl = Club.fromMap(extractedData);
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
        cl = Club.fromMap(extractedData);
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
