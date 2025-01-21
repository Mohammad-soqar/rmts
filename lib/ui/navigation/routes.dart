import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/viewmodels/register_viewmodel.dart';
import '../views/register_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
           Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: RegisterView(),
    ),
  ),
);

          },
          child: const Text('Go to Register'),
        ),
      ),
    );
  }
}
