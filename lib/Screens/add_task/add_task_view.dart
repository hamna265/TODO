// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../modules/appcolor.dart';

import 'add_task_logic.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final AddTaskController _controller = Get.put(AddTaskController());
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('ToDo'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppColors.appBarGradient,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.memoCollection
            .snapshots(), 
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var taskDoc = snapshot.data!.docs[index];
              return Dismissible(
                key: Key(taskDoc.id),
                onDismissed: (_) => _controller.deleteTask(taskDoc.id),
                child: Card(
                  color: const Color.fromARGB(255, 222, 239, 253),
                  elevation: 4,
                 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    leading: SizedBox(
                      height: 40,
                      width: 40,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: AppColors.appBarGradient),
                        child: Center(
                          child: Text(
                            index.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    title: Text(taskDoc['task']),
                    subtitle: Text(taskDoc['date']),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add),
        onPressed: () => _addTaskDialog(),
      ),
    );
  }

  void _addTaskDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Add Task'),
        content: Form(
          key: key,
          child: TextFormField(
            maxLines: 5,
            decoration: InputDecoration(labelText: 'Task'),
            validator: (val) => val!.isEmpty ? '*Required' : null,
            onChanged: (val) => _controller.state.task.value = val,
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Get.back(),
          ),
          ElevatedButton(
            child: Text("Add Task"),
            onPressed: () {
              if (key.currentState!.validate()) {
                _controller.addTask(_controller.state.task.value);
                Get.back();
              }
            },
          ),
        ],
      ),
    );
  }
}
