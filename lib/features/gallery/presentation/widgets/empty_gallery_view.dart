import 'package:flutter/material.dart';

import '../../gallery_constants.dart';

class EmptyGalleryView extends StatelessWidget {
  const EmptyGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.primary.withOpacity(
              GalleryConstants.emptyIconOpacity,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            GalleryConstants.emptyStateTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            GalleryConstants.emptyStateSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(
                GalleryConstants.emptySubtitleOpacity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
