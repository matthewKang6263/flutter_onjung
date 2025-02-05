import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_onjung/ui/pages/welcome/welcome_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp())); // Riverpod 적용
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '온정 앱',
      theme: ThemeData(
        fontFamily: 'NotoSansKR', // 여기에 추가
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'NotoSansKR'),
          bodyMedium: TextStyle(fontFamily: 'NotoSansKR'),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}
