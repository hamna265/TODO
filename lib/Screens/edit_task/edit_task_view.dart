import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../modules/appcolor.dart';

import '../../Widgets/editbutton.dart';
import 'edit_task_logic.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({Key? key}) : super(key: key);

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  final EditTaskController _controller = Get.put(EditTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('ToDo'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.appBarGradient,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.memoCollection.snapshots(),
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit,
                                color: AppColors.primaryColor),
                            onPressed: () => Get.dialog(
                                  EditTaskDialog(
                                    docId: taskDoc.id,
                                    initialTask: taskDoc['task'],
                                  ),
                                )),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: AppColors.primaryColor),
                          onPressed: () => _controller.deleteTask(taskDoc.id),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
