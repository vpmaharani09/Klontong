import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final double? height;
  final bool expand;
  final EdgeInsets? padding;

  const ExpandedSection({
    Key? key,
    this.expand = false,
    required this.child,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  AnimationController? expandController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    animation = CurvedAnimation(
      parent: expandController!,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController?.forward();
    } else {
      expandController?.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation!,
      child: Container(
        padding: widget.padding ?? EdgeInsets.only(bottom: 5.w),
        constraints: BoxConstraints(
          //minHeight: 100,
          minWidth: double.infinity,
          maxHeight: widget.height == null
              ? double.infinity
              : widget.height!,
        ),
        child: widget.child,
      ),
    );
  }
}
