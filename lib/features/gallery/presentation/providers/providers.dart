import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../firebase_options.dart';

import '../../data/datasources/firebase_storage_datasource.dart';
import '../../data/datasources/firestore_datasource.dart';
import '../../data/datasources/image_picker_datasource.dart';
import '../../data/repositories/gallery_repository_impl.dart';
import '../../domain/repositories/gallery_repository.dart';
import '../../domain/usecases/gallery_usecase.dart';

final storageDataSourceProvider = Provider((ref) {
  final configuredBucket = DefaultFirebaseOptions.currentPlatform.storageBucket;
  final bucket = _toGsBucketUri(configuredBucket);

  final storage = bucket == null
      ? FirebaseStorage.instance
      : FirebaseStorage.instanceFor(bucket: bucket);

  return FirebaseStorageDataSource(storage: storage);
});

final firestoreDataSourceProvider = Provider((ref) {
  return FirestoreDataSource(firestore: FirebaseFirestore.instance);
});

final imagePickerDataSourceProvider = Provider((ref) {
  return ImagePickerDataSource(imagePicker: ImagePicker());
});

final galleryRepositoryProvider = Provider<GalleryRepository>((ref) {
  return GalleryRepositoryImpl(
    storageDataSource: ref.watch(storageDataSourceProvider),
    firestoreDataSource: ref.watch(firestoreDataSourceProvider),
    imagePickerDataSource: ref.watch(imagePickerDataSourceProvider),
  );
});

final galleryUseCaseProvider = Provider((ref) {
  return GalleryUseCase(repository: ref.watch(galleryRepositoryProvider));
});

String? _toGsBucketUri(String? bucket) {
  if (bucket == null || bucket.isEmpty) {
    return null;
  }

  if (bucket.startsWith('gs://')) {
    return bucket;
  }

  return 'gs://$bucket';
}
