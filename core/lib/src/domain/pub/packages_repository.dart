import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/pub/models/package.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/daos/packages_dao.dart';

PubDao get _remoteDao => pubDaoPot();

PackagesDao get _localDao => localDatabasePot().packagesDao;

class PackagesRepository {
  const PackagesRepository();

  Future<List<String>> fetchPackageNames({
    int page = 0,
    String? keywords,
  }) async {
    try {
      return await _remoteDao.fetchPackageNames(page: page, keywords: keywords);
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }

  Future<Package> fetchPackage({
    required String name,
    required Duration cacheDuration,
    required bool useCache,
  }) async {
    try {
      var package =
          useCache ? await _fetchPackageFromLocal(name, cacheDuration) : null;

      if (package == null) {
        package = await _remoteDao.fetchPackage(name: name);
        await _localDao.upsertPackage(package: package);

        // Fetches from local DB again to obtain the package
        // together with bookmark status.
        package = await _fetchPackageFromLocal(name, cacheDuration);
        return package!;
      }

      return package;
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }

  Future<Package?> _fetchPackageFromLocal(
    String name,
    Duration cacheDuration,
  ) async {
    try {
      return _localDao.fetchPackage(
        name: name,
        after: DateTime.now().subtract(cacheDuration),
      );
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }
}
