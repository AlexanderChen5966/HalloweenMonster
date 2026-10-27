import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:halloween_monster/main.dart';
import 'package:integration_test/integration_test.dart';

/// Drives the app for the demo video and takes the store screenshots.
/// MARK_START / MARK_END lines let CI trim the recording to the app only.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pause([int ms = 1200]) =>
      Future<void>.delayed(Duration(milliseconds: ms));

  Future<void> shot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    await binding.takeScreenshot(name);
  }

  Future<void> scrollList(WidgetTester tester, double dy) async {
    await tester.timedDrag(
        find.byType(CustomScrollView), Offset(0, dy), const Duration(milliseconds: 900));
    await tester.pumpAndSettle();
  }

  Future<void> openMonster(WidgetTester tester, String name, String shotName) async {
    await tester.ensureVisible(find.text(name).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(name).first);
    await tester.pumpAndSettle();
    await pause();
    await shot(tester, shotName);
    await scrollList(tester, -500);
    await pause(1500);
    await scrollList(tester, 500);
    await pause(600);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await pause(800);
  }

  testWidgets('demo tour', (tester) async {
    await tester.pumpWidget(const HalloweenApp());
    await tester.pumpAndSettle();
    if (Platform.isAndroid) {
      // Can only be called once per run; needed before takeScreenshot.
      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
    }
    // ignore: avoid_print
    print('READY ${DateTime.now().millisecondsSinceEpoch}');
    await pause(6000); // CI starts the screen recorder on READY
    // ignore: avoid_print
    print('MARK_START ${DateTime.now().millisecondsSinceEpoch}');

    await shot(tester, '1_home');
    await scrollList(tester, -600);
    await pause();
    await scrollList(tester, -600);
    await pause();
    await scrollList(tester, 1200);
    await pause();

    await openMonster(tester, '吸血鬼', '2_vampire');
    await openMonster(tester, '狼人', '3_werewolf');
    await openMonster(tester, '科學怪人', '4_frankenstein');
    await scrollList(tester, -500);
    await pause();
    await shot(tester, '5_list_more');
    await openMonster(tester, '女巫', '6_witch');

    await pause(1500);
    // ignore: avoid_print
    print('MARK_END ${DateTime.now().millisecondsSinceEpoch}');
    await pause(3000);
  });
}
