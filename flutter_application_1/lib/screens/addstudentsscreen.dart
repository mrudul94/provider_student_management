import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/commen/Addstudentprovider.dart';

import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:provider/provider.dart';

class ScreenAdd extends StatelessWidget {
  const ScreenAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<AddStudentProvider>(
          builder: (context, provider, _) {
            return Form(
              key: provider.formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: TextFormField(
                      controller: provider.nameController,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a Name';
                        } else if (value[0] == value[0].toLowerCase()) {
                          return 'Name first letter should be Capital';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: !provider.correctValidate,
                    child: const Text(
                      'Please enter a correct Name',
                      style: TextStyle(fontSize: 13, color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      controller: provider.ageController,
                      decoration: const InputDecoration(
                        hintText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter an Age';
                        } else if (value.length > 0 && value.length > 2) {
                          return 'Please enter your correct age';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: !provider.correctValidate,
                    child: const Text(
                      'Please enter your correct Age',
                      style: TextStyle(fontSize: 13, color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      controller: provider.placeController,
                      decoration: const InputDecoration(
                        hintText: 'Place',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a Place';
                        } else if (value[0] == value[0].toLowerCase()) {
                          return 'Place first letter should be Capital';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: !provider.correctValidate,
                    child: const Text(
                      'Please enter your correct Place',
                      style: TextStyle(fontSize: 13, color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      controller: provider.numberController,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a Phone Number';
                        } else if (value.length != 10) {
                          return 'Phone Number should contain 10 digits';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: !provider.correctValidate,
                    child: const Text(
                      'Please enter a correct Phone Number',
                      style: TextStyle(fontSize: 13, color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: provider.imageTemporary != null
                        ? Image.file(
                            File(provider.imageTemporary!),
                            height: 100,
                          )
                        : Image.network(
                            'https://www.w3schools.com/w3images/avatar2.png',
                            height: 100,
                          ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await provider.pickImage();
                    },
                    icon: const Icon(Icons.image_outlined),
                    label: const Text('Pick from Gallery'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (provider.formKey.currentState!.validate()) {
                        await provider.addStudents(
                          name: provider.nameController.text,
                          age: provider.ageController.text,
                          place: provider.placeController.text,
                          number: provider.numberController.text,
                        );

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const ScreenHome()),
                        );
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Student'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
