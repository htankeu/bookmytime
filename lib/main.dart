import 'package:bookmytime/firebase_options.dart';
import 'package:bookmytime/screens/getting_started_screen.dart';
import 'package:bookmytime/services/auth_services.dart';
import 'package:bookmytime/services/theme_provider.dart';
import 'package:bookmytime/tools/pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookmytime/services/user_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthServices()),
        ChangeNotifierProvider(create: (context) => UserDataService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      color: themeProvider.currentTheme.primaryColor,
      title: 'BookMyTime',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.gradient1Blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const GettingStartedScreen(),
    );
  }
}