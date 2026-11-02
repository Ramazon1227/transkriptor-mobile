import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:transkriptor_uz/core/error/failure.dart';
import 'package:transkriptor_uz/features/library/domain/entities/folder.dart';
import 'package:transkriptor_uz/features/library/domain/entities/library_item.dart';
import 'package:transkriptor_uz/features/library/domain/tag_rules.dart';

abstract interface class ILibraryFacade {
  /// One page of [workspaceId]'s files, newest first, in the API's order.
  /// [folderId] narrows the list to one folder; null is every file. [source]
  /// narrows it to one origin on the server; null is every origin. [meeting]
  /// true keeps the meeting recordings, false the rest. [query] is a part of
  /// the name, [tag] one tag. [limit] is at most 100; [cursor] is the last
  /// page's [LibraryPage.nextCursor].
  Future<Either<Failure, LibraryPage>> getItems({
    required String workspaceId,
    String? folderId,
    MediaSource? source,
    bool? meeting,
    String? query,
    String? tag,
    int? limit,
    String? cursor,
  });

  /// The workspace's tags, most used first; not only those on loaded rows.
  Future<Either<Failure, List<String>>> getTags({required String workspaceId});

  /// The workspace's folders, in the API's order.
  Future<Either<Failure, List<Folder>>> getFolders({
    required String workspaceId,
  });

  /// 409 when a live folder has that name (case-insensitive) or the
  /// workspace has 100 folders; 403 for a VIEWER.
  Future<Either<Failure, Folder>> createFolder({
    required String workspaceId,
    required String name,
  });

  Future<Either<Failure, Folder>> renameFolder({
    required String workspaceId,
    required String folderId,
    required String name,
  });

  /// The folder goes; its files stay, outside any folder.
  Future<Either<Failure, Unit>> deleteFolder({
    required String workspaceId,
    required String folderId,
  });

  /// Moves one file into [folderId], or out of every folder when null.
  Future<Either<Failure, LibraryItem>> moveToFolder({
    required String mediaId,
    required String? folderId,
  });

  /// [name] is already trimmed and 1–[FileRules.maxName] characters; the
  /// transcript's title follows it.
  Future<Either<Failure, LibraryItem>> rename({
    required String mediaId,
    required String name,
  });

  /// Deletes the file with its transcript; a running job is cancelled.
  Future<Either<Failure, Unit>> deleteMedia(String mediaId);

  /// Replaces the file's whole tag list.
  Future<Either<Failure, LibraryItem>> setTags({
    required String mediaId,
    required List<String> tags,
  });
}
