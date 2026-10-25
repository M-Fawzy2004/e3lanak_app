import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ad_image.dart';
import '../repositories/ad_image_repository.dart';

/// Use case to pick multiple images from the gallery for the ad.
class PickAdImagesUseCase {
  final AdImageRepository repository;

  const PickAdImagesUseCase(this.repository);

  Future<Either<Failure, List<AdImage>>> call({required int maxImages}) {
    return repository.pickImagesFromGallery(maxImages: maxImages);
  }
}
