import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/example/domain/entities/post.dart';
import 'package:transkriptor_uz/features/example/domain/i_example_facade.dart';

part 'example_bloc.freezed.dart';
part 'example_event.dart';
part 'example_state.dart';

@injectable
class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc(this._facade) : super(const ExampleState()) {
    // One handler for every load event, so restartable() cancels across
    // them: a late answer for an old filter can never overwrite a newer
    // one.
    on<ExampleEvent>(_onLoad, transformer: restartable());
  }

  final IExampleFacade _facade;

  Future<void> _onLoad(ExampleEvent event, Emitter<ExampleState> emit) async {
    final userId = switch (event) {
      ExampleStarted(:final userId) => userId,
      ExampleUserChanged(:final userId) => userId,
      ExampleRefreshed() => state.userId,
    };

    emit(
      state.copyWith(
        status: ExampleStatus.loading,
        userId: userId,
        failure: null,
      ),
    );

    final result = await _facade.getPosts(userId: userId);

    result.fold(
      (failure) =>
          emit(state.copyWith(status: ExampleStatus.failure, failure: failure)),
      (posts) => emit(
        state.copyWith(
          status: posts.isEmpty ? ExampleStatus.empty : ExampleStatus.success,
          posts: posts,
        ),
      ),
    );
  }
}
