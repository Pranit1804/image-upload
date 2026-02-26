import 'package:image_picker/image_picker.dart';

import '../entities/image_entity.dart';

abstract class GalleryRepository {
  Future<XFile?> pickImage();

  Future<String> uploadImage(
    XFile file,
    String fileName,
    Function(double progress) onProgress,
  );

  Future<void> saveImageMetadata(ImageEntity image);

  Stream<List<ImageEntity>> watchImages();
}
