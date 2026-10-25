import 'package:flutter/widgets.dart';

/// Entity representing an activity/business category in Ad Generator.
class AdCategory {
  final String id;
  final String titleKey;
  final IconData icon;
  final String? imageUrl;
  final bool isCustom;

  const AdCategory({
    required this.id,
    required this.titleKey,
    required this.icon,
    this.imageUrl,
    this.isCustom = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
