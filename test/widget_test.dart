import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:founder_os/main.dart';
import 'package:founder_os/state/founder_os_controller.dart';

void main() {
  testWidgets('renders founder OS dashboard', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final controller = await FounderOsController.load(enableRemoteSync: false);

    await tester.pumpWidget(
      FounderOsApp(controller: controller, requireAuth: false),
    );
    await tester.pumpAndSettle();

    expect(find.text('PROJECT_IDENTIFIER'), findsOneWidget);
    expect(find.text('LunarWise'), findsWidgets);
    expect(find.text('VIEW_CHANGELOG'), findsOneWidget);
  });
}
