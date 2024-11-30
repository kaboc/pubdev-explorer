import 'package:async_phase/async_phase.dart';

import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/pub/models/package.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/daos/packages_dao.dart';

PubDao get _remoteDao => pubDaoPot();

PackagesDao get _localDao => localDatabasePot().packagesDao;

class PackagesRepository {
  const PackagesRepository();

  Future<AsyncPhase<Iterable<String>>> fetchPackageNames({
    int page = 0,
    Iterable<String>? keywords,
  }) async {
    return AsyncPhase.from(
      () => _remoteDao.fetchPackageNames(page: page, keywords: keywords),
      onError: (_, e, s) => Logger.error(e, s),
    );
  }

  Future<AsyncPhase<Package>> fetchPackage({
    required String name,
    required Duration cacheDuration,
    required bool useCache,
  }) async {
    return AsyncPhase.from(
      () async {
        var package =
            useCache ? await _fetchPackageFromLocal(name, cacheDuration) : null;

        if (package == null) {
          package = await _remoteDao.fetchPackage(name: name);
          await _localDao.upsertPackage(package: package);

          // Fetches from local DB again to obtain the package
          // together with bookmark status.
          return await _fetchPackageFromLocal(name, cacheDuration) ?? package;
        }

        return package;
      },
      onError: (_, e, s) => Logger.error(e, s),
    );
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
