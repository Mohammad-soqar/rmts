import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/data/repositories/glove_repository.dart';
import 'package:rmts/ui/themes/theme.dart';
import 'package:rmts/ui/views/appointment_management/add_appointment_view.dart';
import 'package:rmts/ui/views/appointment_management/appointment_view.dart';
import 'package:rmts/ui/views/auth/splashScreens/SplashView.dart';
import 'package:rmts/ui/views/home_view.dart';
import 'package:rmts/viewmodels/appointment_viewmodel.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import 'package:rmts/viewmodels/auth/register_viewmodel.dart';
import 'package:rmts/viewmodels/glove_viewmodel.dart';

import 'viewmodels/reports_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized

  final gloveRepository = GloveRepository();

  // Run the app with MultiProvider for state management
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthViewModel()), // Authentication Provider
        ChangeNotifierProvider(
            create: (_) => RegisterViewModel()), // Registration Provider
        ChangeNotifierProvider(
            create: (_) => ReportsViewModel()), // Reports Provider
        ChangeNotifierProvider(
            create: (_) =>
                GloveViewModel(gloveRepository)), // Glove Data Provider
        ChangeNotifierProvider(
            create: (_) => AppointmentViewmodel()), // Appointment Management
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
      debugShowCheckedModeBanner: false,
      title: 'RMTS System',
      theme: const MaterialTheme(TextTheme()).light(), // Apply Light Theme
      darkTheme: const MaterialTheme(TextTheme()).dark(), // Apply Dark Theme
      themeMode: ThemeMode.system, // Switch based on system theme
      home: const AuthWrapper(), // Decide screen based on authentication
      routes: {
        '/home': (context) => const HomeView(),
        '/viewAppointments': (context) =>
            const AppointmentView(patientId: "patient123"),
        '/addAppointment': (context) =>
            const AddAppointmentView(patientId: "patient123"),
      },
    );
  }
}

// 🔹 Handles authentication state and redirects accordingly
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    if (authViewModel.currentUser == null) {
      return const SplashView(); // User is not logged in, show login screen
    } else {
      return const HomeView(); // User is authenticated, go to home screen
    }
  }
}
