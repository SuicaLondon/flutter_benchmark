import 'dart:math';

import 'package:flutter/material.dart';

enum AnimationType {
  translate,
  opcaity,
  scale;

  const AnimationType();

  factory AnimationType.byNumber(int num) {
    int index = num % AnimationType.values.length;
    switch (index) {
      case 1:
        return AnimationType.translate;
      case 2:
        return AnimationType.opcaity;
      default:
        return AnimationType.scale;
    }
  }
}

class RandomAnimationWidget extends StatefulWidget {
  final double top;
  final double left;
  final AnimationType type;
  final Widget child;
  const RandomAnimationWidget({
    super.key,
    required this.top,
    required this.left,
    required this.type,
    required this.child,
  });

  @override
  State<RandomAnimationWidget> createState() => _RandomAnimationWidgetState();
}

class _RandomAnimationWidgetState extends State<RandomAnimationWidget>
    with SingleTickerProviderStateMixin {
  final double _xRatio = Random().nextDouble() * 2 - 1;
  final double _yRatio = Random().nextDouble() * 2 - 1;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (widget.type == AnimationType.translate) {
              return Transform.translate(
                offset: Offset(
                  _controller.value * widget.left * _xRatio,
                  _controller.value * widget.top * _yRatio,
                ),
                child: child,
              );
            } else if (widget.type == AnimationType.scale) {
              return Transform.scale(
                scale: _xRatio,
                child: child,
              );
            } else {
              return Opacity(
                opacity: _controller.value,
                child: child,
              );
            }
          },
          child: widget.child,
        ),
      ),
    );
  }
}
