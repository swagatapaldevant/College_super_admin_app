import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AnimatedListView extends StatefulWidget {
  // Required parameters
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  // Animation parameters
  final double horizontalOffset;
  final double verticalOffset;
  final Duration duration;
  final Curve curve;
  final double staggerFraction;

  // ListView parameters
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool reverse;
  final Axis scrollDirection;
  final bool? primary;
  final ScrollController? controller;
  final bool? shrinkWrap;
  final double? itemExtent;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final ScrollBehavior? scrollBehavior;

  const AnimatedListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,

    // Animation defaults
    this.horizontalOffset = 100.0,
    this.verticalOffset = 0.0,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuart,
    this.staggerFraction = 0.1,

    // ListView defaults
    this.physics,
    this.padding,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.primary,
    this.controller,
    this.shrinkWrap,
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.scrollBehavior,
  }) : super(key: key);

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: widget.scrollBehavior ?? ScrollConfiguration.of(context),
      child: ListView.builder(
        // ListView properties
        physics: widget.physics ?? const BouncingScrollPhysics(),
        padding: widget.padding,
        itemCount: widget.itemCount,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        primary: widget.primary,
        controller: widget.controller,
        shrinkWrap: widget.shrinkWrap ?? false,
        itemExtent: widget.itemExtent,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        cacheExtent: widget.cacheExtent,
        semanticChildCount: widget.semanticChildCount,
        dragStartBehavior: widget.dragStartBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        restorationId: widget.restorationId,
        clipBehavior: widget.clipBehavior,

        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final animation = CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  widget.staggerFraction * index,
                  1.0,
                  curve: widget.curve,
                ),
              );

              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(
                    widget.horizontalOffset * (widget.reverse ? -1 : 1),
                    widget.verticalOffset,
                  ),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: widget.itemBuilder(context, index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}