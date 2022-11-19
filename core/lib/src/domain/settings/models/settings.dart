import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  const Settings({
    this.themeModeIndex = 0,
  });

  final int themeModeIndex;

  @override
  List<Object> get props => [themeModeIndex];

  Settings copyWith({int? themeModeIndex}) {
    return Settings(
      themeModeIndex: themeModeIndex ?? this.themeModeIndex,
    );
  }
}
