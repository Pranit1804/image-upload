import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDataSource {
  final ImagePicker _imagePicker;

  ImagePickerDataSource({ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker();

  Future<XFile?> pickImage() async {
    if (kIsWeb) {
      return _pickImageWeb();
    } else {
      return _pickImageMobile();
    }
  }

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
      debugPrint('Error picking image on mobile: $e');
      return null;
    }
  }

  Future<XFile?> _pickImageWeb() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
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
