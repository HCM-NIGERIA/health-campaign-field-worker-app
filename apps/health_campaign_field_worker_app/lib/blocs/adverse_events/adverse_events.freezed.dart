// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'adverse_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AdverseEventsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TaskModel task, bool isEditing, BoundaryModel boundaryModel)
        handleSubmit,
    required TResult Function(TaskSearchModel taskSearch) handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            TaskModel task, bool isEditing, BoundaryModel boundaryModel)?
        handleSubmit,
    TResult? Function(TaskSearchModel taskSearch)? handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TaskModel task, bool isEditing, BoundaryModel boundaryModel)?
        handleSubmit,
    TResult Function(TaskSearchModel taskSearch)? handleSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdverseEventsSubmitEvent value) handleSubmit,
    required TResult Function(AdverseEventsSearchEvent value) handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdverseEventsSubmitEvent value)? handleSubmit,
    TResult? Function(AdverseEventsSearchEvent value)? handleSearch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdverseEventsSubmitEvent value)? handleSubmit,
    TResult Function(AdverseEventsSearchEvent value)? handleSearch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdverseEventsEventCopyWith<$Res> {
  factory $AdverseEventsEventCopyWith(
          AdverseEventsEvent value, $Res Function(AdverseEventsEvent) then) =
      _$AdverseEventsEventCopyWithImpl<$Res, AdverseEventsEvent>;
}

/// @nodoc
class _$AdverseEventsEventCopyWithImpl<$Res, $Val extends AdverseEventsEvent>
    implements $AdverseEventsEventCopyWith<$Res> {
  _$AdverseEventsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AdverseEventsSubmitEventCopyWith<$Res> {
  factory _$$AdverseEventsSubmitEventCopyWith(_$AdverseEventsSubmitEvent value,
          $Res Function(_$AdverseEventsSubmitEvent) then) =
      __$$AdverseEventsSubmitEventCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskModel task, bool isEditing, BoundaryModel boundaryModel});
}

/// @nodoc
class __$$AdverseEventsSubmitEventCopyWithImpl<$Res>
    extends _$AdverseEventsEventCopyWithImpl<$Res, _$AdverseEventsSubmitEvent>
    implements _$$AdverseEventsSubmitEventCopyWith<$Res> {
  __$$AdverseEventsSubmitEventCopyWithImpl(_$AdverseEventsSubmitEvent _value,
      $Res Function(_$AdverseEventsSubmitEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? isEditing = null,
    Object? boundaryModel = null,
  }) {
    return _then(_$AdverseEventsSubmitEvent(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskModel,
      null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      null == boundaryModel
          ? _value.boundaryModel
          : boundaryModel // ignore: cast_nullable_to_non_nullable
              as BoundaryModel,
    ));
  }
}

/// @nodoc

class _$AdverseEventsSubmitEvent implements AdverseEventsSubmitEvent {
  const _$AdverseEventsSubmitEvent(
      this.task, this.isEditing, this.boundaryModel);

  @override
  final TaskModel task;
  @override
  final bool isEditing;
  @override
  final BoundaryModel boundaryModel;

  @override
  String toString() {
    return 'AdverseEventsEvent.handleSubmit(task: $task, isEditing: $isEditing, boundaryModel: $boundaryModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdverseEventsSubmitEvent &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            (identical(other.boundaryModel, boundaryModel) ||
                other.boundaryModel == boundaryModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task, isEditing, boundaryModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdverseEventsSubmitEventCopyWith<_$AdverseEventsSubmitEvent>
      get copyWith =>
          __$$AdverseEventsSubmitEventCopyWithImpl<_$AdverseEventsSubmitEvent>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TaskModel task, bool isEditing, BoundaryModel boundaryModel)
        handleSubmit,
    required TResult Function(TaskSearchModel taskSearch) handleSearch,
  }) {
    return handleSubmit(task, isEditing, boundaryModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            TaskModel task, bool isEditing, BoundaryModel boundaryModel)?
        handleSubmit,
    TResult? Function(TaskSearchModel taskSearch)? handleSearch,
  }) {
    return handleSubmit?.call(task, isEditing, boundaryModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TaskModel task, bool isEditing, BoundaryModel boundaryModel)?
        handleSubmit,
    TResult Function(TaskSearchModel taskSearch)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleSubmit != null) {
      return handleSubmit(task, isEditing, boundaryModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdverseEventsSubmitEvent value) handleSubmit,
    required TResult Function(AdverseEventsSearchEvent value) handleSearch,
  }) {
    return handleSubmit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdverseEventsSubmitEvent value)? handleSubmit,
    TResult? Function(AdverseEventsSearchEvent value)? handleSearch,
  }) {
    return handleSubmit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdverseEventsSubmitEvent value)? handleSubmit,
    TResult Function(AdverseEventsSearchEvent value)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleSubmit != null) {
      return handleSubmit(this);
    }
    return orElse();
  }
}

abstract class AdverseEventsSubmitEvent implements AdverseEventsEvent {
  const factory AdverseEventsSubmitEvent(
      final TaskModel task,
      final bool isEditing,
      final BoundaryModel boundaryModel) = _$AdverseEventsSubmitEvent;

  TaskModel get task;
  bool get isEditing;
  BoundaryModel get boundaryModel;
  @JsonKey(ignore: true)
  _$$AdverseEventsSubmitEventCopyWith<_$AdverseEventsSubmitEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AdverseEventsSearchEventCopyWith<$Res> {
  factory _$$AdverseEventsSearchEventCopyWith(_$AdverseEventsSearchEvent value,
          $Res Function(_$AdverseEventsSearchEvent) then) =
      __$$AdverseEventsSearchEventCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskSearchModel taskSearch});
}

/// @nodoc
class __$$AdverseEventsSearchEventCopyWithImpl<$Res>
    extends _$AdverseEventsEventCopyWithImpl<$Res, _$AdverseEventsSearchEvent>
    implements _$$AdverseEventsSearchEventCopyWith<$Res> {
  __$$AdverseEventsSearchEventCopyWithImpl(_$AdverseEventsSearchEvent _value,
      $Res Function(_$AdverseEventsSearchEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskSearch = null,
  }) {
    return _then(_$AdverseEventsSearchEvent(
      null == taskSearch
          ? _value.taskSearch
          : taskSearch // ignore: cast_nullable_to_non_nullable
              as TaskSearchModel,
    ));
  }
}

/// @nodoc

class _$AdverseEventsSearchEvent implements AdverseEventsSearchEvent {
  const _$AdverseEventsSearchEvent(this.taskSearch);

  @override
  final TaskSearchModel taskSearch;

  @override
  String toString() {
    return 'AdverseEventsEvent.handleSearch(taskSearch: $taskSearch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdverseEventsSearchEvent &&
            (identical(other.taskSearch, taskSearch) ||
                other.taskSearch == taskSearch));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskSearch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdverseEventsSearchEventCopyWith<_$AdverseEventsSearchEvent>
      get copyWith =>
          __$$AdverseEventsSearchEventCopyWithImpl<_$AdverseEventsSearchEvent>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TaskModel task, bool isEditing, BoundaryModel boundaryModel)
        handleSubmit,
    required TResult Function(TaskSearchModel taskSearch) handleSearch,
  }) {
    return handleSearch(taskSearch);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            TaskModel task, bool isEditing, BoundaryModel boundaryModel)?
        handleSubmit,
    TResult? Function(TaskSearchModel taskSearch)? handleSearch,
  }) {
    return handleSearch?.call(taskSearch);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TaskModel task, bool isEditing, BoundaryModel boundaryModel)?
        handleSubmit,
    TResult Function(TaskSearchModel taskSearch)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleSearch != null) {
      return handleSearch(taskSearch);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdverseEventsSubmitEvent value) handleSubmit,
    required TResult Function(AdverseEventsSearchEvent value) handleSearch,
  }) {
    return handleSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdverseEventsSubmitEvent value)? handleSubmit,
    TResult? Function(AdverseEventsSearchEvent value)? handleSearch,
  }) {
    return handleSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdverseEventsSubmitEvent value)? handleSubmit,
    TResult Function(AdverseEventsSearchEvent value)? handleSearch,
    required TResult orElse(),
  }) {
    if (handleSearch != null) {
      return handleSearch(this);
    }
    return orElse();
  }
}

abstract class AdverseEventsSearchEvent implements AdverseEventsEvent {
  const factory AdverseEventsSearchEvent(final TaskSearchModel taskSearch) =
      _$AdverseEventsSearchEvent;

  TaskSearchModel get taskSearch;
  @JsonKey(ignore: true)
  _$$AdverseEventsSearchEventCopyWith<_$AdverseEventsSearchEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AdverseEventsState {
  bool get loading => throw _privateConstructorUsedError;
  bool get isEditing => throw _privateConstructorUsedError;
  List<TaskModel>? get tasks => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdverseEventsStateCopyWith<AdverseEventsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdverseEventsStateCopyWith<$Res> {
  factory $AdverseEventsStateCopyWith(
          AdverseEventsState value, $Res Function(AdverseEventsState) then) =
      _$AdverseEventsStateCopyWithImpl<$Res, AdverseEventsState>;
  @useResult
  $Res call({bool loading, bool isEditing, List<TaskModel>? tasks});
}

/// @nodoc
class _$AdverseEventsStateCopyWithImpl<$Res, $Val extends AdverseEventsState>
    implements $AdverseEventsStateCopyWith<$Res> {
  _$AdverseEventsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? isEditing = null,
    Object? tasks = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      tasks: freezed == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AdverseEventsStateCopyWith<$Res>
    implements $AdverseEventsStateCopyWith<$Res> {
  factory _$$_AdverseEventsStateCopyWith(_$_AdverseEventsState value,
          $Res Function(_$_AdverseEventsState) then) =
      __$$_AdverseEventsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading, bool isEditing, List<TaskModel>? tasks});
}

/// @nodoc
class __$$_AdverseEventsStateCopyWithImpl<$Res>
    extends _$AdverseEventsStateCopyWithImpl<$Res, _$_AdverseEventsState>
    implements _$$_AdverseEventsStateCopyWith<$Res> {
  __$$_AdverseEventsStateCopyWithImpl(
      _$_AdverseEventsState _value, $Res Function(_$_AdverseEventsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? isEditing = null,
    Object? tasks = freezed,
  }) {
    return _then(_$_AdverseEventsState(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      tasks: freezed == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskModel>?,
    ));
  }
}

/// @nodoc

class _$_AdverseEventsState implements _AdverseEventsState {
  const _$_AdverseEventsState(
      {this.loading = false,
      this.isEditing = false,
      final List<TaskModel>? tasks})
      : _tasks = tasks;

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool isEditing;
  final List<TaskModel>? _tasks;
  @override
  List<TaskModel>? get tasks {
    final value = _tasks;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AdverseEventsState(loading: $loading, isEditing: $isEditing, tasks: $tasks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdverseEventsState &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading, isEditing,
      const DeepCollectionEquality().hash(_tasks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdverseEventsStateCopyWith<_$_AdverseEventsState> get copyWith =>
      __$$_AdverseEventsStateCopyWithImpl<_$_AdverseEventsState>(
          this, _$identity);
}

abstract class _AdverseEventsState implements AdverseEventsState {
  const factory _AdverseEventsState(
      {final bool loading,
      final bool isEditing,
      final List<TaskModel>? tasks}) = _$_AdverseEventsState;

  @override
  bool get loading;
  @override
  bool get isEditing;
  @override
  List<TaskModel>? get tasks;
  @override
  @JsonKey(ignore: true)
  _$$_AdverseEventsStateCopyWith<_$_AdverseEventsState> get copyWith =>
      throw _privateConstructorUsedError;
}
