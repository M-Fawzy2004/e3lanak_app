import '../../domain/entities/ad_image.dart';

enum AdStep1Status { initial, loading, success, failure }

enum AdStep1Notice {
  none,
  maxImagesLimitReached,
  imagesAddedSuccessfully,
  photoCapturedSuccessfully,
  atLeastOneImageRequired,
  galleryFailed,
  cameraFailed,
  nextStepUnavailable,
  stepCompleted,
}

class AdStep1State {
  static const int maxImagesAllowed = 3;

  final List<AdImage> images;
  final AdStep1Status status;
  final AdStep1Notice notice;
  final String? errorMessage;

  const AdStep1State({
    this.images = const [],
    this.status = AdStep1Status.initial,
    this.notice = AdStep1Notice.none,
    this.errorMessage,
  });

  bool get isLoading => status == AdStep1Status.loading;
  bool get isMaxReached => images.length >= maxImagesAllowed;
  int get remainingSlots =>
      (maxImagesAllowed - images.length).clamp(0, maxImagesAllowed);
  AdImage? get primaryImage => images.isNotEmpty ? images.first : null;
  bool get canProceed => images.isNotEmpty;

  AdStep1State copyWith({
    List<AdImage>? images,
    AdStep1Status? status,
    AdStep1Notice? notice,
    String? errorMessage,
  }) {
    return AdStep1State(
      images: images ?? this.images,
      status: status ?? this.status,
      notice: notice ?? this.notice,
      errorMessage: errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdStep1State &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          notice == other.notice &&
          errorMessage == other.errorMessage &&
          _listEquals(images, other.images);

  @override
  int get hashCode =>
      images.hashCode ^
      status.hashCode ^
      notice.hashCode ^
      errorMessage.hashCode;

  static bool _listEquals(List<AdImage> a, List<AdImage> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
