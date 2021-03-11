import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progress_bars/circle_progress_painter.dart';

class CircleProgressBar extends StatefulWidget {
  /// [progressColor] represents the Color of the arc progressing .
  /// @Default is [Colors.green[600]]
  final Color progressColor;

  /// [backgroundColor] represents the background of arc progressing .
  /// @Default is [Colors.grey[200]]
  final Color backgroundColor;

  /// [child] represents the widget appearing in the center of progress bar .
  final Widget child;

  /// [size] represents the radius of the progress bar
  /// @Default is 40
  final double size;

  /// [arcWidth] represents the sectorLength of arc
  /// @Default is 50
  final double arcWidth;

  CircleProgressBar({
    this.progressColor,
    this.backgroundColor,
    this.child,
    this.size: 40,
    this.arcWidth: 50,
  });

  @override
  _CircleProgressBar createState() => _CircleProgressBar();
}

class _CircleProgressBar extends State<CircleProgressBar>
    with TickerProviderStateMixin {
  /// [leftAnimation] defines arc movement towards left to bottom .
  Animation<double> leftAnimation;

  /// [rightAnimation] defines arc movement towards right to bottom .
  Animation<double> rightAnimation;

  /// [combinedAnimation] defines combined arc movements in various directions .
  Animation<double> combinedAnimation;

  /// [lrController] controller which controls [leftAnimation] & [rightAnimation] .
  AnimationController lrController;

  /// [combinedController] controller for [combinedController] .
  AnimationController combinedController;

  double height, width, leftProgress, rightProgress, combinedProgress;
  bool combined = true;

  @override
  void initState() {
    super.initState();
    height = width = 2 * widget.size;
    super.initState();
    startSequence();
  }

  @override
  void dispose() {
    lrController.dispose();
    combinedController.dispose();
    super.dispose();
  }

  startSequence() {
    lrController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    combinedController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    createSequence();

    leftAnimation
        .addListener(() => setState(() => leftProgress = leftAnimation.value));
    rightAnimation.addListener(
        () => setState(() => rightProgress = rightAnimation.value));
    combinedAnimation.addListener(
        () => setState(() => combinedProgress = combinedAnimation.value));

    combinedController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        combined = false;
        lrController.forward().whenComplete(() {
          combined = true;
          lrController.reset();
        });
        Future.delayed(Duration(milliseconds: 1000), () {
          combinedController.forward(from: 0.0);
        });
      }
    });

    combinedController.forward();
  }

  createSequence() {
    leftAnimation = Tween<double>(begin: 270, end: (90 + widget.arcWidth / 2))
        .animate(lrController);

    leftProgress = leftAnimation.value;

    rightAnimation = Tween<double>(begin: 270, end: (450 - widget.arcWidth / 2))
        .animate(lrController);

    rightProgress = leftAnimation.value;

    combinedAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(
            begin: (90 + widget.arcWidth / 2),
            end: (180 + widget.arcWidth / 2)),
        weight: 5,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
            begin: (180 + widget.arcWidth / 2), end: (widget.arcWidth / 2)),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
            begin: (widget.arcWidth / 2), end: (270 + widget.arcWidth / 2)),
        weight: 20,
      ),
    ]).animate(combinedController);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        foregroundPainter: CircleProgressPainter(
          backgroundColor: this.widget.backgroundColor,
          progressColor: this.widget.progressColor,
          height: height,
          width: width,
          leftProgress: leftProgress,
          rightProgress: rightProgress,
          combined: combined,
          combinedProgress: combinedProgress,
          arcWidth: widget.arcWidth,
        ),
        child: Container(
          height: height,
          width: width,
          child: Container(
              height: height / 2,
              width: width / 2,
              child: Center(child: widget.child)),
        ),
      ),
    );
  }
}
