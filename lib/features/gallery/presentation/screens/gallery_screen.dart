import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../gallery_constants.dart';
import '../providers/gallery_providers.dart';
import '../widgets/empty_gallery_view.dart';
import '../widgets/image_grid.dart';
import '../widgets/upload_progress_bar.dart';

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesAsync = ref.watch(imagesStreamProvider);
    final isUploading = ref.watch(isUploadingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(GalleryConstants.appTitle)),
      body: Column(
        children: [
          const UploadProgressBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(imagesStreamProvider);
              },
              child: imagesAsync.when(
                data: (images) {
                  if (images.isEmpty) {
                    return const EmptyGalleryView();
                  }
                  return ImageGrid(images: images);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        GalleryConstants.errorLoadingImagesTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () {
                          ref.invalidate(imagesStreamProvider);
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text(GalleryConstants.retryLabel),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isUploading ? null : () => _handleUpload(context, ref),
        tooltip: GalleryConstants.uploadImageTooltip,
        child: isUploading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.add_photo_alternate_outlined),
      ),
    );
  }

  void _handleUpload(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(galleryControllerProvider).uploadImage();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(GalleryConstants.uploadSuccessMessage),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${GalleryConstants.uploadFailedPrefix}$e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
