import 'dart:convert';
import 'dart:typed_data';

Uint8List transformClassToBody(dynamic obj) {
  dynamic json = obj.toJson();
  final jsonAsString = JsonEncoder().convert(json);
  final bytes = utf8.encode(jsonAsString);
  final base64 = base64Encode(bytes);
  Uint8List result = Uint8List.fromList(jsonAsString.codeUnits);
  return result;
}
