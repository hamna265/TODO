// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:memoapp/Screens/view_task/view_task_view.dart';
import '../Screens/add_task/add_task_view.dart';
import '../Screens/edit_task/edit_task_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          ViewTask(),
          AddTask(),
          EditTaskView(),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        backgroundColor: Color.fromARGB(255, 3, 42, 87),
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.task),
            title: Text('Task'),
            inactiveColor: Colors.white54,
            activeColor: Color.fromARGB(255, 255, 255, 255),
            activeTitleColor: Color.fromARGB(255, 255, 255, 255),
          ),
          BottomBarItem(
            icon: Icon(Icons.add),
            title: Text('Add'),
            inactiveColor: Colors.white54,
            activeColor: Color.fromARGB(255, 255, 255, 255),
          ),
          BottomBarItem(
            icon: Icon(Icons.edit),
            title: Text('Edit'),
            inactiveColor: Colors.white54,
            activeColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ],
      ),
    );
  }
}
