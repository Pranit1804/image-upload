import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  const ImageModel({
    required super.id,
    required super.url,
    required super.timestamp,
    required super.storagePath,
  });

  factory ImageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ImageModel(
      id: doc.id,
      url: data['url'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      storagePath: data['storagePath'] as String,
    );
  }

  factory ImageModel.fromEntity(ImageEntity entity) {
    return ImageModel(
      id: entity.id,
      url: entity.url,
      timestamp: entity.timestamp,
      storagePath: entity.storagePath,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'url': url,
      'timestamp': Timestamp.fromDate(timestamp),
      'storagePath': storagePath,
    };
  }

  ImageEntity toEntity() {
    return ImageEntity(
      id: id,
      url: url,
      timestamp: timestamp,
      storagePath: storagePath,
    );
  }
}
