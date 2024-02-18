extension EnumCollection<T extends Enum> on Iterable<T> {
  T? byNameOrNull(String name) {
    return asNameMap()[name];
  }

  Iterable<T> fromNames(Iterable<String> names) {
    return names.map(byNameOrNull).whereType<T>();
  }

  Iterable<T> fromCommaSeparatedNames(String names) {
    return fromNames(names.split(','));
  }

  String toCommaSeparatedNames() {
    return map((v) => v.name).join(',');
  }
}
