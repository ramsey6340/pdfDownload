import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class DocSkeleton extends StatelessWidget {
  const DocSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonListView(
        scrollable: false,
        item: SkeletonListTile(
          contentSpacing: 12,
          verticalSpacing: 12,
          padding: const EdgeInsets.symmetric(vertical: 12),
          leadingStyle: SkeletonAvatarStyle(
              width: 64,
              height: 64,
              borderRadius: BorderRadius.circular(8)),
          titleStyle: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(4)),
          subtitleStyle: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(4),
              randomLength: true,
              minLength: MediaQuery.of(context).size.width / 3,
              maxLength: MediaQuery.of(context).size.width / 2),
          hasSubtitle: true,
        ));
  }
}