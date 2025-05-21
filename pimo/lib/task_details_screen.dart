import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart'; // Importing to get Task class

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    // Ensure Directionality is set, though it should be inherited from MyApp
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            task.title, // Show task title in AppBar
            style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).scaffoldBackgroundColor, // Ensure back button is visible
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'عنوان المهمة:',
                style: GoogleFonts.playpenSansArabicTextTheme(
                  Theme.of(context).textTheme,
                ).titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                task.title,
                style: GoogleFonts.playpenSansArabicTextTheme(
                  Theme.of(context).textTheme,
                ).titleMedium,
              ),
              const SizedBox(height: 24.0),
              Text(
                'الوصف:',
                style: GoogleFonts.playpenSansArabicTextTheme(
                  Theme.of(context).textTheme,
                ).titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                task.description.isEmpty ? 'لا يوجد وصف لهذه المهمة.' : task.description,
                style: GoogleFonts.playpenSansArabicTextTheme(
                  Theme.of(context).textTheme,
                ).titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
