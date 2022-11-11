import 'package:flutter/material.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

class VersionTable extends StatelessWidget {
  const VersionTable({required this.package});

  final Package package;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FixedColumnWidth(16.0),
        2: FractionColumnWidth(1.0),
      },
      children: [
        TableRow(
          children: [
            Text(package.latest.version),
            const SizedBox.shrink(),
            _Tooltip(
              message: package.latest.publishedAt!.formattedWithTime,
              above: package.preRelease != null,
              child: Text(package.latest.publishedAt!.formatted),
            ),
          ],
        ),
        if (package.preRelease != null)
          TableRow(
            children: [
              Text(package.preRelease!.version),
              const SizedBox.shrink(),
              _Tooltip(
                message: package.preRelease!.publishedAt!.formattedWithTime,
                child: Text(
                  package.preRelease!.publishedAt.formatted,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _Tooltip extends StatefulWidget {
  const _Tooltip({
    required this.message,
    required this.child,
    this.above = false,
  });

  final String message;
  final Widget child;
  final bool above;

  @override
  State<_Tooltip> createState() => _TooltipState();
}

class _TooltipState extends State<_Tooltip> {
  final _key = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Tooltip(
        key: _key,
        message: widget.message,
        preferBelow: !widget.above,
        verticalOffset: 12.0,
        margin: const EdgeInsets.only(left: 48.0),
        child: GestureDetector(
          onTap: () => _key.currentState?.ensureTooltipVisible(),
          child: widget.child,
        ),
      ),
    );
  }
}
