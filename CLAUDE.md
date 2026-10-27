# Project Rules

These rules define the architecture and code style of this Flutter project. Follow them for every task. When in doubt, replicate an existing solution from this codebase instead of inventing a new one.

## 0. Stack

- Flutter, Dart 3, null safety
- State management: `flutter_bloc` + `bloc_concurrency`
- Models and states: `freezed` + `json_serializable`
- Networking: `dio`
- Functional errors: `Either` (`dartz`)
- DI: `get_it` + `injectable`
- Testing: `bloc_test`, `mocktail`

Do not add packages outside this list without asking.

## 1. Workflow (every task)

1. Before writing code, fully read the most similar existing feature (model → repository → facade → bloc → UI) and follow exactly that pattern. If no similar feature exists, use `library` (bloc with events) or `job` (cubit) as the template.
2. Do not add new packages, patterns, or folder structures without asking.
3. Do only what was asked. Do not refactor, reformat, or rename code unrelated to the task.
4. If the task says "no UI", write only the data layer and the bloc.
5. When you have to make an assumption (nullability, enum default, numeric type, pagination), list that decision separately in the final report. If API data is ambiguous, ask.
6. At the end:
   - `dart run build_runner build --delete-conflicting-outputs`
   - `flutter analyze` — 0 errors, 0 warnings
   - Briefly report which files were created or changed, which feature you used as a template, and what assumptions you made.

## 2. Architecture

Clean architecture, feature-first. Data flows in one direction only:

```
API → Model (DTO) → Repository → Facade → Bloc/Cubit → UI
```

- The UI talks only to blocs/cubits. Never call a repository or Dio from the UI.
- Blocs work only through facades and never call repositories directly.
- The facade is the entry point to the business layer: it combines repository calls and converts errors into `Failure`.
- Closely related sub-features live inside one shared module (e.g. several reports under `report/`). Each sub-feature has its own model/repository/facade.

Folder structure:

```
lib/
  core/
    network/       # Dio setup, interceptors
    di/            # get_it / injectable config
    constants/     # base URL, endpoints, storage keys
    error/         # Failure classes
    router/
    theme/
    l10n/
    storage/
    widgets/       # shared widgets
    utils/
  features/
    <feature>/
      domain/          # entities, failures, facade interface
      infrastructure/  # models, repositories, facade implementation
      application/     # bloc / cubit
      presentation/    # pages, widgets
  mock/            # test-only code (see section 8)
```

## 3. Models and Freezed

- All models and states use `@freezed`: `@Default`, `@JsonKey(name: ...)`, `factory X.fromJson(...)`.
- `snake_case` API fields are mapped to `camelCase` via `@JsonKey`.
- Every field the API does not guarantee is nullable or has a `@Default`. Parsing must never crash the app.
- Enums have an `unknown` fallback (`@JsonKey(unknownEnumValue: ...)`).
- Large monetary amounts use `num` or `double`, not `int`. State the chosen type in the report.
- If `id` is unreliable (e.g. always 0), pick another unique field as the identifier.
- Keep list order exactly as the API returns it unless the task says otherwise.
- Never edit generated files (`*.freezed.dart`, `*.g.dart`, `*.config.dart`) by hand.

## 4. Errors

- Repositories catch `DioException` and parsing errors and convert them into `Failure`.
- Facades return `Either<Failure, T>`. Exceptions never reach the bloc.
- Blocs handle errors in one place via `fold`.
- An empty list is not an error; it is a separate "empty" state.

## 5. State management (Bloc/Cubit)

- Cubit for simple, event-less flows. Bloc when events, transformers, or complex flows are needed.
- States use Freezed: a single state class plus a status enum (`initial`, `loading`, `success`, `empty`, `failure`).
- Events use Dart 3 sealed classes.
- Use `bloc_concurrency` transformers:
  - submit, login, payment → `droppable()`
  - search, filter, year or tab change → `restartable()`
  - order-sensitive flows → `sequential()`
- A late response must never overwrite the result of a newer selection (filter or year change).
- Independent loads on one screen get separate status fields (e.g. filter and main list). If one fails, the other's data is kept.
- Use `BlocSelector` or `buildWhen` to avoid unnecessary rebuilds.
- Initial parameters (year, id) are passed into the bloc from outside.

## 6. Network

- A single shared `Dio` instance comes from DI. Never create `Dio()` inside a feature.
- Base URL and endpoints live only in `core/constants`. No hardcoded URLs.
- Query parameters go through `queryParameters`, never concatenated into the URL string.
- `TokenInterceptor` rules:
  - Never log access or refresh tokens, not even via `debugPrint`.
  - Refresh runs once through a `Completer` and has a timeout.
  - The refresh call is wrapped in `try-catch` so pending requests never hang if it throws.
  - Retries use a separate `_retryDio` without `TokenInterceptor`, preventing infinite refresh loops.
  - If the refresh endpoint itself returns 401, do not refresh again; log the user out.
  - Use `handler.next` / `handler.resolve` / `handler.reject`, not `super.onError`.
  - Reset the navigate-to-login flag after a successful login. A `null` navigation context must not fail silently.
- Logging only in debug mode, with no sensitive data.

## 7. Dependency injection

- Register every repository, facade, and bloc with `injectable` annotations.
- Facades are registered against their domain interface (`@LazySingleton(as: IXxxFacade)`).
- Blocs as `@injectable` (factory); services and repositories as `@lazySingleton`.

## 8. Mock and test-only code

- Test-only pages and services live in `lib/mock/`. Do not touch real auth, profile, or other production code.
- Mock cache keys start with the `mock_` prefix.
- A mock page reproduces the real page UI 1:1 and reuses existing entities/models.
- Every mock file starts with a `// TEST ONLY` comment.

## 9. Naming and code style

- File names `snake_case`, class names `PascalCase`, feature names `snake_case`.
- Facade interface `IXxxFacade`, implementation `XxxFacade`, repository `XxxRepository`, bloc `XxxBloc` / `XxxEvent` / `XxxState`.
- Use `flutter_lints` or `very_good_analysis`. Disabling lint rules or adding `// ignore:` is allowed only with a comment explaining why.
- Keep widgets small. Reusable widgets go to `core/widgets` or the feature's `presentation/widgets/` folder.
- Use `const` constructors wherever possible.
- No hardcoded strings or colors in the UI; use localization and the theme.
- Keep commits small and focused on one topic.
