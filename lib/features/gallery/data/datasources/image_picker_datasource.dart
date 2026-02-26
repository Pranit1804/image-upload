import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

/// Data source for image picking operations.
/// Handles platform-specific image picking (mobile vs web).
class ImagePickerDataSource {
  final ImagePicker _imagePicker;

  ImagePickerDataSource({ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker();

  /// Pick an image from gallery (mobile) or file picker (web)
  /// Returns null if user cancels
  Future<XFile?> pickImage() async {
    if (kIsWeb) {
      // Web: use FilePicker
      return _pickImageWeb();
    } else {
      // Mobile: use ImagePicker
      return _pickImageMobile();
    }
  }

  /// Pick image on mobile platforms using ImagePicker
  Future<XFile?> _pickImageMobile() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      // Handle permission denied or other errors
      debugPrint('Error picking image on mobile: $e');
      return null;
    }
  }

  /// Pick image on web using FilePicker
  Future<XFile?> _pickImageWeb() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true, // Important for web - loads bytes into memory
      );

      if (result != null && result.files.single.bytes != null) {
        final file = result.files.single;
        return XFile.fromData(
          file.bytes!,
          name: file.name,
          mimeType: _getMimeType(file.name),
        );
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image on web: $e');
      return null;
    }
  }

  /// Get MIME type from file extension
  String _getMimeType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }
}
