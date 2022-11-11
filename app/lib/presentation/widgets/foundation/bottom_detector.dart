import 'package:flutter/widgets.dart';

class BottomDetector extends StatefulWidget {
  const BottomDetector({
    required this.extent,
    required this.onEnterBottom,
    required this.builder,
  });

  final double extent;
  final VoidCallback onEnterBottom;
  final Widget Function(BuildContext, ScrollController) builder;

  @override
  State<BottomDetector> createState() => _BottomDetectorState();
}

class _BottomDetectorState extends State<BottomDetector> {
  final ScrollController _controller = ScrollController();

  double _prevDistance = 0.0;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final currentDistance = metrics.maxScrollExtent - metrics.pixels;
        if (_prevDistance > widget.extent && currentDistance <= widget.extent) {
          widget.onEnterBottom();
        }
        _prevDistance = currentDistance;
        return true;
      },
      child: widget.builder(context, _controller),
    );
  }
}
