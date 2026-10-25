/// Domain entity representing the commercial product details and pricing entered in Step 2.
class AdProductDetails {
  final String productName;
  final double originalPrice;
  final double? discountPrice;
  final String? brandFeatures;

  const AdProductDetails({
    required this.productName,
    required this.originalPrice,
    this.discountPrice,
    this.brandFeatures,
  });

  /// Calculates dynamic savings percentage if a valid discount is present.
  int? get savingsPercentage {
    if (discountPrice != null &&
        discountPrice! > 0 &&
        discountPrice! < originalPrice &&
        originalPrice > 0) {
      return (((originalPrice - discountPrice!) / originalPrice) * 100).round();
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdProductDetails &&
          runtimeType == other.runtimeType &&
          productName == other.productName &&
          originalPrice == other.originalPrice &&
          discountPrice == other.discountPrice &&
          brandFeatures == other.brandFeatures;

  @override
  int get hashCode =>
      productName.hashCode ^
      originalPrice.hashCode ^
      discountPrice.hashCode ^
      brandFeatures.hashCode;

  @override
  String toString() =>
      'AdProductDetails(name: $productName, original: $originalPrice, discount: $discountPrice)';
}
