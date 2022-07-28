// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:themovedb/domain/entity/popular_movie_response.dart';

enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();

  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '9e95ba9289cd9eed925014612392ecec';
  static String imageUrl(String path) => _imageUrl + path;

  Future<String> auth(
      {required String username, required String password}) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validToken);

    return sessionId;
  }

  Uri _makeUri(String path, Map<String, dynamic>? parametrs) {
    final uri = Uri.parse('$_host$path');

    if (parametrs != null) {
      return uri.replace(queryParameters: parametrs);
    }

    return uri;
  }

  Future<T> _get<T>(String path, T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]) async {
    final url = _makeUri(
      path,
      parameters,
    );
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final json = (await response.jsonDecode());
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<T> _post<T>(
    String path,
    Map<String, dynamic>? bodyParametrs,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParametrs,
  ]) async {
    try {
      final url = _makeUri(
        path,
        urlParametrs,
      );

      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParametrs));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _makeToken() async {
    // ignore: prefer_function_declarations_over_variables
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final result = _get(
      '/authentication/token/new',
      parser,
      <String, String>{'api_key': _apiKey},
    );
    return result;
  }

  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    // ignore: prefer_function_declarations_over_variables
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      '/movie/popular',
      parser,
      <String, String>{
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    // ignore: prefer_function_declarations_over_variables
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final result = _post(
      '/authentication/token/validate_with_login',
      parameters,
      parser,
      <String, String>{'api_key': _apiKey},
    );
    return result;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    // ignore: prefer_function_declarations_over_variables
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    };
    final parameters = {'request_token': requestToken};
    final result = _post(
      '/authentication/session/new',
      parameters,
      parser,
      <String, String>{'api_key': _apiKey},
    );
    return result;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(
          ApiClientExceptionType.Auth,
        );
      } else {
        throw ApiClientException(
          ApiClientExceptionType.Other,
        );
      }
    }
  }
}

extension HttpClientResponseJsonDecoder on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((value) {
      final resualt = value.join();
      return resualt;
    }).then<dynamic>((v) => json.decode(v));
  }
}


// import 'dart:convert';
// import 'dart:io';

// class ApiClient {
//   final _client = HttpClient();
//   static const _host = 'https://api.themoviedb.org/3';
//   static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
//   static const _apiKey = '9e95ba9289cd9eed925014612392ecec';

//   Future<String> auth({
//     required String username,
//     required String password,
//   }) async {
//     final token = await _makeToken();
//     final validToken = await _validateUser(
//         username: username, password: password, requestToken: token);
//     final sessionId = await _makeSession(requestToken: validToken);
//     return sessionId;
//   }

//   Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
//     final uri = Uri.parse('$_host$path');
//     if (parameters != null) {
//       return uri.replace(queryParameters: parameters);
//     } else {
//       return uri;
//     }
//   }

//   Future<String> _makeToken() async {
//     final url = _makeUri(
//       '/authentication/token/new',
//       <String, dynamic>{
//         'api_key': _apiKey,
//       },
//     );
//     final request = await _client.getUrl(url);
//     final response = await request.close();
//     final json = (await response.jsonDecode()) as Map<String, dynamic>;
//     final token = json['request_token'] as String;
//     return token;
//   }

//   Future<String> _validateUser({
//     required String username,
//     required String password,
//     required String requestToken,
//   }) async {
//     final url = _makeUri(
//       'authentication/token/validate_with_login',
//       <String, dynamic>{
//         'api_key': _apiKey,
//       },
//     );
//     final parameters = <String, dynamic>{
//       'username': username,
//       'password': password,
//       'request_token': requestToken,
//     };
//     final request = await _client.postUrl(url);
//     request.headers.contentType = ContentType.json;
//     request.write(jsonEncode(parameters));
//     final response = await request.close();
//     final json = (await response.jsonDecode()) as Map<String, dynamic>;
//     final token = json['request_token'] as String;
//     return token;
//   }

//   Future<String> _makeSession({
//     required String requestToken,
//   }) async {
//     final url = _makeUri(
//       'authentication/session/new',
//       <String, dynamic>{
//         'api_key': _apiKey,
//       },
//     );
//     final parameters = <String, dynamic>{
//       'request_token': requestToken,
//     };
//     final request = await _client.postUrl(url);
//     request.headers.contentType = ContentType.json;
//     request.write(jsonEncode(parameters));
//     final response = await request.close();
//     final json = (await response.jsonDecode()) as Map<String, dynamic>;

//     final sessionId = json['session_id'] as String;
//     return sessionId;
//   }
// }

// extension HttpClientResponseJsonDecode on HttpClientResponse {
//   Future<dynamic> jsonDecode() async {
//     return transform(utf8.decoder)
//         .toList()
//         .then((value) => value.join())
//         .then<dynamic>((v) => json.decode(v));
//   }
// }
