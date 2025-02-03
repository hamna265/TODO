// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../modules/appcolor.dart';
import 'view_task_logic.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  final ViewTaskController _controller = Get.put(ViewTaskController());
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
      body: StreamBuilder(
        stream: _controller.memoCollection.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var taskDoc = snapshot.data!.docs[index];

              return Padding(
                padding: const EdgeInsets.fromLTRB(4, 5, 5, 0),
                child: Card(
                  color: AppColors.cardColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(taskDoc['task']),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.date_range_rounded,
                                size: 15, color: Colors.grey),
                            SizedBox(width: 5),
                            Text(taskDoc['date'],
                                style: TextStyle(fontSize: 10)),
                          ],
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
