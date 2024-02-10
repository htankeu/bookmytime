import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookmytime/widgets/input_field.dart';

void main() {
  testWidgets('InputField widget test', (WidgetTester tester) async {
    // Initialize TextEditingController
    final TextEditingController controller = TextEditingController();

    // Build InputField widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputField(
            hinText: 'Enter text',
            textController: controller,
          ),
        ),
      ),
    );

    // Verify if InputField is rendered
    expect(find.byType(InputField), findsOneWidget);

    // Verify if the hintText is displayed
    expect(find.text('Enter text'), findsOneWidget);

    // Enter text into TextFormField
    await tester.enterText(find.byType(TextFormField), 'Test text');
    await tester.pump();

    // Verify if the entered text is displayed
    expect(find.text('Test text'), findsOneWidget);

    // Verify if the controller contains the entered text
    expect(controller.text, 'Test text');
  });
}
