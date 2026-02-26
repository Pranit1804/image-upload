import 'package:image_picker/image_picker.dart';

import '../../domain/entities/image_entity.dart';
import '../../domain/repositories/gallery_repository.dart';
import '../datasources/firebase_storage_datasource.dart';
import '../datasources/firestore_datasource.dart';
import '../datasources/image_picker_datasource.dart';
import '../models/image_model.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final FirebaseStorageDataSource _storageDataSource;
  final FirestoreDataSource _firestoreDataSource;
  final ImagePickerDataSource _imagePickerDataSource;

  GalleryRepositoryImpl({
    required FirebaseStorageDataSource storageDataSource,
    required FirestoreDataSource firestoreDataSource,
    required ImagePickerDataSource imagePickerDataSource,
  }) : _storageDataSource = storageDataSource,
       _firestoreDataSource = firestoreDataSource,
       _imagePickerDataSource = imagePickerDataSource;

  @override
  Future<XFile?> pickImage() async {
    return await _imagePickerDataSource.pickImage();
  }

  @override
  Future<String> uploadImage(
    XFile file,
    String fileName,
    Function(double progress) onProgress,
  ) async {
    return await _storageDataSource.uploadFile(file, fileName, onProgress);
  }

  @override
  Future<void> saveImageMetadata(ImageEntity image) async {
    final imageModel = ImageModel.fromEntity(image);
    await _firestoreDataSource.saveImage(imageModel);
  }

  @override
  Stream<List<ImageEntity>> watchImages() {
    return _firestoreDataSource.getImagesStream().map((models) {
      return models.map((model) => model.toEntity()).toList();
    });
  }
}
