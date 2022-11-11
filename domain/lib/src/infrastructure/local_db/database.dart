import 'package:drift/drift.dart';

import 'package:pubdev_explorer_domain/src/infrastructure/local_db/daos/bookmarks_dao.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/daos/packages_dao.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/daos/settings_dao.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/tables/bookmarks_table.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/tables/packages_table.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/tables/settings_table.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/views/packages_with_bookmark.dart';

part '../../generated/infrastructure/local_db/database.g.dart';

@DriftDatabase(
  tables: [SettingsTable, PackagesTable, BookmarksTable],
  views: [PackagesWithBookmark],
  daos: [SettingsDao, PackagesDao, BookmarksDao],
)
class Database extends _$Database {
  Database({required QueryExecutor executor}) : super(executor);

  Future<void> dispose() async {
    await close();
  }

  @override
  int get schemaVersion => 1;
}
