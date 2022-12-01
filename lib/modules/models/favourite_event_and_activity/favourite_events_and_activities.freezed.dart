// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favourite_events_and_activities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavouriteEventsAndActivities _$FavouriteEventsAndActivitiesFromJson(
    Map<String, dynamic> json) {
  return _FavouriteEventsAndActivities.fromJson(json);
}

/// @nodoc
mixin _$FavouriteEventsAndActivities {
  List<FavouriteEventOrActivity> get futureEvents =>
      throw _privateConstructorUsedError;
  List<FavouriteEventOrActivity> get pastEvents =>
      throw _privateConstructorUsedError;
  List<FavouriteEventOrActivity> get openActivities =>
      throw _privateConstructorUsedError;
  List<FavouriteEventOrActivity> get closedActivities =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavouriteEventsAndActivitiesCopyWith<FavouriteEventsAndActivities>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavouriteEventsAndActivitiesCopyWith<$Res> {
  factory $FavouriteEventsAndActivitiesCopyWith(
          FavouriteEventsAndActivities value,
          $Res Function(FavouriteEventsAndActivities) then) =
      _$FavouriteEventsAndActivitiesCopyWithImpl<$Res,
          FavouriteEventsAndActivities>;
  @useResult
  $Res call(
      {List<FavouriteEventOrActivity> futureEvents,
      List<FavouriteEventOrActivity> pastEvents,
      List<FavouriteEventOrActivity> openActivities,
      List<FavouriteEventOrActivity> closedActivities});
}

/// @nodoc
class _$FavouriteEventsAndActivitiesCopyWithImpl<$Res,
        $Val extends FavouriteEventsAndActivities>
    implements $FavouriteEventsAndActivitiesCopyWith<$Res> {
  _$FavouriteEventsAndActivitiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? futureEvents = null,
    Object? pastEvents = null,
    Object? openActivities = null,
    Object? closedActivities = null,
  }) {
    return _then(_value.copyWith(
      futureEvents: null == futureEvents
          ? _value.futureEvents
          : futureEvents // ignore: cast_nullable_to_non_nullable
              as List<FavouriteEventOrActivity>,
      pastEvents: null == pastEvents
          ? _value.pastEvents
          : pastEvents // ignore: cast_nullable_to_non_nullable
              as List<FavouriteEventOrActivity>,
      openActivities: null == openActivities
          ? _value.openActivities
          : openActivities // ignore: cast_nullable_to_non_nullable
              as List<FavouriteEventOrActivity>,
      closedActivities: null == closedActivities
          ? _value.closedActivities
          : closedActivities // ignore: cast_nullable_to_non_nullable
              as List<FavouriteEventOrActivity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavouriteEventsAndActivitiesCopyWith<$Res>
    implements $FavouriteEventsAndActivitiesCopyWith<$Res> {
  factory _$$_FavouriteEventsAndActivitiesCopyWith(
          _$_FavouriteEventsAndActivities value,
          $Res Function(_$_FavouriteEventsAndActivities) then) =
      __$$_FavouriteEventsAndActivitiesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FavouriteEventOrActivity> futureEvents,
      List<FavouriteEventOrActivity> pastEvents,
      List<FavouriteEventOrActivity> openActivities,
      List<FavouriteEventOrActivity> closedActivities});
}

/// @nodoc
class __$$_FavouriteEventsAndActivitiesCopyWithImpl<$Res>
    extends _$FavouriteEventsAndActivitiesCopyWithImpl<$Res,
        _$_FavouriteEventsAndActivities>
    implements _$$_FavouriteEventsAndActivitiesCopyWith<$Res> {
  __$$_FavouriteEventsAndActivitiesCopyWithImpl(
      _$_FavouriteEventsAndActivities _value,
      $Res Function(_$_FavouriteEventsAndActivities) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? futureEvents = null,
    Object? pastEvents = null,
    Object? openActivities = null,
    Object? closedActivities = null,
  }) {
    return _then(_$_FavouriteEventsAndActivities(
      futureEvents: null == futureEvents
          ? _value._futureEvents
          : futureEvents // ignore: cast_nullable_to_non_nullable
              as List<FavouriteEventOrActivity>,
      pastEvents: null == pastEvents
          ? _value._pastEvents
          : pastEvents // ignore: cast_nullable_to_non_nullable
              as List<FavouriteEventOrActivity>,
      openActivities: null == openActivities
          ? _value._openActivities
          : openActivities // ignore: cast_nullable_to_non_nullable
              as List<FavouriteEventOrActivity>,
      closedActivities: null == closedActivities
          ? _value._closedActivities
          : closedActivities // ignore: cast_nullable_to_non_nullable
              as List<FavouriteEventOrActivity>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_FavouriteEventsAndActivities
    with DiagnosticableTreeMixin
    implements _FavouriteEventsAndActivities {
  const _$_FavouriteEventsAndActivities(
      {required final List<FavouriteEventOrActivity> futureEvents,
      required final List<FavouriteEventOrActivity> pastEvents,
      required final List<FavouriteEventOrActivity> openActivities,
      required final List<FavouriteEventOrActivity> closedActivities})
      : _futureEvents = futureEvents,
        _pastEvents = pastEvents,
        _openActivities = openActivities,
        _closedActivities = closedActivities;

  factory _$_FavouriteEventsAndActivities.fromJson(Map<String, dynamic> json) =>
      _$$_FavouriteEventsAndActivitiesFromJson(json);

  final List<FavouriteEventOrActivity> _futureEvents;
  @override
  List<FavouriteEventOrActivity> get futureEvents {
    if (_futureEvents is EqualUnmodifiableListView) return _futureEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_futureEvents);
  }

  final List<FavouriteEventOrActivity> _pastEvents;
  @override
  List<FavouriteEventOrActivity> get pastEvents {
    if (_pastEvents is EqualUnmodifiableListView) return _pastEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pastEvents);
  }

  final List<FavouriteEventOrActivity> _openActivities;
  @override
  List<FavouriteEventOrActivity> get openActivities {
    if (_openActivities is EqualUnmodifiableListView) return _openActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_openActivities);
  }

  final List<FavouriteEventOrActivity> _closedActivities;
  @override
  List<FavouriteEventOrActivity> get closedActivities {
    if (_closedActivities is EqualUnmodifiableListView)
      return _closedActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_closedActivities);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FavouriteEventsAndActivities(futureEvents: $futureEvents, pastEvents: $pastEvents, openActivities: $openActivities, closedActivities: $closedActivities)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FavouriteEventsAndActivities'))
      ..add(DiagnosticsProperty('futureEvents', futureEvents))
      ..add(DiagnosticsProperty('pastEvents', pastEvents))
      ..add(DiagnosticsProperty('openActivities', openActivities))
      ..add(DiagnosticsProperty('closedActivities', closedActivities));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavouriteEventsAndActivities &&
            const DeepCollectionEquality()
                .equals(other._futureEvents, _futureEvents) &&
            const DeepCollectionEquality()
                .equals(other._pastEvents, _pastEvents) &&
            const DeepCollectionEquality()
                .equals(other._openActivities, _openActivities) &&
            const DeepCollectionEquality()
                .equals(other._closedActivities, _closedActivities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_futureEvents),
      const DeepCollectionEquality().hash(_pastEvents),
      const DeepCollectionEquality().hash(_openActivities),
      const DeepCollectionEquality().hash(_closedActivities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavouriteEventsAndActivitiesCopyWith<_$_FavouriteEventsAndActivities>
      get copyWith => __$$_FavouriteEventsAndActivitiesCopyWithImpl<
          _$_FavouriteEventsAndActivities>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavouriteEventsAndActivitiesToJson(
      this,
    );
  }
}

abstract class _FavouriteEventsAndActivities
    implements FavouriteEventsAndActivities {
  const factory _FavouriteEventsAndActivities(
          {required final List<FavouriteEventOrActivity> futureEvents,
          required final List<FavouriteEventOrActivity> pastEvents,
          required final List<FavouriteEventOrActivity> openActivities,
          required final List<FavouriteEventOrActivity> closedActivities}) =
      _$_FavouriteEventsAndActivities;

  factory _FavouriteEventsAndActivities.fromJson(Map<String, dynamic> json) =
      _$_FavouriteEventsAndActivities.fromJson;

  @override
  List<FavouriteEventOrActivity> get futureEvents;
  @override
  List<FavouriteEventOrActivity> get pastEvents;
  @override
  List<FavouriteEventOrActivity> get openActivities;
  @override
  List<FavouriteEventOrActivity> get closedActivities;
  @override
  @JsonKey(ignore: true)
  _$$_FavouriteEventsAndActivitiesCopyWith<_$_FavouriteEventsAndActivities>
      get copyWith => throw _privateConstructorUsedError;
}
