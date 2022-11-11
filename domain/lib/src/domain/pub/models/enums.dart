mixin Tag on Enum {
  String get label => name.toUpperCase();
}

enum Sdk with Tag {
  dart,
  flutter;
}

enum Platform with Tag {
  android,
  ios,
  windows,
  linux,
  macos,
  web;
}
