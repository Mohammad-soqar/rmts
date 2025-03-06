import 'package:flutter/material.dart';
import 'package:rmts/ui/views/auth/login_view.dart';
import 'package:rmts/ui/widgets/app_button.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Full-size image with no padding
          Image.asset(
            "assets/splashScreen.png",
            width: double.infinity,
            height: MediaQuery.of(context).size.height *
                0.50, // Adjust image height
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(
            "Welcome to RMTS!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Discover how RMTS simplifies managing appointments easily, all in one place.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Pagination Indicators (Dots)

          CustomButton(
            color: Theme.of(context).colorScheme.primary,
            label: "Next!",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
          ),
          const SizedBox(height: 10),
          CustomButton(
            color: Theme.of(context).colorScheme.primary,
            label: "Get Started",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
