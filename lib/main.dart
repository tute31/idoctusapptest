import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idoctusapp/feat/network_image/presentation/screen/network_image_screen.dart';

import 'feat/auth/presentation/screens/login_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iDoctus App',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/network_image': (context) => const NetworkImageScreen(),
      },
    );
  }
}
