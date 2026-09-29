import 'package:flutter/material.dart';
import 'skeleton_box.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // Daily greeting
          SkeletonBox(
            width: 90,
            height: 14,
          ),
          const SizedBox(height: 8),

          SkeletonBox(
            width: 230,
            height: 32,
          ),
          const SizedBox(height: 8),

          SkeletonBox(
            width: 250,
            height: 20,
          ),

          const SizedBox(height: 24),

          // Portfolio progress
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(
                    width: 145,
                    height: 20,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      SkeletonBox(
                        width: 70,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      SkeletonBox(
                        width: 125,
                        height: 18,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  SkeletonBox(
                    width: double.infinity,
                    height: 10,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      SkeletonBox(
                        width: 115,
                        height: 16,
                      ),
                      const Spacer(),
                      SkeletonBox(
                        width: 125,
                        height: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Today's focus
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  SkeletonBox(
                    width: 48,
                    height: 48,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonBox(
                          width: 110,
                          height: 20,
                        ),
                        const SizedBox(height: 8),
                        SkeletonBox(
                          width: 210,
                          height: 16,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  SkeletonBox(
                    width: 24,
                    height: 24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Active projects
          Row(
            children: [
              SkeletonBox(
                width: 125,
                height: 24,
              ),
              const Spacer(),
              SkeletonBox(
                width: 65,
                height: 20,
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Project skeletons
          _ProjectSkeleton(),
          const SizedBox(height: 12),
          _ProjectSkeleton(),
          const SizedBox(height: 12),
          _ProjectSkeleton(),

          const SizedBox(height: 28),

          // Recent actions
          Row(
            children: [
              SkeletonBox(
                width: 125,
                height: 24,
              ),
              const Spacer(),
              SkeletonBox(
                width: 120,
                height: 20,
              ),
            ],
          ),

          const SizedBox(height: 12),

          const _RecentActionSkeleton(),
          const SizedBox(height: 10),
          const _RecentActionSkeleton(),
          const SizedBox(height: 10),
          const _RecentActionSkeleton(),
        ],
      ),
    );
  }
}

class _ProjectSkeleton extends StatelessWidget {
  const _ProjectSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  ),
                ),
                const SizedBox(width: 12),
                SkeletonBox(
                  width: 10,
                  height: 10,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                SkeletonBox(
                  width: 16,
                  height: 16,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(width: 6),
                SkeletonBox(
                  width: 100,
                  height: 16,
                ),
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
              children: [
                SkeletonBox(
                  width: 100,
                  height: 16,
                ),
                const Spacer(),
                SkeletonBox(
                  width: 70,
                  height: 14,
                ),
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
    );
  }
}

class _RecentActionSkeleton extends StatelessWidget {
  const _RecentActionSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          children: [
            SkeletonBox(
              width: 24,
              height: 24,
              borderRadius: BorderRadius.circular(4),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(
                    width: 190,
                    height: 18,
                  ),
                  const SizedBox(height: 8),
                  SkeletonBox(
                    width: 220,
                    height: 14,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            SkeletonBox(
              width: 10,
              height: 10,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
      ),
    );
  }
}