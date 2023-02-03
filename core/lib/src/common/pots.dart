import 'package:pot/pot.dart';

import 'package:pubdev_explorer_core/src/infrastructure/local_db/database.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/pub_dao.dart';

export 'package:pubdev_explorer_core/src/infrastructure/local_db/database.dart';
export 'package:pubdev_explorer_core/src/infrastructure/pub_api/pub_dao.dart';

final pubDaoPot = Pot.replaceable<PubDao>(
  () => const PubDao(),
);

final localDatabasePot = Pot.pending<Database>(
  disposer: (db) => db.dispose(),
);
