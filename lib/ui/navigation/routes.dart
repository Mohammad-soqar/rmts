import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/viewmodels/register_viewmodel.dart';
import '../views/register_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
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
          child: Text('Go to Register'),
        ),
      ),
    );
  }
}
