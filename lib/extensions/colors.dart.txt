import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  //
  const AppColors({
    required this.success,
    required this.failure,
  });

  final Color? success;
  final Color? failure;

  @override
  ThemeExtension<AppColors> copyWith({Color? success, Color? failure}) {
    return AppColors(
      success: success ?? this.success,
      failure: failure ?? this.failure,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      success: Color.lerp(success, other.success, t),
      failure: Color.lerp(failure, other.failure, t),
    );
  }

  @override
  String toString() {
    return 'MyColors(success: $success, failure: $failure)';
  }

  static const light = AppColors(
    success: Color(0xFF28A745),
    failure: Color.fromARGB(255, 128, 7, 35),
  );

  static const dark = AppColors(
    success: Color.fromARGB(255, 226, 234, 8),
    failure: Color.fromARGB(255, 205, 127, 18),
  );
}
