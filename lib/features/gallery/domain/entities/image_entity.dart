class ImageEntity {
  final String id;
  final String url;
  final DateTime timestamp;
  final String storagePath;

  const ImageEntity({
    required this.id,
    required this.url,
    required this.timestamp,
    required this.storagePath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          url == other.url &&
          timestamp == other.timestamp &&
          storagePath == other.storagePath;

  @override
  int get hashCode =>
      id.hashCode ^ url.hashCode ^ timestamp.hashCode ^ storagePath.hashCode;

  @override
  String toString() {
    return 'ImageEntity{id: $id, url: $url, timestamp: $timestamp, storagePath: $storagePath}';
  }
}
