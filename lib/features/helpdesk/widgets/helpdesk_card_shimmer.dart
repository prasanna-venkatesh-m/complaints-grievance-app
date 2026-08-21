import 'package:app_shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

class HelpdeskCardShimmer extends StatelessWidget {
  const HelpdeskCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmerContainer(
      skeletonContainerStyle: const ShimmerContainerStyle(
        width: double.infinity,
        height: 200,
        borderRadiusDouble: 16,
      ),
    );
  }
}