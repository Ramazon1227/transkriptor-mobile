import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/di/injection.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/widgets/app_empty_view.dart';
import 'package:transkriptor_uz/core/widgets/app_error_view.dart';
import 'package:transkriptor_uz/core/widgets/app_loading_view.dart';
import 'package:transkriptor_uz/features/example/application/example_bloc.dart';
import 'package:transkriptor_uz/features/example/presentation/widgets/post_tile.dart';
import 'package:transkriptor_uz/features/example/presentation/widgets/user_filter_bar.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({this.initialUserId, super.key});

  final int? initialUserId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ExampleBloc>()..add(ExampleStarted(userId: initialUserId)),
      child: const _ExampleView(),
    );
  }
}

class _ExampleView extends StatelessWidget {
  const _ExampleView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.examplePostsTitle)),
      body: Column(
        children: [
          BlocSelector<ExampleBloc, ExampleState, int?>(
            selector: (state) => state.userId,
            builder: (context, userId) => UserFilterBar(
              selected: userId,
              onChanged: (id) =>
                  context.read<ExampleBloc>().add(ExampleUserChanged(id)),
            ),
          ),
          const Expanded(child: _ExampleBody()),
        ],
      ),
    );
  }
}

class _ExampleBody extends StatelessWidget {
  const _ExampleBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExampleBloc, ExampleState>(
      buildWhen: (prev, next) =>
          prev.status != next.status || prev.posts != next.posts,
      builder: (context, state) {
        final bloc = context.read<ExampleBloc>();
        return switch (state.status) {
          ExampleStatus.initial ||
          ExampleStatus.loading => const AppLoadingView(),
          ExampleStatus.failure => AppErrorView(
            failure: state.failure!,
            onRetry: () => bloc.add(const ExampleRefreshed()),
          ),
          ExampleStatus.empty => AppEmptyView(
            message: context.l10n.examplePostsEmpty,
          ),
          ExampleStatus.success => RefreshIndicator(
            onRefresh: () async {
              bloc.add(const ExampleRefreshed());
              await bloc.stream.firstWhere(
                (s) => s.status != ExampleStatus.loading,
              );
            },
            child: ListView.separated(
              itemCount: state.posts.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (_, i) => PostTile(post: state.posts[i]),
            ),
          ),
        };
      },
    );
  }
}
