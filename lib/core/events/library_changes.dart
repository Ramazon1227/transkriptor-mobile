import 'dart:async';

import 'package:injectable/injectable.dart';

/// Fires when the files list or the balance has changed on the server: a
/// file was sent, a job was started, cancelled or finished. Blocs that show
/// either reload on it, so a tab kept alive in the shell is never stale.
@lazySingleton
class LibraryChanges {
  final StreamController<void> _controller = StreamController<void>.broadcast();

  Stream<void> get stream => _controller.stream;

  void notify() => _controller.add(null);

  @disposeMethod
  Future<void> dispose() => _controller.close();
}
