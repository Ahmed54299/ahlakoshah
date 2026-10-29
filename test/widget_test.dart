import 'package:flutter_test/flutter_test.dart';
import 'package:best_kosha/main.dart';

void main() {
  testWidgets('تظهر الأزرار', (tester) async {
    await tester.pumpWidget(const KoshaApp());
    expect(find.text('انستقرام'), findsOneWidget);
  });
}