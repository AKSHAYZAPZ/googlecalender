import 'package:calender_clone/eventpage.dart';
import 'package:calender_clone/provider/event_provider.dart';
import 'package:calender_clone/widgets/calender_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Mainapaage()),
    );
  }
}

class Mainapaage extends StatelessWidget {
  Mainapaage({
    super.key,
  });

  late DateTime fromTime;

  late DateTime toTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: CalenderWidget()),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return EventPage();
            }));
          }),
    );
  }
}