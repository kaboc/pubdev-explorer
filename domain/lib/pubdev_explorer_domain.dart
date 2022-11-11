import 'package:drift/drift.dart';

import 'package:pubdev_explorer_domain/src/common/_common.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/pub_api/mock/mock_pub_dao.dart';

export 'package:pubdev_explorer_domain/src/domain/pub/_pub.dart';
export 'package:pubdev_explorer_domain/src/domain/settings/_settings.dart';
export 'package:pubdev_explorer_domain/src/infrastructure/pub_api/mock/mock_pub_dao.dart';

void openLocalDatabase({required QueryExecutor executor}) {
  localDatabasePot.replace(() => Database(executor: executor));
}

void useMock() {
  pubDaoPot.replace(MockPubDao.new);
}
