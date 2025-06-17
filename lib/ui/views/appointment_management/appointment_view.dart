import 'package:flutter/material.dart';
import 'package:rmts/ui/widgets/doctorDetails/calendar_widget.dart';
import 'package:rmts/ui/widgets/doctorDetails/doctor_tile_widget.dart';

class DoctorDetailsView extends StatefulWidget {
  const DoctorDetailsView({super.key});

  @override
  _DoctorDetailsViewState createState() => _DoctorDetailsViewState();
}

class _DoctorDetailsViewState extends State<DoctorDetailsView> {
  bool isExpanded = false;

  final String fullText =
      'Dr. Abdullah Al-Fahad is a highly experienced dentist with over 15 years of expertise in general and cosmetic dentistry. '
      'Dr. Al-Fahad stays up-to-date with the latest dental technologies and has helped countless patients achieve healthy, confident smiles.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Doctor Details'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              DoctorTileWidget(
                doctorName: 'Dr. Abdullah Al-Fahad',
                doctorImage: 'assets/doctors/1.png',
                doctorSpecialty: 'Dentist',
                doctorRating: '4.7',
              ),
              SizedBox(height: 16),
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
              Spacer(),
              EasyDateTimePicker(),
            ],
          ),
        ),
      ),
    );
  }
}
