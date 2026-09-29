import 'package:flutter/material.dart';

class SkeletonShimmer extends StatefulWidget {
  final Widget child;

  const SkeletonShimmer({
    super.key,
    required this.child,
  });

  @override
  State<SkeletonShimmer> createState() => _SkeletonShimmerState();
}

class _SkeletonShimmerState extends State<SkeletonShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            fit: StackFit.passthrough,
            children: [
              widget.child,

              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final value = _controller.value;

                      return FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Transform.translate(
                          offset: Offset(
                            constraints.maxWidth * (value * 2 - 1),
                            0,
                          ),
                          child: Container(
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: isDark
                                    ? const [
                                  Colors.transparent,
                                  Color(0x223A3A3A),
                                  Colors.transparent,
                                ]
                                    : const [
                                  Colors.transparent,
                                  Color(0x66FFFFFF),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}