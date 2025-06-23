import 'package:flutter/material.dart';
import 'package:rmts/ui/widgets/appointment_tile.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Appointments',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    AppointmentTile(
                      doctorName: 'Dr. Smith',
                      date: '2023-10-01',
                      time: '10:00 AM',
                      btn_1_text: 'Confirm',
                      btn_2_text: 'Cancel',
                      onTap_1: () {
                        // Action for first button
                        print('First button tapped');
                      },
                      onTap_2: () {
                        // Action for second button
                        print('Second button tapped');
                      },
                    ),
                    AppointmentTile(
                      doctorName: 'Dr. Smith',
                      date: '2023-10-01',
                      time: '10:00 AM',
                      btn_1_text: 'Confirm',
                      btn_2_text: 'Cancel',
                      onTap_1: () {
                        // Action for first button
                        print('First button tapped');
                      },
                      onTap_2: () {
                        // Action for second button
                        print('Second button tapped');
                      },
                    ),
                    AppointmentTile(
                      doctorName: 'Dr. Smith',
                      date: '2023-10-01',
                      time: '10:00 AM',
                      btn_1_text: 'Confirm',
                      btn_2_text: 'Cancel',
                      onTap_1: () {
                        // Action for first button
                        print('First button tapped');
                      },
                      onTap_2: () {
                        // Action for second button
                        print('Second button tapped');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
