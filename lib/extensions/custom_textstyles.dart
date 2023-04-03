import 'package:flutter/material.dart';

@immutable
class AppStyles extends ThemeExtension<AppStyles> {
  // ADD MORE TEXTSTYLES AS NEEDED
  final TextStyle? body;

  const AppStyles({
    required this.body,
  });

  @override
  ThemeExtension<AppStyles> copyWith() {
    return AppStyles(
      body: body,
    );
  }

  @override
  ThemeExtension<AppStyles> lerp(
      covariant ThemeExtension<AppStyles>? other, double t) {
    if (other is! AppStyles) {
      return this;
    }
    return AppStyles(
      body: TextStyle.lerp(body, other.body, t)!,
    );
  }
}
