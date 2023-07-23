import 'package:flutter/widgets.dart';

class BottomScrollDetector extends StatefulWidget {
  const BottomScrollDetector({
    required this.extent,
    required this.onBottomReached,
    required this.child,
  });

  final double extent;
  final VoidCallback onBottomReached;
  final Widget child;

  @override
  State<BottomScrollDetector> createState() => _BottomScrollDetectorState();
}

class _BottomScrollDetectorState extends State<BottomScrollDetector> {
  double _prevDistance = 0.0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final currentDistance = metrics.maxScrollExtent - metrics.pixels;
        if (_prevDistance > widget.extent && currentDistance <= widget.extent) {
          widget.onBottomReached();
        }
        _prevDistance = currentDistance;
        return true;
      },
      child: widget.child,
    );
  }
}
