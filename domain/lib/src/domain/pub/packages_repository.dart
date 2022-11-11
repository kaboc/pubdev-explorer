import 'package:pubdev_explorer_domain/src/common/_common.dart';
import 'package:pubdev_explorer_domain/src/domain/pub/models/package.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/daos/packages_dao.dart';

PubDao get _remoteDao => pubDaoPot();

PackagesDao get _localDao => localDatabasePot().packagesDao;

class PackagesRepository {
  Future<List<String>> fetchPackageNames({int page = 0}) async {
    try {
      return _remoteDao.fetchPackageNames(page: page);
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }

  Future<Package> fetchPackage({
    required String name,
    bool fromWeb = false,
  }) async {
    try {
      var package = fromWeb ? null : await _fetchPackageFromLocal(name);

      if (package == null) {
        package = await _remoteDao.fetchPackage(name: name);
        await _localDao.addOrUpdatePackage(package: package);

        // Fetches from local DB again to obtain the package
        // together with bookmark status.
        return (await _fetchPackageFromLocal(name))!;
      }

      return package;
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }

  Future<Package?> _fetchPackageFromLocal(String name) async {
    try {
      return _localDao.fetchPackage(
        name: name,
        after: DateTime.now().subtract(const Duration(days: 2)),
      );
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }
}
