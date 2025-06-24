/* import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmts/data/models/appointment.dart';
import 'package:rmts/viewmodels/appointment_viewmodel.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import 'package:rmts/data/models/enums/appointment_status.dart';

class AddAppointmentView extends StatefulWidget {
  final String patientId;

  const AddAppointmentView({Key? key, required this.patientId}) : super(key: key);

  @override
  _AddAppointmentViewState createState() => _AddAppointmentViewState();
}

class _AddAppointmentViewState extends State<AddAppointmentView> {
  final TextEditingController _notesController = TextEditingController();
  DateTime? _selectedDate;
  String? _doctorName; 
  String? _doctorId;   

  @override
  void initState() {
    super.initState();
    _fetchDoctorDetails(); 
  }

  
  void _fetchDoctorDetails() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    if (authViewModel.currentPatient != null) {
      String doctorId = authViewModel.currentPatient!.doctorId; 
      setState(() {
        _doctorId = doctorId; 
      });

      
      DocumentSnapshot doctorSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(doctorId).get();

      if (doctorSnapshot.exists) {
        setState(() {
          _doctorName = doctorSnapshot['fullName'] ?? 'Unknown Doctor';
        });
      } else {
        setState(() {
          _doctorName = "Doctor not found";
        });
      }
    }
  }

  void _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitAppointment(BuildContext context) async {
    if (_doctorId == null || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please wait while doctor info is loading.")),
      );
      return;
    }

    final newAppointment = Appointment(
      appointmentId: const Uuid().v4(),
      patientId: widget.patientId,
      doctorId: _doctorId!, 
      dateTime: _selectedDate!,
      status: AppointmentStatus.upcoming, 
      notes: _notesController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await Provider.of<AppointmentViewmodel>(context, listen: false)
        .addAppointment(newAppointment);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Doctor",
                hintText: "Loading...",
                border: const OutlineInputBorder(),
              ),
              controller: TextEditingController(text: _doctorName),
              readOnly: true, 
            ),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () => _pickDate(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: _selectedDate == null ? "Select Date" : "Date: ${_selectedDate!.toLocal()}",
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: "Notes (Optional)", border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () => _submitAppointment(context),
                child: const Text("Add Appointment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */