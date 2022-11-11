import 'package:flutter/widgets.dart';

import 'package:pot/pot.dart';

class Pottery extends StatefulWidget {
  const Pottery({
    super.key,
    required this.pots,
    required this.child,
  });

  final Map<ReplaceablePot<Object?>, PotObjectFactory<Object?>> pots;
  final Widget child;

  @override
  State<Pottery> createState() => _PotteryState();
}

class _PotteryState extends State<Pottery> {
  @override
  void initState() {
    super.initState();
    widget.pots.forEach((pot, factory) => pot.replace(factory));
  }

  @override
  void dispose() {
    // Pots located towards the end in the map may have dependencies on
    // the ones located before them, so they must be reset in reverse order.
    widget.pots.keys.toList().reversed.forEach((pot) {
      pot
        ..reset()
        ..replace(() => throw PotNotReadyException());
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
