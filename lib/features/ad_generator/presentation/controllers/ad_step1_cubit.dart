import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/ad_image.dart';
import '../../domain/usecases/capture_ad_photo_usecase.dart';
import '../../domain/usecases/pick_ad_images_usecase.dart';
import 'ad_step1_state.dart';

/// Presentation Cubit managing state for Step 1 of the Ad Creation Flow.
class AdStep1Cubit extends Cubit<AdStep1State> {
  final PickAdImagesUseCase _pickAdImagesUseCase;
  final CaptureAdPhotoUseCase _captureAdPhotoUseCase;

  AdStep1Cubit({
    required PickAdImagesUseCase pickImagesUseCase,
    required CaptureAdPhotoUseCase capturePhotoUseCase,
  })  : _pickAdImagesUseCase = pickImagesUseCase,
        _captureAdPhotoUseCase = capturePhotoUseCase,
        super(const AdStep1State());

  /// Picks images from gallery up to remaining allowed slots.
  Future<void> pickFromGallery() async {
    if (state.isLoading) return;

    if (state.isMaxReached) {
      emit(state.copyWith(
        notice: AdStep1Notice.maxImagesLimitReached,
      ));
      return;
    }

    emit(state.copyWith(
      status: AdStep1Status.loading,
      notice: AdStep1Notice.none,
    ));

    final slotsAvailable = state.remainingSlots;
    final result = await _pickAdImagesUseCase(maxImages: slotsAvailable);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AdStep1Status.failure,
          notice: AdStep1Notice.galleryFailed,
          errorMessage: failure.message,
        ));
      },
      (pickedImages) {
        if (pickedImages.isEmpty) {
          emit(state.copyWith(
            status: AdStep1Status.initial,
            notice: AdStep1Notice.none,
          ));
          return;
        }

        final updatedList = List<AdImage>.from(state.images)
          ..addAll(pickedImages.take(slotsAvailable));

        emit(state.copyWith(
          images: updatedList,
          status: AdStep1Status.success,
          notice: AdStep1Notice.imagesAddedSuccessfully,
        ));
      },
    );
  }

  /// Captures a single photo from camera.
  Future<void> capturePhoto() async {
    if (state.isLoading) return;

    if (state.isMaxReached) {
      emit(state.copyWith(
        notice: AdStep1Notice.maxImagesLimitReached,
      ));
      return;
    }

    emit(state.copyWith(
      status: AdStep1Status.loading,
      notice: AdStep1Notice.none,
    ));

    final result = await _captureAdPhotoUseCase();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: AdStep1Status.failure,
          notice: AdStep1Notice.cameraFailed,
          errorMessage: failure.message,
        ));
      },
      (capturedPhoto) {
        if (capturedPhoto == null) {
          emit(state.copyWith(
            status: AdStep1Status.initial,
            notice: AdStep1Notice.none,
          ));
          return;
        }

        final updatedList = List<AdImage>.from(state.images)
          ..add(capturedPhoto);

        emit(state.copyWith(
          images: updatedList,
          status: AdStep1Status.success,
          notice: AdStep1Notice.photoCapturedSuccessfully,
        ));
      },
    );
  }

  /// Removes an image by index.
  void removeImage(int index) {
    if (state.isLoading || index < 0 || index >= state.images.length) return;

    final updatedList = List<AdImage>.from(state.images)..removeAt(index);
    emit(state.copyWith(
      images: updatedList,
      status: AdStep1Status.initial,
      notice: AdStep1Notice.none,
    ));
  }

  /// Validates requirement (at least 1 image) to advance to next step.
  void validateAndProceed() {
    if (state.isLoading) return;

    if (state.images.isEmpty) {
      emit(state.copyWith(
        notice: AdStep1Notice.atLeastOneImageRequired,
      ));
      return;
    }

    emit(state.copyWith(
      notice: AdStep1Notice.nextStepUnavailable,
    ));
  }

  /// Clears active one-shot notice after presentation listener handles it.
  void clearNotice() {
    if (state.notice != AdStep1Notice.none) {
      emit(state.copyWith(notice: AdStep1Notice.none));
    }
  }
}
