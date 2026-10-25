import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/ad_image.dart';
import '../../domain/repositories/ad_image_repository.dart';
import '../datasources/ad_image_picker_datasource.dart';

/// Failure occurring when media picking fails due to platform or device errors.
class MediaDeviceFailure extends Failure {
  const MediaDeviceFailure({required super.message, super.statusCode});
}

/// Concrete implementation of [AdImageRepository].
class AdImageRepositoryImpl implements AdImageRepository {
  final AdImagePickerDataSource dataSource;

  const AdImageRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<AdImage>>> pickImagesFromGallery({
    required int maxImages,
  }) async {
    try {
      final models = await dataSource.pickMultiImage(limit: maxImages);
      return Right(models);
    } catch (e) {
      return Left(MediaDeviceFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AdImage?>> capturePhotoFromCamera() async {
    try {
      final model = await dataSource.pickCameraImage();
      return Right(model);
    } catch (e) {
      return Left(MediaDeviceFailure(message: e.toString()));
    }
  }
}
