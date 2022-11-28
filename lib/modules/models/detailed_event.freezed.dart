// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'detailed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DetailedEvent {
  Uuid get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get locationTitle => throw _privateConstructorUsedError;
  Uuid get locationId => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

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
      {Uuid id,
      String title,
      String locationTitle,
      Uuid locationId,
      double price});
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
    Object? locationTitle = null,
    Object? locationId = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Uuid,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      locationTitle: null == locationTitle
          ? _value.locationTitle
          : locationTitle // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: null == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as Uuid,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
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
      {Uuid id,
      String title,
      String locationTitle,
      Uuid locationId,
      double price});
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
    Object? locationTitle = null,
    Object? locationId = null,
    Object? price = null,
  }) {
    return _then(_$_DetailedEvent(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Uuid,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      locationTitle: null == locationTitle
          ? _value.locationTitle
          : locationTitle // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: null == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as Uuid,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_DetailedEvent implements _DetailedEvent {
  const _$_DetailedEvent(
      {required this.id,
      required this.title,
      required this.locationTitle,
      required this.locationId,
      required this.price});

  @override
  final Uuid id;
  @override
  final String title;
  @override
  final String locationTitle;
  @override
  final Uuid locationId;
  @override
  final double price;

  @override
  String toString() {
    return 'DetailedEvent(id: $id, title: $title, locationTitle: $locationTitle, locationId: $locationId, price: $price)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetailedEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.locationTitle, locationTitle) ||
                other.locationTitle == locationTitle) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, locationTitle, locationId, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DetailedEventCopyWith<_$_DetailedEvent> get copyWith =>
      __$$_DetailedEventCopyWithImpl<_$_DetailedEvent>(this, _$identity);
}

abstract class _DetailedEvent implements DetailedEvent {
  const factory _DetailedEvent(
      {required final Uuid id,
      required final String title,
      required final String locationTitle,
      required final Uuid locationId,
      required final double price}) = _$_DetailedEvent;

  @override
  Uuid get id;
  @override
  String get title;
  @override
  String get locationTitle;
  @override
  Uuid get locationId;
  @override
  double get price;
  @override
  @JsonKey(ignore: true)
  _$$_DetailedEventCopyWith<_$_DetailedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
