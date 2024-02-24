import 'package:pubdev_explorer_core/src/domain/pub/_pub.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/models/package_basics.dart';

extension BasicsToPackage on PackageBasics {
  Package get asPackage {
    final latestVersion = latest;
    final lastVersion = versions.lastOrNull;

    return Package(
      name: name,
      description: latestVersion.pubSpec.description,
      latest: Version(
        version: latestVersion.version,
        publishedAt: latestVersion.published,
      ),
      preRelease:
          lastVersion == null || lastVersion.version == latestVersion.version
              ? null
              : Version(
                  version: lastVersion.version,
                  publishedAt: lastVersion.published,
                ),
    );
  }
}
