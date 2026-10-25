import 'package:image_picker/image_picker.dart';

import '../../domain/entities/ad_image.dart';

/// Data Model for [AdImage], wrapping [XFile] properties from ImagePicker.
class AdImageModel extends AdImage {
  const AdImageModel({
    required super.path,
    super.name,
  });

  factory AdImageModel.fromXFile(XFile file) {
    return AdImageModel(
      path: file.path,
      name: file.name,
    );
  }
}
