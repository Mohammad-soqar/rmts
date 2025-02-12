import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/data/repositories/glove_repository.dart';
import 'package:rmts/ui/views/auth/login_view.dart';
import 'package:rmts/ui/views/home_view.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import 'package:rmts/viewmodels/auth/register_viewmodel.dart';
import 'package:rmts/viewmodels/glove_viewmodel.dart';

import 'viewmodels/reports_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final gloveRepository = GloveRepository();

  // Run the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()), // Auth Provider

        ChangeNotifierProvider(
            create: (_) => RegisterViewModel()), // RegisterViewModel Provider
        ChangeNotifierProvider(
            create: (_) => ReportsViewModel()), // ReportsViewModel Provider
        ChangeNotifierProvider(
            create: (_) =>
                GloveViewModel(gloveRepository)), // ReportsViewModel Provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthWrapper(), // Decide screen based on user authentication
    );
  }
}

// This widget determines if the user is logged in or not
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    if (authViewModel.currentUser == null) {
      return LoginView(); // If no user is logged in, show login screen
    } else {
      return HomeView(); // If user is logged in, show home screen
    }
  }
}
