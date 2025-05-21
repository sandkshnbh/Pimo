import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'task_details_screen.dart'; // Import the new screen

void main() {
  runApp(const MyApp());
}

class Task {
  String title;
  String description;
  Task({required this.title, this.description = ''});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pimo To-Do',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.tealAccent,
        hintColor: Colors.teal, // secondaryHeaderColor is deprecated, using hintColor as an alternative for secondary
        scaffoldBackgroundColor: const Color(0xFF101010),
        textTheme: GoogleFonts.playpenSansArabicTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        useMaterial3: true,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MyHomePage(title: 'قائمة المهام'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> _tasks = [];
  final TextEditingController _taskTitleController = TextEditingController();

  void _addTask() {
    if (_taskTitleController.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: _taskTitleController.text));
        _taskTitleController.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title,
          style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _taskTitleController,
                    decoration: const InputDecoration(
                      hintText: 'أضف مهمة جديدة...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => _addTask(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: const Text('إضافة'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: const Duration(milliseconds: 500),
                    closedBuilder: (BuildContext _, VoidCallback openContainer) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(task.title),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _deleteTask(index),
                          ),
                          onTap: openContainer, // Open the container on tap
                        ),
                      );
                    },
                    openBuilder: (BuildContext _, VoidCallback __) {
                      return TaskDetailsScreen(task: task);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
