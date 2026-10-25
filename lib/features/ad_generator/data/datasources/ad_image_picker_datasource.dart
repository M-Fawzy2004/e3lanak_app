import 'package:image_picker/image_picker.dart';

import '../models/ad_image_model.dart';

/// Data source interface for device image picking.
abstract class AdImagePickerDataSource {
  Future<List<AdImageModel>> pickMultiImage({required int limit});
  Future<AdImageModel?> pickCameraImage();
}

/// Concrete implementation wrapping the [ImagePicker] plugin.
class AdImagePickerDataSourceImpl implements AdImagePickerDataSource {
  final ImagePicker _picker;

  AdImagePickerDataSourceImpl({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  @override
  Future<List<AdImageModel>> pickMultiImage({required int limit}) async {
    final pickedFiles = await _picker.pickMultiImage(limit: limit);
    return pickedFiles.map(AdImageModel.fromXFile).toList();
  }

  @override
  Future<AdImageModel?> pickCameraImage() async {
    final photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (photo == null) return null;
    return AdImageModel.fromXFile(photo);
  }
}
