import 'dart:convert';
import 'dart:typed_data';

Uint8List transformClassToBody(dynamic obj) {
  dynamic json = obj.toJson();
  final String jsonAsString = JsonEncoder().convert(json);
  Uint8List result = Uint8List.fromList(jsonAsString.codeUnits);
  return result;
}

Uint8List transformCMaptoBody(Map obj) {
  final String jsonAsString = JsonEncoder().convert(obj);
  Uint8List result = Uint8List.fromList(jsonAsString.codeUnits);
  return result;
}
