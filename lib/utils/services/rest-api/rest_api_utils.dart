import 'dart:convert';
import 'dart:typed_data';

Uint8List transformClassToBody(dynamic obj) {
  dynamic json = obj.toJson();
  final String jsonAsString = JsonEncoder().convert(json);
  dynamic result = utf8.encode(jsonAsString);
  return result;
}

Uint8List transformMapToBody(Map obj) {
  final String jsonAsString = JsonEncoder().convert(obj);
  Uint8List result = Uint8List.fromList(jsonAsString.codeUnits);
  return result;
}
