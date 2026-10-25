import 'package:flutter_bloc/flutter_bloc.dart';

import 'ad_step3_state.dart';

/// Cubit managing category selection and ad generation triggering for Step 3.
class AdStep3Cubit extends Cubit<AdStep3State> {
  AdStep3Cubit() : super(const AdStep3State(selectedCategoryId: 'clothing'));

  /// Selects a predefined category and deactivates custom text input mode.
  void selectCategory(String categoryId) {
    emit(state.copyWith(
      selectedCategoryId: categoryId,
      isCustomActive: false,
      notice: AdStep3Notice.none,
    ));
  }

  /// Activates the manual custom category entry mode.
  void activateCustomCategory() {
    emit(state.copyWith(
      clearSelectedCategory: true,
      isCustomActive: true,
      notice: AdStep3Notice.none,
    ));
  }

  /// Updates custom category text.
  void setCustomCategoryText(String text) {
    emit(state.copyWith(
      customCategoryText: text,
      isCustomActive: true,
      clearSelectedCategory: true,
      notice: AdStep3Notice.none,
    ));
  }

  /// Validates category choice and triggers AI generation.
  void generateAd() {
    if (!state.hasSelection) {
      emit(state.copyWith(
        notice: AdStep3Notice.categoryRequired,
      ));
      return;
    }

    emit(state.copyWith(
      isGenerating: true,
      notice: AdStep3Notice.generationStarted,
    ));
  }

  void clearNotice() {
    if (state.notice != AdStep3Notice.none) {
      emit(state.copyWith(notice: AdStep3Notice.none));
    }
  }
}
