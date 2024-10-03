import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/commen/studentsprovide.dart';
import 'package:flutter_application_1/screens/addstudentsscreen.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:flutter_application_1/screens/profilescreen.dart';
import 'package:flutter_application_1/servises/functions.dart';

import 'package:flutter_application_1/model/model.dart';
import 'package:provider/provider.dart';


class StudentListProvider extends ChangeNotifier {
  List<StudentModel> _students = [];

  List<StudentModel> get students => _students;

  void setStudents(List<StudentModel> students) {
    _students = students;
    notifyListeners();
  }
}


class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    studentProvider.getAllStudents();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 246, 246),
      appBar: AppBar(
        title: const Text("Strudends"),
        actions: [
             
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          studentProvider.signOut(context);
                        },
                        child: const Text('OK'),
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Color.fromARGB(255, 154, 14, 58),
      ), //AppB
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         showDialog(
      //           context: context,
      //           builder: (BuildContext context) {
      //             return AlertDialog(
      //               title: const Text('Are you sure you want to logout?'),
      //               actions: [
      //                 TextButton(
      //                   onPressed: () {
      //                     Navigator.of(context).pop();
      //                   },
      //                   child: const Text('Cancel'),
      //                 ),
      //                 TextButton(
      //                   onPressed: () {
      //                     studentProvider.signOut(context);
      //                   },
      //                   child: const Text('OK'),
      //                 )
      //               ],
      //             );
      //           },
      //         );
      //       },
      //       icon: const Icon(Icons.exit_to_app),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: TextField(
            //     onChanged: (value) {
            //       studentProvider.performSearch(value);
            //     },
            //     decoration: InputDecoration(
            //       hintText: 'Search...',
            //       suffixIcon: IconButton(
            //         onPressed: () {
            //           studentProvider.clearSearch();
            //         },
            //         icon: const Icon(Icons.clear),
            //       ),
            //       prefixIcon: IconButton(
            //         onPressed: () {
            //           // Perform search action if needed
            //         },
            //         icon: const Icon(Icons.search),
            //       ),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //     ),
            //   ),
            // ),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 150),
            //       child: IconButton(
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (_) =>StudentListScreen()),
            //           );
            //         },
            //         icon: const Icon(Icons.grid_view_rounded),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 130, right: 130),
              child: ElevatedButton.icon(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ScreenAdd()),
    );
  },
  icon: const Icon(
    Icons.add,
    color: Color.fromARGB(255, 8, 7, 7), // Change the icon color here
  ),
  label: const Text('ADD',style: TextStyle(color: Colors.black),),
  style: ElevatedButton.styleFrom(
    primary: Color.fromARGB(255, 242, 238, 238), // Change the background color here
    onPrimary: Colors.white, // Change the text color here
  ),
)


            ),
            Expanded(
              child: ValueListenableBuilder<List<StudentModel>>(
        valueListenable: studentlistnotifair,
        builder: (context, studentList, _) {
          return GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // Number of columns in the grid
    crossAxisSpacing: 10.0, // Spacing between each column
    mainAxisSpacing: 10.0, // Spacing between each row
  ),
  itemCount: studentList.length,
  itemBuilder: (context, index) {
    final student = studentList[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScreenProfile(student: student)),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: FileImage(File(student.imagetemporary)),
              radius: 40.0,
            ),
            SizedBox(height: 10.0),
            Text(
              student.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              student.Place,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  },
);

        },
      ),
              
            ),
         BottomNavigationBar(
        currentIndex: 1, // Current selected tab index
        onTap: (index) {
          // Handle tap on each tab
          // You can navigate to different screens based on the index
          // For example:
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ScreenHome()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Grid',
          ),
          // Add more BottomNavigationBarItems for additional tabs
        ],
      ),

            
          ],
        ),
      ),
    );
  }
  
}