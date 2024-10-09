import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idoctusapp/feat/auth/presentation/screens/login_screen.dart';

void main() {
  testWidgets('login screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LoginScreen())),
    );

    expect(find.text('Bienvenido a iDoctus'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('error contraseña vacía', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LoginScreen())),
    );

    final passwordField = find.byType(TextField);
    await tester.enterText(passwordField, '');
    await tester.tap(find.text('Iniciar Sesión'));
    await tester.pump();

    expect(find.text('El campo no puede estar vacío'), findsOneWidget);
  });
}
