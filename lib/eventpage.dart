import 'package:calender_clone/provider/event_provider.dart';
import 'package:calender_clone/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'model/event.dart';

class EventPage extends StatefulWidget {
  EventPage({super.key, this.event});
  final Event? event;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late DateTime fromTime;
  TextEditingController eventController = TextEditingController();

  late DateTime toTime;
  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromTime = DateTime.now();
      toTime = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                  ElevatedButton(
                      onPressed: () {
                        final event = Event(
                            title: eventController.text,
                            from: fromTime,
                            to: toTime);

                        final provider =
                            Provider.of<EventProvider>(context, listen: false);

                        provider.addEvent(event);

                        Navigator.of(context).pop();
                      },
                      child: Text("Save")),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: TextFormField(
                    controller: eventController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add title",
                        hintStyle: TextStyle(fontSize: 25)),
                  )),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () => pickFromDatetime(pickDate: true),
                        child: Text(Utils.toDate(fromTime))),
                    const SizedBox(
                      width: 60,
                    ),
                    GestureDetector(
                      onTap: () => pickFromDatetime(pickDate: false),
                      child: Text("${Utils.toTime(fromTime)} - "),
                    ),
                    GestureDetector(
                        onTap: () => pickToDatetime(pickDate: false),
                        child: Text("${Utils.toTime(toTime)}"))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: const [
                    Icon(Icons.people_alt_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Add people")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future pickFromDatetime({required bool pickDate}) async {
    final date = await pickDateTime(fromTime, pickDate: pickDate);
    if (date == null) return;
    setState(() {
      fromTime = date;
    });
  }

  Future pickToDatetime({required bool pickDate}) async {
    final date = await pickDateTime(fromTime, pickDate: pickDate);
    if (date == null) return;
    setState(() {
      toTime = date;
    });
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2023),
          lastDate: DateTime(2024));
      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeofDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeofDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeofDay.hour, minutes: timeofDay.minute);
      return date.add(time);
    }
  }
}