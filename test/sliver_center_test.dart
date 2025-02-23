import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sliver_center/sliver_center.dart';

void main() {
  const testText = 'Test';
  const textKey = Key(testText);
  const testText2 = 'Test2';
  const textKey2 = Key(testText2);
  const screenSize = Size(1840, 1024);
  // Helper function to initialize the test environment
  Future<void> initTest({
    required WidgetTester tester,
    required Widget sliver,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: CustomScrollView(
              slivers: [sliver],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.binding.setSurfaceSize(screenSize);

    await tester.pumpAndSettle();
  }

  // Test to verify that the Text widget is not centered without SliverCenter
  testWidgets('Simple Test with text widget and Without SliverCenter',
      (tester) async {
    await initTest(
      tester: tester,
      sliver: SliverConstrainedCrossAxis(
        maxExtent: screenSize.width / 10,
        sliver: SliverToBoxAdapter(
          child: Text(
            testText,
            key: textKey,
          ),
        ),
      ),
    );

    expect(find.byKey(textKey), findsOneWidget);

    final center = tester.getCenter(find.byKey(textKey));

    // Verify that the Text widget is not centered
    expect(center.dx, isNot(screenSize.width / 2));
  });

  // Test to verify that the TextButton widget is centered with SliverCenter
  testWidgets('Simple Test with TextButton widget and with SliverCenter',
      (tester) async {
    String? text;
    final Key buttonKey = Key('test_button');
    await initTest(
      tester: tester,
      sliver: SliverCenter(
        sliver: SliverConstrainedCrossAxis(
          maxExtent: screenSize.width / 10,
          sliver: SliverToBoxAdapter(
            child: TextButton(
              key: buttonKey,
              onPressed: () => text = testText + (text ?? ''),
              child: Text(
                testText,
                key: textKey,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(textKey), findsOneWidget);
    expect(find.byKey(buttonKey), findsOneWidget);

    final center = tester.getCenter(find.byKey(textKey));

    // Verify that the Text widget is centered
    expect(center.dx, screenSize.width / 2);

    // Verify that the TextButton widget responds to taps
    expect(text, isNull);
    await tester.tap(find.byKey(buttonKey));
    await tester.pumpAndSettle();
    expect(text, testText);
    await tester.tap(find.byKey(buttonKey));
    await tester.pumpAndSettle();
    expect(text, testText + testText);
  });

  // Test to verify that the Text widget is centered with SliverCenter
  testWidgets('Simple Test with text widget and SliverCenter', (tester) async {
    await initTest(
      tester: tester,
      sliver: SliverCenter(
        sliver: SliverConstrainedCrossAxis(
          maxExtent: screenSize.width / 10,
          sliver: SliverToBoxAdapter(
            child: Text(
              testText,
              key: textKey,
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(textKey), findsOneWidget);

    final center = tester.getCenter(find.byKey(textKey));

    // Verify that the Text widget is centered
    expect(center.dx, screenSize.width / 2);
  });

  // Test to verify that the Text widget is centered with SliverCenter inside SliverConstrainedCrossAxis
  testWidgets(
      'Simple Test with text widget with SliverCenter after SliverConstrainedCrossAxis',
      (tester) async {
    await initTest(
      tester: tester,
      sliver: SliverConstrainedCrossAxis(
        maxExtent: screenSize.width / 10,
        sliver: SliverCenter(
          sliver: SliverToBoxAdapter(
            child: Text(
              testText,
              key: textKey,
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(textKey), findsOneWidget);

    final center = tester.getCenter(find.byKey(textKey));

    // Verify that the Text widget is centered
    expect(center.dx, screenSize.width / 2);
  });

  // Test to verify that the Text widgets are not centered without SliverCenter in SliverCrossAxisGroup
  testWidgets(
      'Test with SliverCrossAxisGroup and two text'
      ' widget without SliverCenter', (tester) async {
    await initTest(
      tester: tester,
      sliver: SliverCrossAxisGroup(
        slivers: [
          SliverCrossAxisExpanded(
            flex: 1,
            sliver: SliverConstrainedCrossAxis(
              maxExtent: screenSize.width / 10,
              sliver: SliverToBoxAdapter(
                child: Text(
                  testText,
                  key: textKey,
                ),
              ),
            ),
          ),
          SliverCrossAxisExpanded(
            flex: 1,
            sliver: SliverConstrainedCrossAxis(
              maxExtent: screenSize.width / 10,
              sliver: SliverToBoxAdapter(
                child: Text(
                  testText2,
                  key: textKey2,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    expect(find.byKey(textKey), findsOneWidget);
    expect(find.byKey(textKey2), findsOneWidget);

    final center = tester.getCenter(find.byKey(textKey));
    final center2 = tester.getCenter(find.byKey(textKey2));

    // Verify that the Text widgets are not centered
    expect(center.dx, isNot(screenSize.width / 4));
    expect(center2.dx, isNot(screenSize.width * 0.75));
  });

  // Test to verify that the Text widgets are centered with SliverCenter in SliverCrossAxisGroup
  testWidgets(
      'Test with SliverCrossAxisGroup and two text'
      ' widget with SliverCenter', (tester) async {
    await initTest(
      tester: tester,
      sliver: SliverCrossAxisGroup(
        slivers: [
          SliverCrossAxisExpanded(
            flex: 1,
            sliver: SliverCenter(
              sliver: SliverConstrainedCrossAxis(
                maxExtent: screenSize.width / 10,
                sliver: SliverToBoxAdapter(
                  child: Text(
                    testText,
                    key: textKey,
                  ),
                ),
              ),
            ),
          ),
          SliverCrossAxisExpanded(
            flex: 1,
            sliver: SliverCenter(
              sliver: SliverConstrainedCrossAxis(
                maxExtent: screenSize.width / 10,
                sliver: SliverToBoxAdapter(
                  child: Text(
                    testText2,
                    key: textKey2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    expect(find.byKey(textKey), findsOneWidget);
    expect(find.byKey(textKey2), findsOneWidget);

    final center = tester.getCenter(find.byKey(textKey));
    final center2 = tester.getCenter(find.byKey(textKey2));

    // Verify that the Text widgets are centered
    expect(center.dx, screenSize.width / 4);
    expect(center2.dx, screenSize.width * 0.75);
  });
}
