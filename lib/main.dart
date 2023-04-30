import 'package:flutter/material.dart';
import 'package:tasker/modules/_home_screen.dart';

import 'core/ui/custom_theme.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:CustomTheme.theme(),
      home: const HomeScreen(),
    );
  }
}
