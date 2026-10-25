import '../../domain/entities/ad_product_details.dart';

enum AdStep2Notice {
  none,
  validationError,
  stepCompleted,
}

/// State representation for Step 2: Commercial details & pricing.
class AdStep2State {
  static const int maxProductNameLength = 100;
  static const int maxBrandFeaturesLength = 500;

  final String productName;
  final String originalPrice;
  final String discountPrice;
  final String brandFeatures;
  final bool showValidationErrors;
  final AdStep2Notice notice;

  const AdStep2State({
    this.productName = '',
    this.originalPrice = '',
    this.discountPrice = '',
    this.brandFeatures = '',
    this.showValidationErrors = false,
    this.notice = AdStep2Notice.none,
  });

  double? get parsedOriginalPrice {
    final clean = originalPrice.trim().replaceAll(',', '.');
    return double.tryParse(clean);
  }

  double? get parsedDiscountPrice {
    final clean = discountPrice.trim().replaceAll(',', '.');
    return double.tryParse(clean);
  }

  /// Calculates dynamic savings percentage if discount is lower than original.
  int? get savingsPercentage {
    final orig = parsedOriginalPrice;
    final disc = parsedDiscountPrice;
    if (orig != null && orig > 0 && disc != null && disc > 0 && disc < orig) {
      return (((orig - disc) / orig) * 100).round();
    }
    return null;
  }

  bool get isProductNameValid => productName.trim().isNotEmpty;

  bool get isOriginalPriceValid {
    final orig = parsedOriginalPrice;
    return orig != null && orig > 0;
  }

  bool get isDiscountPriceValid {
    if (discountPrice.trim().isEmpty) return true;
    final disc = parsedDiscountPrice;
    final orig = parsedOriginalPrice;
    if (disc == null || disc <= 0) return false;
    if (orig != null && orig > 0 && disc >= orig) return false;
    return true;
  }

  bool get isValid =>
      isProductNameValid && isOriginalPriceValid && isDiscountPriceValid;

  AdProductDetails? get productDetails {
    if (!isValid) return null;
    return AdProductDetails(
      productName: productName.trim(),
      originalPrice: parsedOriginalPrice!,
      discountPrice: parsedDiscountPrice,
      brandFeatures:
          brandFeatures.trim().isNotEmpty ? brandFeatures.trim() : null,
    );
  }

  AdStep2State copyWith({
    String? productName,
    String? originalPrice,
    String? discountPrice,
    String? brandFeatures,
    bool? showValidationErrors,
    AdStep2Notice? notice,
  }) {
    return AdStep2State(
      productName: productName ?? this.productName,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      brandFeatures: brandFeatures ?? this.brandFeatures,
      showValidationErrors:
          showValidationErrors ?? this.showValidationErrors,
      notice: notice ?? this.notice,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdStep2State &&
          runtimeType == other.runtimeType &&
          productName == other.productName &&
          originalPrice == other.originalPrice &&
          discountPrice == other.discountPrice &&
          brandFeatures == other.brandFeatures &&
          showValidationErrors == other.showValidationErrors &&
          notice == other.notice;

  @override
  int get hashCode =>
      productName.hashCode ^
      originalPrice.hashCode ^
      discountPrice.hashCode ^
      brandFeatures.hashCode ^
      showValidationErrors.hashCode ^
      notice.hashCode;
}
