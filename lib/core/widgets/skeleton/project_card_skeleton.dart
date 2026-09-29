import 'package:flutter/material.dart';
import 'skeleton_box.dart';

class ProjectCardSkeleton extends StatelessWidget {
  final double width;

  const ProjectCardSkeleton({super.key, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SkeletonBox(
                      height: 20,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),

                  const SizedBox(width: 8),

                  SkeletonBox(
                    width: 10,
                    height: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  SkeletonBox(
                    width: 16,
                    height: 16,
                    borderRadius: BorderRadius.circular(6),
                  ),

                  const SizedBox(width: 4),

                  Expanded(child: SkeletonBox(height: 16)),
                ],
              ),

              const SizedBox(height: 18),

              SkeletonBox(
                width: 75,
                height: 28,
                borderRadius: BorderRadius.circular(20),
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SkeletonBox(width: 100, height: 16),
                  SkeletonBox(width: 70, height: 14),
                ],
              ),

              const SizedBox(height: 8),

              SkeletonBox(
                width: double.infinity,
                height: 7,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
