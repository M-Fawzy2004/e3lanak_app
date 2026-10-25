enum AdStep3Notice {
  none,
  categoryRequired,
  generationStarted,
}

/// State representation for Step 3: Activity Category Selection.
class AdStep3State {
  final String? selectedCategoryId;
  final String customCategoryText;
  final bool isCustomActive;
  final bool isGenerating;
  final AdStep3Notice notice;

  const AdStep3State({
    this.selectedCategoryId,
    this.customCategoryText = '',
    this.isCustomActive = false,
    this.isGenerating = false,
    this.notice = AdStep3Notice.none,
  });

  bool get hasSelection =>
      (!isCustomActive && selectedCategoryId != null) ||
      (isCustomActive && customCategoryText.trim().isNotEmpty);

  AdStep3State copyWith({
    String? selectedCategoryId,
    bool clearSelectedCategory = false,
    String? customCategoryText,
    bool? isCustomActive,
    bool? isGenerating,
    AdStep3Notice? notice,
  }) {
    return AdStep3State(
      selectedCategoryId: clearSelectedCategory
          ? null
          : (selectedCategoryId ?? this.selectedCategoryId),
      customCategoryText: customCategoryText ?? this.customCategoryText,
      isCustomActive: isCustomActive ?? this.isCustomActive,
      isGenerating: isGenerating ?? this.isGenerating,
      notice: notice ?? this.notice,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdStep3State &&
          runtimeType == other.runtimeType &&
          selectedCategoryId == other.selectedCategoryId &&
          customCategoryText == other.customCategoryText &&
          isCustomActive == other.isCustomActive &&
          isGenerating == other.isGenerating &&
          notice == other.notice;

  @override
  int get hashCode =>
      selectedCategoryId.hashCode ^
      customCategoryText.hashCode ^
      isCustomActive.hashCode ^
      isGenerating.hashCode ^
      notice.hashCode;
}
