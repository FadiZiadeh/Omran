
import 'package:flutter_test/flutter_test.dart';
import 'package:omran/main.dart';

void main() {
testWidgets('Omran app loads successfully', (WidgetTester tester) async {
await tester.pumpWidget(const OmranApp());

expect(find.byType(OmranApp), findsOneWidget);
});
}

