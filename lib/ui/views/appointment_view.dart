import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rmts/data/models/appointment.dart';
import 'package:rmts/ui/views/appointment_management/doctor_view.dart';
import 'package:rmts/ui/widgets/appointment_tile.dart';
import 'package:rmts/ui/widgets/doctorDetails/doctor_tile_widget.dart';
import 'package:rmts/viewmodels/appointment_viewmodel.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appointmentViewModel =
          Provider.of<AppointmentViewmodel>(context, listen: false);
      appointmentViewModel.loadAllForPatient();
    });
  }

  List<AppointmentTile> get _upcoming => const [
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

  List<AppointmentTile> get _completed => const [
        AppointmentTile(
          doctorName: 'Dr. Carol Lee',
          date: '08/20/2024',
          time: '11:00 AM',
          btn1Text: 'Leave Review',
          btn2Text: 'Book Follow-up',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background =
        theme.colorScheme.surfaceContainerHighest.withOpacity(0.3);
    final vm = context.watch<AppointmentViewmodel>();

    if (vm.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (vm.errorMessage != null) {
      return Scaffold(
        body: Center(child: Text("Error loading data: ${vm.errorMessage}")),
      );
    }

    if (vm.doctorUserInfo == null || vm.doctorDetails == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    List<AppointmentTile> buildTiles(List<Appointment> list) {
      return list.map((appt) {
        return AppointmentTile(
          doctorName: vm.doctorUserInfo?.fullName ?? "Dr. Unknown",
          date: DateFormat('dd/MM/yyyy').format(appt.dateTime),
          time: DateFormat('hh:mm a').format(appt.dateTime),
          btn1Text: 'Cancel',
          btn2Text: 'Reschedule',
        );
      }).toList();
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              DoctorTileWidget(
                doctorName: vm.doctorUserInfo!.fullName,
                doctorImage: 'assets/doctors/5.png',
                doctorSpecialty: 'Rheumatologist',
                doctorRating: '4.8',
                specialization: 'joint care',
                onTap: () {
                  if (vm.doctorDetails != null && vm.doctorUserInfo != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailsView(
                          doctor: vm.doctorDetails!,
                          userInfo: vm.doctorUserInfo!,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Doctor info is not ready")),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),

              // segmented control
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: theme.colorScheme.onPrimary,
                  unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                  tabs: const [
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Past'),
                  ],
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
              ),

              const SizedBox(height: 20),

              // tab views must be inside Expanded
              Expanded(
                  child: TabBarView(
                children: [
                  ListView(children: buildTiles(vm.upcomingAppointments)),
                  ListView(children: buildTiles(vm.pastAppointments)),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
