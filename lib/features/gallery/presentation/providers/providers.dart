import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/datasources/firebase_storage_datasource.dart';
import '../../data/datasources/firestore_datasource.dart';
import '../../data/datasources/image_picker_datasource.dart';
import '../../data/repositories/gallery_repository_impl.dart';
import '../../domain/repositories/gallery_repository.dart';
import '../../domain/usecases/gallery_usecase.dart';

// ============================================
// Data Source Providers
// ============================================

final storageDataSourceProvider = Provider((ref) {
  return FirebaseStorageDataSource(storage: FirebaseStorage.instance);
});

final firestoreDataSourceProvider = Provider((ref) {
  return FirestoreDataSource(firestore: FirebaseFirestore.instance);
});

final imagePickerDataSourceProvider = Provider((ref) {
  return ImagePickerDataSource(imagePicker: ImagePicker());
});

// ============================================
// Repository Provider
// ============================================

final galleryRepositoryProvider = Provider<GalleryRepository>((ref) {
  return GalleryRepositoryImpl(
    storageDataSource: ref.watch(storageDataSourceProvider),
    firestoreDataSource: ref.watch(firestoreDataSourceProvider),
    imagePickerDataSource: ref.watch(imagePickerDataSourceProvider),
  );
});

// ============================================
// Use Case Provider
// ============================================

final galleryUseCaseProvider = Provider((ref) {
  return GalleryUseCase(repository: ref.watch(galleryRepositoryProvider));
});
