import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ad_image.dart';
import '../repositories/ad_image_repository.dart';

/// Use case to capture a single photo from camera for the ad.
class CaptureAdPhotoUseCase {
  final AdImageRepository repository;

  const CaptureAdPhotoUseCase(this.repository);

  Future<Either<Failure, AdImage?>> call() {
    return repository.capturePhotoFromCamera();
  }
}
