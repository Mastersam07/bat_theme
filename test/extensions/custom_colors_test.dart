import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaunta/extensions/custom_colors.dart';

void main() {
  group('$AppColors extensions', () {
    const Key containerKey = Key('container');

    testWidgets('can be obtained', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: const <ThemeExtension<dynamic>>[
              AppColors(color1: Colors.red)
            ],
          ),
          home: Container(key: containerKey),
        ),
      );

      final ThemeData theme = Theme.of(
        tester.element(find.byKey(containerKey)),
      );

      expect(theme.extension<AppColors>()!.color1, Colors.red);
    });

    testWidgets('can use copyWith', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: <ThemeExtension<dynamic>>{
              const AppColors(
                color1: Colors.black,
              ).copyWith(color1: Colors.blue),
            },
          ),
          home: Container(key: containerKey),
        ),
      );

      final ThemeData theme = Theme.of(
        tester.element(find.byKey(containerKey)),
      );

      expect(theme.extension<AppColors>()!.color1, Colors.blue);
    });

    testWidgets('can lerp', (WidgetTester tester) async {
      const AppColors extensionA1 = AppColors(color1: Colors.black);
      const AppColors extensionA2 = AppColors(color1: Colors.white);

      // Both ThemeData arguments include both extensions.
      ThemeData lerped = ThemeData.lerp(
        ThemeData(
          extensions: const <ThemeExtension<dynamic>>[
            extensionA1,
          ],
        ),
        ThemeData(
          extensions: const <ThemeExtension<dynamic>>{
            extensionA2,
          },
        ),
        0.5,
      );

      expect(lerped.extension<AppColors>()!.color1, const Color(0xff7f7f7f));

      // Missing from 2nd ThemeData
      lerped = ThemeData.lerp(
        ThemeData(
          extensions: const <ThemeExtension<dynamic>>{
            extensionA1,
          },
        ),
        ThemeData(
          extensions: const <ThemeExtension<dynamic>>{},
        ),
        0.5,
      );
      expect(lerped.extension<AppColors>()!.color1, Colors.black); // Not lerped
    });

    testWidgets('should return null on extension not found',
        (WidgetTester tester) async {
      final ThemeData theme = ThemeData(
        extensions: const <ThemeExtension<dynamic>>{},
      );

      expect(theme.extension<AppColors>(), isNull);
    });
  });
}
