import 'package:collection/collection.dart';

import 'package:pubdev_explorer_domain/src/domain/pub/_pub.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/pub_api/models/package_basics.dart';

extension BasicsToPackage on PackageBasics {
  Package get asPackage {
    final latestVersion = versions.firstWhereOrNull(
      (v) => v.version == latest.version,
    );
    final lastVersion = versions.last;

    return Package(
      name: name,
      description: latestVersion?.pubSpec.description ?? '',
      latest: Version(
        version: latestVersion?.version ?? '',
        publishedAt: latestVersion?.published,
      ),
      preRelease: lastVersion == latestVersion
          ? null
          : Version(
              version: lastVersion.version,
              publishedAt: lastVersion.published,
            ),
    );
  }
}
