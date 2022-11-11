import 'package:equatable/equatable.dart';

class Version extends Equatable {
  const Version({this.version = '', this.publishedAt});

  const factory Version.none() = Version;

  final String version;
  final DateTime? publishedAt;

  @override
  List<Object?> get props => [version, publishedAt];
}
