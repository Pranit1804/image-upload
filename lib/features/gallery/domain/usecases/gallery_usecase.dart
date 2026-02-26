import 'package:uuid/uuid.dart';

import '../../gallery_constants.dart';
import '../entities/image_entity.dart';
import '../repositories/gallery_repository.dart';

class GalleryUseCase {
  final GalleryRepository _repository;
  final Uuid _uuid;

  GalleryUseCase({required GalleryRepository repository, Uuid? uuid})
    : _repository = repository,
      _uuid = uuid ?? const Uuid();

  Future<ImageEntity?> uploadImage({
    required Function(double progress) onProgress,
  }) async {
    final pickedFile = await _repository.pickImage();

    if (pickedFile == null) {
      return null;
    }

    final fileExtension = pickedFile.name.split('.').last;
    final fileName = '${_uuid.v4()}.$fileExtension';
    final storagePath = '${GalleryConstants.storageImagesFolder}/$fileName';

    final downloadUrl = await _repository.uploadImage(
      pickedFile,
      storagePath,
      onProgress,
    );

    final imageEntity = ImageEntity(
      id: _uuid.v4(),
      url: downloadUrl,
      timestamp: DateTime.now(),
      storagePath: storagePath,
    );

    await _repository.saveImageMetadata(imageEntity);

    return imageEntity;
  }

  Stream<List<ImageEntity>> getImages() {
    return _repository.watchImages();
  }
}
