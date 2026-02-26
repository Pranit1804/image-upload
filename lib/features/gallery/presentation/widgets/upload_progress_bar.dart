import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../gallery_constants.dart';
import '../providers/gallery_providers.dart';

class UploadProgressBar extends ConsumerWidget {
  const UploadProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUploading = ref.watch(isUploadingProvider);
    final progress = ref.watch(uploadProgressProvider);

    if (!isUploading) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LinearProgressIndicator(
          value: progress > 0 ? progress : null,
          minHeight: GalleryConstants.uploadProgressBarHeight,
        ),
        if (progress > 0)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              '${GalleryConstants.uploadProgressPrefix}${(progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: GalleryConstants.uploadProgressTextSize,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
      ],
    );
  }
}
