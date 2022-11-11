import 'package:pot/pot.dart';

import 'package:pubdev_explorer_domain/src/infrastructure/local_db/database.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/pub_api/pub_dao.dart';

export 'package:pubdev_explorer_domain/src/infrastructure/local_db/database.dart';
export 'package:pubdev_explorer_domain/src/infrastructure/pub_api/pub_dao.dart';

final pubDaoPot = Pot.replaceable<PubDao>(PubDao.new);

final localDatabasePot = Pot.pending<Database>(
  disposer: (db) => db.dispose(),
);
