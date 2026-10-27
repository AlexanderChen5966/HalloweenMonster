import 'package:flutter_test/flutter_test.dart';
import 'package:halloween_monster/main.dart';

void main() {
  testWidgets('shows monster list', (tester) async {
    await tester.pumpWidget(const HalloweenApp());
    expect(find.text('吸血鬼'), findsOneWidget);
  });
}
