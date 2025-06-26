import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/data/models/doctor.dart';
import 'package:rmts/data/models/user.dart';
import 'package:rmts/ui/widgets/doctorDetails/calendar_widget.dart';
import 'package:rmts/ui/widgets/doctorDetails/doctor_tile_widget.dart';
import 'package:rmts/viewmodels/appointment_viewmodel.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';

class DoctorDetailsView extends StatefulWidget {
  final Doctor? doctor;
  final User? userInfo;

  const DoctorDetailsView({super.key, this.doctor, this.userInfo});

  @override
  _DoctorDetailsViewState createState() => _DoctorDetailsViewState();
}

class _DoctorDetailsViewState extends State<DoctorDetailsView> {
  bool isExpanded = false;
  bool _appointmentsLoaded = false;

  late final String fullText;
  late final Doctor? doctorDetails;
  late final User? doctorUserInfo;

  @override
  void initState() {
    super.initState();
    fullText = widget.doctor!.description;
    doctorDetails = widget.doctor;
    doctorUserInfo = widget.userInfo;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_appointmentsLoaded) {
      _appointmentsLoaded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final authVm = Provider.of<AuthViewModel>(context, listen: false);
        final apptVm =
            Provider.of<AppointmentViewmodel>(context, listen: false);
        apptVm.loadPatientAppointment(authVm.currentPatient!.uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AppointmentViewmodel>(context);
    final _auth = Provider.of<AuthViewModel>(context);

    final now = DateTime.now();
    final upcomingAppointments = vm.appointments_patient
        .where(
          (appt) => appt.dateTime.isAfter(now),
        )
        .toList();
    final hasAppointment = upcomingAppointments.isNotEmpty;
    final String? appointmentId =
        hasAppointment ? upcomingAppointments.first.appointmentId : null;

    if (doctorDetails == null || doctorUserInfo == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Doctor Details'),
        ),
        body: const Center(
          child: Text('Doctor details not available.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Doctor Details'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              DoctorTileWidget(
                  doctorName: doctorUserInfo!.fullName,
                  doctorImage: 'assets/doctors/5.png',
                  doctorSpecialty: 'Rheumatologist',
                  doctorRating: '4.8',
                  specialization: 'joint care'),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      children: [
                        TextSpan(
                          text: isExpanded
                              ? fullText
                              : fullText.length > 120
                                  ? '${fullText.substring(0, 120)}... '
                                  : fullText,
                        ),
                        if (fullText.length > 120)
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () {
                                setState(() => isExpanded = !isExpanded);
                              },
                              child: Text(
                                isExpanded ? 'Read Less' : 'Read More',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (!hasAppointment)
                EasyDateTimePicker(
                  doctor: widget.doctor,
                )
              else
                Column(
                  children: [
                    Text(
                      'You have an appointment already booked.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await vm.cancelAppointment(
                                  appointmentId!, _auth.currentPatient?.uid);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Appointment cancelled.')),
                              );
                              // Pop and return 'true' so caller knows to refresh:
                              Navigator.of(context).pop(true);
                            } catch (e) {
                              // handle error...
                            }
                          },
                          child: const Text('Cancel Appointment'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () async {
                            final shouldReschedule = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Reschedule Appointment'),
                                content: const Text(
                                    'Are you sure you want to reschedule your appointment?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                        try {
                                        await vm.cancelAppointment(
                                          appointmentId!,
                                          _auth.currentPatient?.uid);

                                        // Pop twice: first to close the dialog, then to return to previous screen
                                        Navigator.of(context).pop(true); // Close dialog
                                        Navigator.of(context).pop(true); // Return to previous screen
                                      } catch (e) {
                                        // handle error...
                                      }
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                            if (shouldReschedule == true) {
                              try {
                                await vm.cancelAppointment(
                                    appointmentId!, _auth.currentPatient?.uid);
                                setState(() {
                                  // Optionally trigger UI update or navigation
                                });
                              } catch (e) {
                                // handle error...
                              }
                            }
                          },
                          child: const Text('Reschedule'),
                        ),
                      ],
                    ),
                  ],
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
