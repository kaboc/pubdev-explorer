import 'package:drift/drift.dart';

import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/mock/mock_pub_dao.dart';

export 'package:pubdev_explorer_core/src/domain/pub/_pub.dart';
export 'package:pubdev_explorer_core/src/domain/settings/_settings.dart';
export 'package:pubdev_explorer_core/src/infrastructure/pub_api/mock/mock_pub_dao.dart';

void openLocalDatabase({required QueryExecutor executor}) {
  localDatabasePot.replace(() => Database(executor: executor));
}

void configureApi({required bool isWeb}) {
  if (kUseMock || isWeb) {
    pubDaoPot.replace(MockPubDao.new);
  }
}
