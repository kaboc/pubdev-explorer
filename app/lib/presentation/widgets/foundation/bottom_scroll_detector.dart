import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

const _kIndicatorAreaHeight = 72.0;

class BottomScrollDetector extends StatefulWidget {
  const BottomScrollDetector({
    super.key,
    required this.extent,
    required this.slivers,
    required this.onBottomReached,
    this.padding = EdgeInsets.zero,
    this.primary,
  });

  final double extent;
  final List<Widget> slivers;
  final EdgeInsets padding;
  final AsyncCallback? onBottomReached;
  final bool? primary;

  @override
  State<BottomScrollDetector> createState() => _BottomScrollDetectorState();
}

class _BottomScrollDetectorState extends State<BottomScrollDetector> {
  double _prevDistance = 0.0;
  bool _isCallbackEnabled = true;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        final onBottomReached = widget.onBottomReached;
        final metrics = notification.metrics;
        final currentDistance = metrics.maxScrollExtent - metrics.pixels;

        if (_isCallbackEnabled &&
            onBottomReached != null &&
            _prevDistance > widget.extent &&
            currentDistance <= widget.extent) {
          _isCallbackEnabled = false;
          onBottomReached().then((_) => _isCallbackEnabled = true);
        }

        _prevDistance = currentDistance;

        return true;
      },
      child: CustomScrollView(
        primary: widget.primary,
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: widget.padding.top),
          ),
          for (final sliver in widget.slivers)
            SliverPadding(
              padding: widget.padding.copyWith(top: 0.0, bottom: 0.0),
              sliver: sliver,
            ),
          if (widget.onBottomReached == null)
            SliverToBoxAdapter(
              child: SizedBox(height: widget.padding.bottom),
            )
          else
            SliverList(
              delegate: SliverChildListDelegate(const [
                SizedBox.shrink(),
                SizedBox(
                  height: _kIndicatorAreaHeight,
                  child: CupertinoActivityIndicator(),
                ),
              ]),
            ),
        ],
      ),
    );
  }
}
