import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/image_model.dart';

class FirestoreDataSource {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'images';

  FirestoreDataSource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveImage(ImageModel image) async {
    await _firestore
        .collection(_collectionName)
        .doc(image.id)
        .set(image.toFirestore());
  }

  Stream<List<ImageModel>> getImagesStream() {
    return _firestore
        .collection(_collectionName)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ImageModel.fromFirestore(doc))
              .toList();
        });
  }

  Future<List<ImageModel>> getImages() async {
    final snapshot = await _firestore
        .collection(_collectionName)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => ImageModel.fromFirestore(doc)).toList();
  }
}
