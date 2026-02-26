import 'package:cloud_firestore/cloud_firestore.dart';

import '../../gallery_constants.dart';
import '../models/image_model.dart';

class FirestoreDataSource {
  final FirebaseFirestore _firestore;

  FirestoreDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveImage(ImageModel image) async {
    await _firestore
        .collection(GalleryConstants.imagesCollection)
        .doc(image.id)
        .set(image.toFirestore());
  }

  Stream<List<ImageModel>> getImagesStream() {
    return _firestore
        .collection(GalleryConstants.imagesCollection)
        .orderBy(GalleryConstants.timestampField, descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ImageModel.fromFirestore(doc))
              .toList();
        });
  }

  Future<List<ImageModel>> getImages() async {
    final snapshot = await _firestore
        .collection(GalleryConstants.imagesCollection)
        .orderBy(GalleryConstants.timestampField, descending: true)
        .get();

    return snapshot.docs.map((doc) => ImageModel.fromFirestore(doc)).toList();
  }
}
