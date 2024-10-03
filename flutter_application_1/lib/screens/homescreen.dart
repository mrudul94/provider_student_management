import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/commen/studentsprovide.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/screens/addstudentsscreen.dart';
import 'package:flutter_application_1/screens/gridscreen.dart';
import 'package:flutter_application_1/screens/profilescreen.dart';
import 'package:flutter_application_1/servises/functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    studentProvider.getAllStudents();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 223, 223),
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
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
                  color: Color.fromARGB(
                      255, 8, 7, 7), // Change the icon color here
                ),
                label: const Text(
                  'ADD',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(
                      255, 242, 238, 238), // Change the background color here
                  onPrimary: Colors.white, // Change the text color here
                ),
              ),    
            ),
            Expanded(
              child: ValueListenableBuilder<List<StudentModel>>(
                valueListenable: studentlistnotifair,
                builder: (context, studentList, _) {
                  return ListView.builder(
                    itemCount: studentList.length,
                    itemBuilder: (context, index) {
                      final student = studentList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              FileImage(File(student.imagetemporary)),
                        ),
                        title: Text(student.name),
                        subtitle: Text(student.Place),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ScreenProfile(student: student),
                              ));
                          // Handle onTap event here
                        },
                        trailing: IconButton(
                          onPressed: () {
                            final TextEditingController nameController =
                                TextEditingController(text: student.name);
                            final TextEditingController ageController =
                                TextEditingController(text: student.age);
                            final TextEditingController placeController =
                                TextEditingController(text: student.Place);
                            final TextEditingController phoneNumberController =
                                TextEditingController(text: student.number);
                            String? _pickedImage;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context, setState) {
                                    return AlertDialog(
                                      title: const Text("Update Student"),
                                      content: ListView(
                                        children: [
                                          TextField(
                                            controller: nameController,
                                            decoration: const InputDecoration(
                                                labelText: "Name"),
                                          ),
                                          TextField(
                                            controller: ageController,
                                            decoration: const InputDecoration(
                                                labelText: "Age"),
                                          ),
                                          TextField(
                                            controller: placeController,
                                            decoration: const InputDecoration(
                                                labelText: "Place"),
                                          ),
                                          TextField(
                                            controller: phoneNumberController,
                                            decoration: const InputDecoration(
                                                labelText: "Phone Number"),
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () async {
                                              final imagePicker = ImagePicker();
                                              final pickedImage =
                                                  await imagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (pickedImage != null) {
                                                setState(() {
                                                  _pickedImage =
                                                      pickedImage.path;
                                                });
                                              }
                                            },
                                            icon: const Icon(Icons.image),
                                            label: const Text(
                                                'Update Profile Picture'),
                                          ),
                                          _pickedImage != null
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.file(
                                                      File(_pickedImage!)),
                                                )
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.file(File(
                                                      student.imagetemporary)),
                                                )
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final updatedName =
                                                nameController.text;
                                            final updatedAge =
                                                ageController.text;
                                            final updatedPlace =
                                                placeController.text;
                                            final updatedPhoneNumber =
                                                phoneNumberController.text;

                                            if (updatedName.isNotEmpty) {
                                              final updatedStudent =
                                                  StudentModel(
                                                name: updatedName,
                                                age: updatedAge,
                                                Place: updatedPlace,
                                                number: updatedPhoneNumber,
                                                imagetemporary: _pickedImage!,
                                              );

                                              await updateStudent(
                                                  student.id! as int,
                                                  updatedStudent);
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text("Update"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            BottomNavigationBar(
              currentIndex: 0,
              onTap: (index) {
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => StudentListScreen()),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
