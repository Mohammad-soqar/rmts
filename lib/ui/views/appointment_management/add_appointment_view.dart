import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:rmts/data/models/appointment.dart';
import 'package:rmts/viewmodels/appointment_viewmodel.dart';
import 'package:rmts/data/models/enums/appointment_status.dart';

class AddAppointmentView extends StatefulWidget {
  final String patientId;

  const AddAppointmentView({Key? key, required this.patientId}) : super(key: key);

  @override
  _AddAppointmentViewState createState() => _AddAppointmentViewState();
}

class _AddAppointmentViewState extends State<AddAppointmentView> {
  final TextEditingController _doctorIdController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime? _selectedDate;

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
    if (_doctorIdController.text.isEmpty || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final newAppointment = Appointment(
      appointmentId: const Uuid().v4(),
      patientId: widget.patientId,
      doctorId: _doctorIdController.text,
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
              controller: _doctorIdController,
              decoration: const InputDecoration(labelText: "Doctor ID"),
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
              decoration: const InputDecoration(labelText: "Notes"),
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
