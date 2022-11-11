import 'package:flutter/widgets.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

class Metrics extends StatelessWidget {
  const Metrics({required this.package});

  final Package package;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.headlineSmall,
      child: Wrap(
        spacing: 16.0,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${package.likes}'),
              Text(
                'LIKES',
                style: context.bodySmall,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${package.points}'),
              Text(
                'PUB POINTS',
                style: context.bodySmall,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Text('${package.roundedPopularity}'),
                  Transform.translate(
                    offset: const Offset(0.0, 4.0),
                    child: Text(
                      '%',
                      style: context.bodySmall.copyWith(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              Text(
                'POPULARITY',
                style: context.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
