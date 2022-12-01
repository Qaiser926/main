// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detailed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DetailedEvent _$DetailedEventFromJson(Map<String, dynamic> json) {
  return _DetailedEvent.fromJson(json);
}

/// @nodoc
mixin _$DetailedEvent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get locationTitle => throw _privateConstructorUsedError;
  String get locationId => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DetailedEventCopyWith<DetailedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailedEventCopyWith<$Res> {
  factory $DetailedEventCopyWith(
          DetailedEvent value, $Res Function(DetailedEvent) then) =
      _$DetailedEventCopyWithImpl<$Res, DetailedEvent>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String locationTitle,
      String locationId,
      double price,
      double latitude,
      double longitude});
}

/// @nodoc
class _$DetailedEventCopyWithImpl<$Res, $Val extends DetailedEvent>
    implements $DetailedEventCopyWith<$Res> {
  _$DetailedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? locationTitle = null,
    Object? locationId = null,
    Object? price = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      locationTitle: null == locationTitle
          ? _value.locationTitle
          : locationTitle // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: null == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DetailedEventCopyWith<$Res>
    implements $DetailedEventCopyWith<$Res> {
  factory _$$_DetailedEventCopyWith(
          _$_DetailedEvent value, $Res Function(_$_DetailedEvent) then) =
      __$$_DetailedEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String locationTitle,
      String locationId,
      double price,
      double latitude,
      double longitude});
}

/// @nodoc
class __$$_DetailedEventCopyWithImpl<$Res>
    extends _$DetailedEventCopyWithImpl<$Res, _$_DetailedEvent>
    implements _$$_DetailedEventCopyWith<$Res> {
  __$$_DetailedEventCopyWithImpl(
      _$_DetailedEvent _value, $Res Function(_$_DetailedEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? locationTitle = null,
    Object? locationId = null,
    Object? price = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$_DetailedEvent(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      locationTitle: null == locationTitle
          ? _value.locationTitle
          : locationTitle // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: null == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DetailedEvent with DiagnosticableTreeMixin implements _DetailedEvent {
  const _$_DetailedEvent(
      {required this.id,
      required this.title,
      required this.description,
      required this.locationTitle,
      required this.locationId,
      required this.price,
      required this.latitude,
      required this.longitude});

  factory _$_DetailedEvent.fromJson(Map<String, dynamic> json) =>
      _$$_DetailedEventFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String locationTitle;
  @override
  final String locationId;
  @override
  final double price;
  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DetailedEvent(id: $id, title: $title, description: $description, locationTitle: $locationTitle, locationId: $locationId, price: $price, latitude: $latitude, longitude: $longitude)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DetailedEvent'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('locationTitle', locationTitle))
      ..add(DiagnosticsProperty('locationId', locationId))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetailedEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.locationTitle, locationTitle) ||
                other.locationTitle == locationTitle) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      locationTitle, locationId, price, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DetailedEventCopyWith<_$_DetailedEvent> get copyWith =>
      __$$_DetailedEventCopyWithImpl<_$_DetailedEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DetailedEventToJson(
      this,
    );
  }
}

abstract class _DetailedEvent implements DetailedEvent {
  const factory _DetailedEvent(
      {required final String id,
      required final String title,
      required final String description,
      required final String locationTitle,
      required final String locationId,
      required final double price,
      required final double latitude,
      required final double longitude}) = _$_DetailedEvent;

  factory _DetailedEvent.fromJson(Map<String, dynamic> json) =
      _$_DetailedEvent.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get locationTitle;
  @override
  String get locationId;
  @override
  double get price;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$_DetailedEventCopyWith<_$_DetailedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
