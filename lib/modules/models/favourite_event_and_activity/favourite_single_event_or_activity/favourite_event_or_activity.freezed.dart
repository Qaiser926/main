// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favourite_event_or_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavouriteEventOrActivity _$FavouriteEventOrActivityFromJson(
    Map<String, dynamic> json) {
  return _FavouriteEventOrActivity.fromJson(json);
}

/// @nodoc
mixin _$FavouriteEventOrActivity {
  String? get photo => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String? get startTimeUtc => throw _privateConstructorUsedError;
  OpeningTimeCode? get openingTimeCode => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  bool? get visible => throw _privateConstructorUsedError;
  set visible(bool? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavouriteEventOrActivityCopyWith<FavouriteEventOrActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavouriteEventOrActivityCopyWith<$Res> {
  factory $FavouriteEventOrActivityCopyWith(FavouriteEventOrActivity value,
          $Res Function(FavouriteEventOrActivity) then) =
      _$FavouriteEventOrActivityCopyWithImpl<$Res, FavouriteEventOrActivity>;
  @useResult
  $Res call(
      {String? photo,
      String title,
      String id,
      String? startTimeUtc,
      OpeningTimeCode? openingTimeCode,
      String categoryId,
      bool? visible});
}

/// @nodoc
class _$FavouriteEventOrActivityCopyWithImpl<$Res,
        $Val extends FavouriteEventOrActivity>
    implements $FavouriteEventOrActivityCopyWith<$Res> {
  _$FavouriteEventOrActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photo = freezed,
    Object? title = null,
    Object? id = null,
    Object? startTimeUtc = freezed,
    Object? openingTimeCode = freezed,
    Object? categoryId = null,
    Object? visible = freezed,
  }) {
    return _then(_value.copyWith(
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTimeUtc: freezed == startTimeUtc
          ? _value.startTimeUtc
          : startTimeUtc // ignore: cast_nullable_to_non_nullable
              as String?,
      openingTimeCode: freezed == openingTimeCode
          ? _value.openingTimeCode
          : openingTimeCode // ignore: cast_nullable_to_non_nullable
              as OpeningTimeCode?,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      visible: freezed == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavouriteEventOrActivityCopyWith<$Res>
    implements $FavouriteEventOrActivityCopyWith<$Res> {
  factory _$$_FavouriteEventOrActivityCopyWith(
          _$_FavouriteEventOrActivity value,
          $Res Function(_$_FavouriteEventOrActivity) then) =
      __$$_FavouriteEventOrActivityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? photo,
      String title,
      String id,
      String? startTimeUtc,
      OpeningTimeCode? openingTimeCode,
      String categoryId,
      bool? visible});
}

/// @nodoc
class __$$_FavouriteEventOrActivityCopyWithImpl<$Res>
    extends _$FavouriteEventOrActivityCopyWithImpl<$Res,
        _$_FavouriteEventOrActivity>
    implements _$$_FavouriteEventOrActivityCopyWith<$Res> {
  __$$_FavouriteEventOrActivityCopyWithImpl(_$_FavouriteEventOrActivity _value,
      $Res Function(_$_FavouriteEventOrActivity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photo = freezed,
    Object? title = null,
    Object? id = null,
    Object? startTimeUtc = freezed,
    Object? openingTimeCode = freezed,
    Object? categoryId = null,
    Object? visible = freezed,
  }) {
    return _then(_$_FavouriteEventOrActivity(
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTimeUtc: freezed == startTimeUtc
          ? _value.startTimeUtc
          : startTimeUtc // ignore: cast_nullable_to_non_nullable
              as String?,
      openingTimeCode: freezed == openingTimeCode
          ? _value.openingTimeCode
          : openingTimeCode // ignore: cast_nullable_to_non_nullable
              as OpeningTimeCode?,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      visible: freezed == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavouriteEventOrActivity
    with DiagnosticableTreeMixin
    implements _FavouriteEventOrActivity {
  _$_FavouriteEventOrActivity(
      {this.photo,
      required this.title,
      required this.id,
      this.startTimeUtc,
      this.openingTimeCode,
      required this.categoryId,
      this.visible = true});

  factory _$_FavouriteEventOrActivity.fromJson(Map<String, dynamic> json) =>
      _$$_FavouriteEventOrActivityFromJson(json);

  @override
  final String? photo;
  @override
  final String title;
  @override
  final String id;
  @override
  final String? startTimeUtc;
  @override
  final OpeningTimeCode? openingTimeCode;
  @override
  final String categoryId;
  @override
  @JsonKey()
  bool? visible;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FavouriteEventOrActivity(photo: $photo, title: $title, id: $id, startTimeUtc: $startTimeUtc, openingTimeCode: $openingTimeCode, categoryId: $categoryId, visible: $visible)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FavouriteEventOrActivity'))
      ..add(DiagnosticsProperty('photo', photo))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('startTimeUtc', startTimeUtc))
      ..add(DiagnosticsProperty('openingTimeCode', openingTimeCode))
      ..add(DiagnosticsProperty('categoryId', categoryId))
      ..add(DiagnosticsProperty('visible', visible));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavouriteEventOrActivityCopyWith<_$_FavouriteEventOrActivity>
      get copyWith => __$$_FavouriteEventOrActivityCopyWithImpl<
          _$_FavouriteEventOrActivity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavouriteEventOrActivityToJson(
      this,
    );
  }
}

abstract class _FavouriteEventOrActivity implements FavouriteEventOrActivity {
  factory _FavouriteEventOrActivity(
      {final String? photo,
      required final String title,
      required final String id,
      final String? startTimeUtc,
      final OpeningTimeCode? openingTimeCode,
      required final String categoryId,
      bool? visible}) = _$_FavouriteEventOrActivity;

  factory _FavouriteEventOrActivity.fromJson(Map<String, dynamic> json) =
      _$_FavouriteEventOrActivity.fromJson;

  @override
  String? get photo;
  @override
  String get title;
  @override
  String get id;
  @override
  String? get startTimeUtc;
  @override
  OpeningTimeCode? get openingTimeCode;
  @override
  String get categoryId;
  @override
  bool? get visible;
  set visible(bool? value);
  @override
  @JsonKey(ignore: true)
  _$$_FavouriteEventOrActivityCopyWith<_$_FavouriteEventOrActivity>
      get copyWith => throw _privateConstructorUsedError;
}
