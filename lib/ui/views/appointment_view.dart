import 'package:flutter/material.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  _AppointmentViewState createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment View'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Appoitnments!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
