import 'package:calender_clone/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/event_datasource.dart';
import '../provider/event_provider.dart';

class CalenderWidget extends StatelessWidget {
  final fromtime;
  const CalenderWidget({super.key, this.fromtime});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.week,
      initialSelectedDate: DateTime.now(),
      dataSource: EventDataSource(events),
      onTap: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);
        provider.setDate(details.date!);
        showModalBottomSheet(
            context: context, builder: (context) => const TaskWidget());
      },
    );
  }
}