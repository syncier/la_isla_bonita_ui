// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:la_isla_Bonita_ui/main.dart';
import 'package:la_isla_Bonita_ui/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

import 'firebase_mock.dart';

@GenerateMocks([http.Client])
void main() async {
  setupFirebaseAuthMocks();
  await Firebase.initializeApp();
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App(
      newsRepository: NewsRepository(
        newsApiClient: NewsApiClient(
          httpClient: http.Client(),
        ),
      ),
    ));

    expect(true, true);
    expect(false, false);
  });
}
