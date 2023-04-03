import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaunta/extensions/custom_textstyles.dart';

void main() {
  group('$AppStyles extensions', () {
    const Key containerKey = Key('container');

    testWidgets('can be obtained', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: const <ThemeExtension<dynamic>>[
              AppStyles(
                  body: TextStyle(
                fontFamily: 'Marianne',
                fontSize: 17.0,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ))
            ],
          ),
          home: Container(key: containerKey),
        ),
      );

      final ThemeData theme = Theme.of(
        tester.element(find.byKey(containerKey)),
      );

      expect(theme.extension<AppStyles>()!.body?.fontFamily, 'Marianne');
    });

    testWidgets('can use copyWith', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: <ThemeExtension<dynamic>>{
              const AppStyles(
                  body: TextStyle(
                fontFamily: 'Marianne',
                fontSize: 17.0,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              )).copyWith(),
            },
          ),
          home: Container(key: containerKey),
        ),
      );

      final ThemeData theme = Theme.of(
        tester.element(find.byKey(containerKey)),
      );

      expect(theme.extension<AppStyles>()!.body?.fontFamily, 'Marianne');
    });

    testWidgets('can lerp', (WidgetTester tester) async {
      AppStyles extensionA1 = const AppStyles(body: TextStyle(fontSize: 50));
      AppStyles extensionA2 = const AppStyles(body: TextStyle(fontSize: 100));

      // Both ThemeData arguments include both extensions.
      ThemeData lerped = ThemeData.lerp(
        ThemeData(
          extensions: <ThemeExtension<dynamic>>[
            extensionA1,
          ],
        ),
        ThemeData(
          extensions: <ThemeExtension<dynamic>>{
            extensionA2,
          },
        ),
        0.5,
      );

      expect(lerped.extension<AppStyles>()!.body?.fontSize, 75);

      // Missing from 2nd ThemeData
      lerped = ThemeData.lerp(
        ThemeData(
          extensions: <ThemeExtension<dynamic>>{
            extensionA1,
          },
        ),
        ThemeData(
          extensions: const <ThemeExtension<dynamic>>{},
        ),
        0.5,
      );
      expect(lerped.extension<AppStyles>()!.body?.fontSize, 50); // Not lerped
    });

    testWidgets('should return null on extension not found',
        (WidgetTester tester) async {
      final ThemeData theme = ThemeData(
        extensions: const <ThemeExtension<dynamic>>{},
      );

      expect(theme.extension<AppStyles>(), isNull);
    });
  });
}
