// ignore_for_file: deprecated_member_use

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EasyDateTimePicker extends StatefulWidget {
  const EasyDateTimePicker({super.key});

  @override
  State<EasyDateTimePicker> createState() => _EasyDateTimePickerState();
}

class _EasyDateTimePickerState extends State<EasyDateTimePicker> {
  DateTime? selectedDate = DateTime.now();
  String? selectedTime;

  final List<String> timeSlots = [
    '09:00 AM',
    '09:15 AM',
    '09:30 AM',
    '09:45 AM',
    '10:00 AM',
    '10:15 AM',
    '10:30 AM',
    '10:45 AM',
    '11:00 AM',
  ];

  final List<String> unavailableSlots = ['09:30 AM', '10:45 AM'];

  bool isWeekend(DateTime date) =>
      date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

  @override
  Widget build(BuildContext context) {
    final isReady = selectedDate != null && selectedTime != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Date',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/Calendar.svg',
                    height: 22,
                    color: Theme.of(context).colorScheme.onSurface,
                    width: 22,
                  ),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate!,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null && !isWeekend(picked)) {
                      setState(() => selectedDate = picked);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// Easy Date Timeline
          EasyDateTimeLine(
            initialDate: selectedDate!,
            headerProps: EasyHeaderProps(showHeader: false),
            timeLineProps: EasyTimeLineProps(
              separatorPadding: 18,
            ),
            disabledDates: [
              ...List.generate(365, (index) {
                return DateTime.now().subtract(Duration(days: index + 1));
              }),
              ...List.generate(90, (i) {
                final d = DateTime.now().add(Duration(days: i));
                return isWeekend(d) ? d : null;
              }).whereType<DateTime>(),
            ],
            onDateChange: (date) {
              if (!isWeekend(date)) {
                setState(() => selectedDate = date);
              }
            },
            dayProps: EasyDayProps(
              height: 55,
              width: 37,
              dayStructure: DayStructure.dayNumDayStr,
              todayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                dayStrStyle: const TextStyle(fontSize: 8),
                dayNumStyle: const TextStyle(fontSize: 16),
              ),
              disabledDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onInverseSurface
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                dayStrStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.2),
                    fontSize: 8),
                dayNumStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.2),
                    fontSize: 16),
              ),
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                dayStrStyle: const TextStyle(fontSize: 8),
                dayNumStyle: const TextStyle(fontSize: 16),
              ),
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                dayStrStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
                dayNumStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Time Slots
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: timeSlots.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              final time = timeSlots[index];
              final isSelected = selectedTime == time;
              final isUnavailable = unavailableSlots.contains(time);

              return GestureDetector(
                onTap: isUnavailable
                    ? null
                    : () => setState(() => selectedTime = time),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : isUnavailable
                            ? Theme.of(context)
                                .colorScheme
                                .onInverseSurface
                                .withOpacity(0.2)
                            : Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : isUnavailable
                              ? Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.2)
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isReady
                  ? () => debugPrint('Selected: $selectedDate $selectedTime')
                  : null,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: isReady
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onInverseSurface,
                foregroundColor: isReady
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
