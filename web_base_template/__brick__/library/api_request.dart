import 'dart:convert';
import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'interceptors.dart';

class BaseDio {
  static const qa = 'your_qa_url';
  static const prepilot = "your_prepilot_url";
  static const dev = "your_dev_url";

  String baseUrl =
      const String.fromEnvironment('url', defaultValue: 'your_prepilot_url');
  Dio? _dio;

  Map<String, String> getHeader() {
    Map<String, String> headers = {};
    headers = {
      'Authorization': 'Bearer',
      'Content-Type': 'application/json',
      // 'Accept-Encoding': '',
    };

    return headers;
  }

  String getBaseUrl() {
    if (BaseDio.instance.baseUrl == 'dev') {
      return dev;
    } else if (BaseDio.instance.baseUrl == 'qa') {
      return qa;
    } else {
      return prepilot;
    }
  }

  Dio? getDio() {
    Map<String, String> requestHeader = getHeader();
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        headers: requestHeader,
        baseUrl: getBaseUrl(),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        followRedirects: false,
        // requestEncoder: gzipEncoder,
        validateStatus: (status) => true,
      ));
    } else {
      _dio!.options.headers = requestHeader;
    }
    if (baseUrl == 'dev' || baseUrl == 'qa') {
      _dio!.interceptors.add(CustomLogInterceptor());
    }

    return _dio;
  }

  List<int> gzipEncoder(String request, RequestOptions options) {
    options.headers.putIfAbsent("Content-Encoding", () => "gzip");
    return GZipEncoder().encode(utf8.encode(request))!;
  }

  static final BaseDio instance = BaseDio();
}

class ApiRequest {
  final String url;
  final Map<String, dynamic> query;
  final dynamic data;

  ApiRequest({required this.url, required this.query, required this.data});

  Future<void> get({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    BaseDio.instance
        .getDio()!
        .get(url, queryParameters: query)
        .then((res) async {
      if (res.statusCode == 200 || res.statusCode == 201) {
        if (onSuccess != null) {
          onSuccess(res.data);
        }
      } else if (res.statusCode == 401) {
        await refreshTheToken(gotSuccessWhenRefreshToken: () async {
          return await get(
            onSuccess: (data) {
              if (onSuccess == null) {
                return handleUnAutherizedUser();
              }
              onSuccess(data);
            },
            onError: (error) {
              return handleUnAutherizedUser();
            },
          );
        }, gotErrorWhenRefreshToken: () {
          handleUnAutherizedUser();
        });
      } else {
        if (onError != null) {
          onError({"message": res.statusMessage, "statusCode": res.statusCode});
        }
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future<void> post({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    BaseDio.instance
        .getDio()!
        .post(url, queryParameters: query, data: data)
        .then((res) async {
      if (res.statusCode == 200 || res.statusCode == 201) {
        if (onSuccess != null) {
          onSuccess(res.data);
        }
      } else if (res.statusCode == 401) {
        await refreshTheToken(gotSuccessWhenRefreshToken: () async {
          return await post(
            onSuccess: (data) {
              if (onSuccess == null) {
                return handleUnAutherizedUser();
              }
              onSuccess(data);
            },
            onError: (error) {
              return handleUnAutherizedUser();
            },
          );
        }, gotErrorWhenRefreshToken: () {
          handleUnAutherizedUser();
        });
      } else {
        if (onError != null) {
          onError({"message": res.statusMessage, "statusCode": res.statusCode});
        }
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future<void> patch({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    BaseDio.instance
        .getDio()!
        .patch(url, queryParameters: query, data: data)
        .then((res) async {
      if (res.statusCode == 200 || res.statusCode == 201) {
        if (onSuccess != null) {
          onSuccess(res.data);
        }
      } else if (res.statusCode == 401) {
        await refreshTheToken(gotSuccessWhenRefreshToken: () async {
          return await patch(
            onSuccess: (data) {
              if (onSuccess == null) {
                return handleUnAutherizedUser();
              }
              onSuccess(data);
            },
            onError: (error) {
              return handleUnAutherizedUser();
            },
          );
        }, gotErrorWhenRefreshToken: () {
          handleUnAutherizedUser();
        });
      } else {
        if (onError != null) {
          onError({"message": res.statusMessage, "statusCode": res.statusCode});
        }
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future<void> delete({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    BaseDio.instance
        .getDio()!
        .delete(url, queryParameters: query, data: data)
        .then((res) async {
      if (res.statusCode == 200 || res.statusCode == 201) {
        if (onSuccess != null) {
          onSuccess(res.data);
        }
      } else if (res.statusCode == 401) {
        await refreshTheToken(gotSuccessWhenRefreshToken: () async {
          return await delete(
            onSuccess: (data) {
              if (onSuccess == null) {
                return handleUnAutherizedUser();
              }
              onSuccess(data);
            },
            onError: (error) {
              return handleUnAutherizedUser();
            },
          );
        }, gotErrorWhenRefreshToken: () {
          handleUnAutherizedUser();
        });
      } else {
        if (onError != null) {
          onError({"message": res.statusMessage, "statusCode": res.statusCode});
        }
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  void getApiWithoutToken(
    header, {
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    Dio dio = Dio(BaseOptions(
      headers: header,
      baseUrl: BaseDio.instance.getBaseUrl(),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      followRedirects: false,
      validateStatus: (status) => true,
    ));

    dio
        .get(
      url,
      queryParameters: query,
    )
        .then((res) {
      if (res.statusCode == 200 || res.statusCode == 201) {
        if (onSuccess != null) {
          onSuccess(res.data);
        }
      } else if (res.statusCode == 401) {
        if (onError != null) onError(res.statusMessage);
        handleUnAutherizedUser();
      } else {
        if (onError != null) onError(res.statusMessage);
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
    // dio.interceptors.add(dioLoggerInterceptor);
  }

  postApiWithoutToken(
    header, {
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    Dio dio = Dio(BaseOptions(
      headers: header,
      baseUrl: BaseDio.instance.getBaseUrl(),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      followRedirects: false,
      validateStatus: (status) => true,
    ));

    dio.post(url, queryParameters: query, data: data).then((res) {
      if (res.statusCode == 200 || res.statusCode == 201) {
        if (onSuccess != null) {
          onSuccess(res.data);
        }
      } else if (res.statusCode == 401) {
        if (onError != null) onError(res.statusMessage);
        handleUnAutherizedUser();
      } else {
        if (onError != null) onError(res.statusMessage);
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
    // dio.interceptors.add(dioLoggerInterceptor);
  }

  void getAppLabelWithOutToken({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    Dio localDio = Dio();
    localDio.get(url, queryParameters: query).then((res) {
      if (res.statusCode == 200 || res.statusCode == 201) {
        if (onSuccess != null) {
          onSuccess(res.data);
        }
      } else if (res.statusCode == 401) {
        if (onError != null) onError(res.statusMessage);
        handleUnAutherizedUser();
      } else {
        if (onError != null) onError(res.statusMessage);
      }
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  refreshTheToken(
      {VoidCallback? gotSuccessWhenRefreshToken,
      VoidCallback? gotErrorWhenRefreshToken}) async {
    //  TODO: here i have to write code when session get expire.
  }
}

handleUnAutherizedUser() async {
  //  TODO: here i have to write code when token refresh get error;
}
