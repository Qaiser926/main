import 'dart:typed_data';

class CustomRestOptions {
  final String? apiName;
  final String path;
  final Uint8List? body;
  final Map<String, String>? queryParameters;
  final Map<String, String>? headers;

  const CustomRestOptions({
    required this.path,
    this.apiName,
    this.body,
    this.queryParameters,
    this.headers,
  });

  Map<String, dynamic> serializeAsMap() =>
      <String, dynamic>{
        if (apiName != null) 'apiName': apiName,
        'path': path,
        if (body != null) 'body': body,
        if (queryParameters != null) 'queryParameters': queryParameters,
        if (headers != null) 'headers': headers
      };
}
