extension EnumList<T extends Enum> on List<T> {
  T? byIndexOrNull(int index) {
    return index >= 0 && index < length ? this[index] : null;
  }

  T? byNameOrNull(String name) {
    return asNameMap()[name];
  }

  List<T> fromNames(List<String> names) {
    return names.map(byNameOrNull).whereType<T>().toList();
  }

  List<T> fromCommaSeparatedNames(String names) {
    return fromNames(names.split(','));
  }

  String toCommaSeparatedNames() {
    return map((v) => v.name).join(',');
  }
}
