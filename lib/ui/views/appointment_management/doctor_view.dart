import 'package:flutter/material.dart';
import 'package:rmts/data/models/doctor.dart';
import 'package:rmts/data/models/user.dart';
import 'package:rmts/ui/widgets/doctorDetails/calendar_widget.dart';
import 'package:rmts/ui/widgets/doctorDetails/doctor_tile_widget.dart';

class DoctorDetailsView extends StatefulWidget {
  final Doctor? doctor;
  final User? userInfo;

  const DoctorDetailsView({super.key, this.doctor, this.userInfo});

  @override
  _DoctorDetailsViewState createState() => _DoctorDetailsViewState();
}

class _DoctorDetailsViewState extends State<DoctorDetailsView> {
  bool isExpanded = false;

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
  Widget build(BuildContext context) {
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
                  specialization: 'joint care & autoimmune diseases'),
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

               /*  // Check if there are upcoming appointments
                (doctorDetails?.appointments == null ||
                    doctorDetails!.appointments!.isEmpty)
                  ? EasyDateTimePicker(
                    doctor: widget.doctor,
                  )
                  : Column(
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
                        onPressed: () {
                        // TODO: Implement cancel appointment logic
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                        // TODO: Implement reschedule appointment logic
                        },
                        child: const Text('Reschedule'),
                      ),
                      ],
                    ),
                    ],
                  ), */
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
