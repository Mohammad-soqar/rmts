import 'package:flutter/material.dart';
import 'package:rmts/ui/widgets/appointment_tile.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  List<AppointmentTile> _upcoming() => const [
        AppointmentTile(
          doctorName: 'Dr. Alice Nguyen',
          date: '09/12/2024',
          time: '10:30 AM',
          btn1Text: 'Cancel',
          btn2Text: 'Reschedule',
        ),
        AppointmentTile(
          doctorName: 'Dr. Bob Patel',
          date: '09/15/2024',
          time: '02:00 PM',
          btn1Text: 'Cancel',
          btn2Text: 'Reschedule',
        ),
      ];

  List<AppointmentTile> _completed() => const [
        AppointmentTile(
          doctorName: 'Dr. Carol Lee',
          date: '08/20/2024',
          time: '11:00 AM',
          btn1Text: 'Leave Review',
          btn2Text: 'Book Follow-up',
        ),
      ];

  List<AppointmentTile> _canceled() => const [
        AppointmentTile(
          doctorName: 'Dr. Dan Müller',
          date: '07/30/2024',
          time: '09:00 AM',
          btn1Text: 'View Details',
          btn2Text: 'Reschedule',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final onPrimary = theme.colorScheme.onPrimary;
    final background =
        theme.colorScheme.surfaceContainerHighest.withOpacity(0.3);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0, // Remove shadow
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(), // Remove AppBar bottom line
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Segmented control
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: onPrimary,
                  unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                  dividerColor: Colors.transparent, // REMOVE TabBar bottom line
                  tabs: const [
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Canceled'),
                  ],
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
              ),
              const SizedBox(height: 20),

              // Tab content
              Expanded(
                child: TabBarView(
                  children: [
                    ListView(children: _upcoming()),
                    ListView(children: _completed()),
                    ListView(children: _canceled()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
