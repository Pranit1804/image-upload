class GalleryConstants {
  const GalleryConstants._();

  static const appTitle = 'Image Gallery';

  static const imagesCollection = 'images';
  static const urlField = 'url';
  static const timestampField = 'timestamp';
  static const storagePathField = 'storagePath';
  static const storageImagesFolder = 'images';

  static const uploadInitialProgress = 0.0;
  static const uploadProgressBarHeight = 3.0;
  static const uploadProgressTextSize = 12.0;
  static const uploadProgressPrefix = 'Uploading... ';
  static const uploadImageTooltip = 'Upload Image';
  static const uploadSuccessMessage = 'Image uploaded successfully!';
  static const uploadFailedPrefix = 'Upload failed: ';

  static const emptyStateTitle = 'No images yet';
  static const emptyStateSubtitle =
      'Tap the + button to upload your first image';
  static const errorLoadingImagesTitle = 'Error loading images';
  static const retryLabel = 'Retry';
  static const unableToLoadImage = 'Unable to load image';

  static const justNow = 'Just now';
  static const minutesAgoSuffix = 'm ago';
  static const hoursAgoSuffix = 'h ago';

  static const previewMinScale = 1.0;
  static const previewMaxScale = 4.0;
  static const previewErrorHeight = 320.0;

  static const overlayOpacity = 0.7;
  static const emptyIconOpacity = 0.5;
  static const emptySubtitleOpacity = 0.6;

  static const mobileMaxWidth = 1920.0;
  static const mobileMaxHeight = 1920.0;
  static const mobileImageQuality = 85;

  static const defaultImageMimeType = 'image/jpeg';
  static const mimeTypeByExtension = <String, String>{
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'gif': 'image/gif',
    'webp': 'image/webp',
  };
}
