import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rmts/data/models/appointment.dart';
import 'package:rmts/ui/views/appointment_management/doctor_view.dart';
import 'package:rmts/ui/widgets/appointment_tile.dart';
import 'package:rmts/ui/widgets/doctorDetails/doctor_tile_widget.dart';
import 'package:rmts/viewmodels/appointment_viewmodel.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import '/main.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> with RouteAware {
  late AppointmentViewmodel vm;
  late ThemeData theme;
  late Color background;

  @override
  void initState() {
    super.initState();
    // Initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppointmentViewmodel>(context, listen: false)
          .loadAllForPatient();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to route changes
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    // Grab your theme, colors and view-model once dependencies are ready
    theme = Theme.of(context);
    background = theme.colorScheme.surfaceContainerHighest.withOpacity(0.3);
    vm = context.watch<AppointmentViewmodel>();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // this screen is back in view → reload appointments
    Provider.of<AppointmentViewmodel>(context, listen: false)
        .loadAllForPatient();
  }

  List<AppointmentTile> _buildTiles(List<Appointment> list) {
    final _auth = Provider.of<AuthViewModel>(context);

    return list.map((appt) {
      final name = vm.doctorUserInfo?.fullName ?? "Dr. Unknown";
      final date = DateFormat('dd/MM/yyyy').format(appt.dateTime);
      final time = DateFormat('hh:mm a').format(appt.dateTime);
      return AppointmentTile(
        doctorName: name,
        date: date,
        time: time,
        btn1Text: 'Cancel',
        btn2Text: 'Reschedule',
        onTap1: () async {
          try {
            await vm.cancelAppointment(
                appt.appointmentId!, _auth.currentPatient?.uid);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Appointment cancelled.')),
            );
            // Pop and return 'true' so caller knows to refresh:
            
          } catch (e) {
            // handle error...
          }
        },
        onTap2: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DoctorDetailsView(
                doctor: vm.doctorDetails!,
                userInfo: vm.doctorUserInfo!,
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
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
                        builder: (_) => DoctorDetailsView(
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
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView(children: _buildTiles(vm.upcomingAppointments)),
                    ListView(children: _buildTiles(vm.pastAppointments)),
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
