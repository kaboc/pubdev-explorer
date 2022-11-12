import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:pubdev_explorer/presentation/common/_common.dart';

class GuideHeading extends StatelessWidget {
  const GuideHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.headlineSmall.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class GuideTable extends StatelessWidget {
  const GuideTable(this.content);

  final Map<String, String> content;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FlexColumnWidth(isMacOs && !kIsWeb ? 0.4 : 0.32),
        1: const IntrinsicColumnWidth(),
        2: FlexColumnWidth(isMacOs && !kIsWeb ? 0.6 : 0.68),
      },
      children: [
        for (final key in content.keys)
          TableRow(
            children: [
              TableCell(
                child: Text(
                  key,
                  textAlign: TextAlign.right,
                  style: context.theme.textTheme.bodyLarge,
                ),
              ),
              const TableCell(
                child: SizedBox(width: 28.0),
              ),
              TableCell(
                child: Text(content[key]!),
              ),
            ],
          ),
      ],
    );
  }
}
