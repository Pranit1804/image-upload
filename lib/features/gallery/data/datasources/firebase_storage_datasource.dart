import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../gallery_constants.dart';

class FirebaseStorageDataSource {
  final FirebaseStorage _storage;

  FirebaseStorageDataSource({FirebaseStorage? storage})
    : _storage = storage ?? FirebaseStorage.instance;

  Future<String> uploadFile(
    XFile file,
    String path,
    Function(double progress) onProgress,
  ) async {
    final ref = _storage.ref().child(path);

    UploadTask uploadTask;

    if (kIsWeb) {
      final bytes = await file.readAsBytes();
      uploadTask = ref.putData(
        bytes,
        SettableMetadata(contentType: _getContentType(file.name)),
      );
    } else {
      final fileToUpload = File(file.path);
      uploadTask = ref.putFile(
        fileToUpload,
        SettableMetadata(contentType: _getContentType(file.name)),
      );
    }

    final progressSubscription = uploadTask.snapshotEvents.listen(
      (TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress(progress);
      },
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('[Storage][Upload][ProgressError] $error');
      },
    );

    try {
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      rethrow;
    } finally {
      await progressSubscription.cancel();
    }
  }

  String _getContentType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    return GalleryConstants.mimeTypeByExtension[extension] ??
        GalleryConstants.defaultImageMimeType;
  }
}
