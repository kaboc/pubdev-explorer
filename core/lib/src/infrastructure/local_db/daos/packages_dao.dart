import 'package:drift/drift.dart';

import 'package:pubdev_explorer_core/src/domain/pub/_pub.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/converters/package.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/database.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/tables/packages_table.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/views/packages_with_bookmark.dart';

part '../../../generated/infrastructure/local_db/daos/packages_dao.g.dart';

@DriftAccessor(
  tables: [PackagesTable],
  views: [PackagesWithBookmark],
)
class PackagesDao extends DatabaseAccessor<Database> with _$PackagesDaoMixin {
  PackagesDao(super.db);

  Future<Package?> fetchPackage({
    required String name,
    required DateTime after,
  }) async {
    final stmt = select(packagesWithBookmark)
      ..where((t) => t.name.equals(name))
      ..where((t) => t.savedAt.isBiggerThanValue(after));
    final data = await stmt.getSingleOrNull();
    return data?.asPackage;
  }

  Future<void> addOrUpdatePackage({required Package package}) async {
    final companion = package.asCompanion;
    await into(packagesTable).insertOnConflictUpdate(companion);
  }
}
