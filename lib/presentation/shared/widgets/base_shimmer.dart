import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmer extends StatelessWidget {
  final Widget content;
  const BaseShimmer({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      direction: ShimmerDirection.ltr,
      loop: 5,
      child: content,
    );
  }
}
