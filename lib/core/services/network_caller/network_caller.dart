import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger _logger = Logger();

  final Map<String, String> Function() headers;

  NetworkCaller({required this.headers});

  Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      Response response = await get(uri, headers: headers());

      final decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _logResponse(response);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else {
        _logResponse(response, isError: true);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          body: decodedJson['message'],
        );
      }
    } catch (e) {
      _logger.e('''URL => $url
      message => ${e.toString()}''');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      Response response = await post(
        uri,
        body: jsonEncode(body),
        headers: headers(),
      );

      final decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _logResponse(response);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else {
        _logResponse(response, isError: true);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          body: decodedJson['message'],
        );
      }
    } catch (e) {
      _logger.e('''URL => $url
      message => ${e.toString()}''');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(String url) {
    _logger.i('Request URL: $url');
  }

  void _logResponse(Response response, {bool isError = false}) {
    if (isError) {
      _logger.e('''URL => ${response.request!.url}
      Status code => ${response.statusCode}
      Header => ${response.headers}
      Body => ${response.body}''');
    } else {
      _logger.d('''URL => ${response.request!.url}
      Status code => ${response.statusCode}
      Header => ${response.headers}
      Body => ${response.body}''');
    }
  }
}

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final String? errorMessage;
  final dynamic body;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.errorMessage,
    this.body,
  });
}
