import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/image_entity.dart';
import 'providers.dart';

final imagesStreamProvider = StreamProvider<List<ImageEntity>>((ref) {
  final useCase = ref.watch(galleryUseCaseProvider);
  return useCase.getImages();
});

final uploadProgressProvider = StateProvider<double>((ref) => 0.0);

final isUploadingProvider = StateProvider<bool>((ref) => false);

final galleryControllerProvider = Provider((ref) {
  return GalleryController(ref);
});

class GalleryController {
  final Ref _ref;

  GalleryController(this._ref);

  Future<void> uploadImage() async {
    final useCase = _ref.read(galleryUseCaseProvider);

    try {
      _ref.read(isUploadingProvider.notifier).state = true;
      _ref.read(uploadProgressProvider.notifier).state = 0.0;

      await useCase.uploadImage(
        onProgress: (progress) {
          _ref.read(uploadProgressProvider.notifier).state = progress;
        },
      );
    } finally {
      _ref.read(uploadProgressProvider.notifier).state = 0.0;
      _ref.read(isUploadingProvider.notifier).state = false;
    }
  }
}
