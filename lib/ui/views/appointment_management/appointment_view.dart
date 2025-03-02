import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/viewmodels/appointment_viewmodel.dart';
import 'package:rmts/ui/views/appointment_management/add_appointment_view.dart';

class AppointmentView extends StatefulWidget {
  final String patientId;

  const AppointmentView({Key? key, required this.patientId}) : super(key: key);

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  void initState() {
    super.initState();
    // Fetch appointments after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appointmentViewModel =
          Provider.of<AppointmentViewmodel>(context, listen: false);
      appointmentViewModel.fetchAppointments(widget.patientId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointmentViewModel = Provider.of<AppointmentViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
      ),
      body: appointmentViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : appointmentViewModel.appointments.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "No upcoming appointments",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddAppointmentView(
                                  patientId: widget.patientId),
                            ),
                          );
                        },
                        child: const Text("Add New Appointment"),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Your Appointments",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: appointmentViewModel.appointments.length,
                        itemBuilder: (context, index) {
                          final appointment =
                              appointmentViewModel.appointments[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: ListTile(
                              title:
                                  Text("Doctor: ${appointment.doctorId}"),
                              subtitle: Text(
                                "Date: ${appointment.dateTime.toLocal()}\nStatus: ${appointment.status.name}",
                              ),
                              trailing: Text(appointment.notes),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAppointmentView(
                                patientId: widget.patientId),
                          ),
                        );
                      },
                      child: const Text("Add New Appointment"),
                    ),
                  ],
                ),
    );
  }
}
