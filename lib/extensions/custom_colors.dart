import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  // ADD MORE COLORS AS NEEDED
  const AppColors({
    this.color1,
  });

  final Color? color1;

  @override
  ThemeExtension<AppColors> copyWith({Color? color1}) {
    return AppColors(
      color1: color1 ?? this.color1,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      color1: Color.lerp(color1, other.color1, t),
    );
  }
}
