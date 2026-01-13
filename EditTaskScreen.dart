import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEditTaskScreen extends StatefulWidget {
  final String? taskId;
  final Map<String, dynamic>? taskData;

  const AddEditTaskScreen({this.taskId, this.taskData, super.key});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dueDateController = TextEditingController();
  String status = "Pending";

  @override
  void initState() {
    super.initState();
    if (widget.taskData != null) {
      titleController.text = widget.taskData!['title'];
      descController.text = widget.taskData!['description'];
      dueDateController.text = widget.taskData!['dueDate'];
      status = widget.taskData!['status'];
    }
  }

  void saveTask() {
    final data = {
      'title': titleController.text,
      'description': descController.text,
      'dueDate': dueDateController.text,
      'status': status,
    };

    if (widget.taskId == null) {
      FirebaseFirestore.instance.collection('tasks').add(data);
    } else {
      FirebaseFirestore.instance
          .collection('tasks')
          .doc(widget.taskId)
          .update(data);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add / Edit Task")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Task Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: dueDateController,
              decoration: const InputDecoration(
                labelText: "Due Date",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: status,
              items: const [
                DropdownMenuItem(value: "Pending", child: Text("Pending")),
                DropdownMenuItem(value: "Completed", child: Text("Completed")),
              ],
              onChanged: (value) {
                setState(() {
                  status = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveTask,
              child: const Text("Save Task"),
            ),
          ],
        ),
      ),
    );
  }
}
