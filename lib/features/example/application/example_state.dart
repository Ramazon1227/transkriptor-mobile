part of 'example_bloc.dart';

enum ExampleStatus { initial, loading, success, empty, failure }

@freezed
abstract class ExampleState with _$ExampleState {
  const factory ExampleState({
    @Default(ExampleStatus.initial) ExampleStatus status,
    @Default(<Post>[]) List<Post> posts,
    int? userId,
    Failure? failure,
  }) = _ExampleState;
}
