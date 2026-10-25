import 'package:flutter_bloc/flutter_bloc.dart';

import 'ad_step2_state.dart';

/// Cubit managing commercial product details & pricing form logic for Step 2.
class AdStep2Cubit extends Cubit<AdStep2State> {
  AdStep2Cubit() : super(const AdStep2State());

  void setProductName(String value) {
    emit(state.copyWith(
      productName: value,
      notice: AdStep2Notice.none,
    ));
  }

  void setOriginalPrice(String value) {
    emit(state.copyWith(
      originalPrice: value,
      notice: AdStep2Notice.none,
    ));
  }

  void setDiscountPrice(String value) {
    emit(state.copyWith(
      discountPrice: value,
      notice: AdStep2Notice.none,
    ));
  }

  void setBrandFeatures(String value) {
    emit(state.copyWith(
      brandFeatures: value,
      notice: AdStep2Notice.none,
    ));
  }

  /// Validates all mandatory inputs and submits step 2.
  void validateAndProceed() {
    if (!state.isValid) {
      emit(state.copyWith(
        showValidationErrors: true,
        notice: AdStep2Notice.validationError,
      ));
      return;
    }

    emit(state.copyWith(
      showValidationErrors: false,
      notice: AdStep2Notice.stepCompleted,
    ));
  }

  void clearNotice() {
    if (state.notice != AdStep2Notice.none) {
      emit(state.copyWith(notice: AdStep2Notice.none));
    }
  }
}
