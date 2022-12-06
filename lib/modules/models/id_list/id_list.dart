import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'id_list.g.dart';

@JsonSerializable()
class IdList {
  final List eaIdList;

  IdList({
    required this.eaIdList,
  });

  factory IdList.fromJson(Map<String, dynamic> json) =>
      _$IdListFromJson(json);
}
