import 'package:flutter/widgets.dart';

class BottomDetector extends StatefulWidget {
  const BottomDetector({
    required this.extent,
    required this.onEnterBottom,
    required this.child,
  });

  final double extent;
  final VoidCallback onEnterBottom;
  final Widget child;

  @override
  State<BottomDetector> createState() => _BottomDetectorState();
}

class _BottomDetectorState extends State<BottomDetector> {
  double _prevDistance = 0.0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final currentDistance = metrics.maxScrollExtent - metrics.pixels;
        if (_prevDistance > widget.extent && currentDistance <= widget.extent) {
          widget.onEnterBottom();
        }
        _prevDistance = currentDistance;
        return true;
      },
      child: widget.child,
    );
  }
}
