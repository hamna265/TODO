import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/edit_task/edit_task_logic.dart';

class EditTaskDialog extends StatelessWidget {
  final String docId;
  final String initialTask;
  EditTaskDialog({required this.docId, required this.initialTask, Key? key})
      : super(key: key);

  final EditTaskController _controller = Get.find();
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _taskController.text = initialTask;

    return AlertDialog(
      title: const Text('Edit Task'),
      content: TextField(
        controller: _taskController,
        maxLines: 5,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            _controller.updateTask(docId, _taskController.text);
            Get.back();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
