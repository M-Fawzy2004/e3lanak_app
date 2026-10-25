import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ad_image.dart';

/// Contract for media image picking in the Ad Generator domain.
abstract class AdImageRepository {
  /// Picks multiple images from user's gallery up to [maxImages].
  Future<Either<Failure, List<AdImage>>> pickImagesFromGallery({
    required int maxImages,
  });

  /// Captures a single image from the device camera.
  Future<Either<Failure, AdImage?>> capturePhotoFromCamera();
}
