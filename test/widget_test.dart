import 'package:flutter_test/flutter_test.dart';
import 'package:omran/main.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('Omran app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const OmranApp());

    expect(find.byType(OmranApp), findsOneWidget);
  });
}