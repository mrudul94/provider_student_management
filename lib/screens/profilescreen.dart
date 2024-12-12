import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:flutter_application_1/servises/functions.dart';
import 'package:image_picker/image_picker.dart';

class ScreenProfile extends StatelessWidget {
  final student;
  const ScreenProfile({super.key, this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:150),
              child: CircleAvatar(
                radius: 90,
                       backgroundImage: FileImage(File(student.imagetemporary)),
              ),
            ),
          const  SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 100,bottom: 20),
              child: Text('Name  : ${student.name}',style:const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25 
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 90,bottom: 15),
              child: Text('Place : ${student.Place}',style:const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20
              ),),
            ), // Use lowercase 'place'
            Padding(
              padding: const EdgeInsets.only(left: 90,bottom: 15),
              child: Text('Age   : ${student.age.toString()}',style:const TextStyle(
               fontWeight: FontWeight.w300,
               fontSize:20 
              ),),
            ), 
            Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Text('Number: ${student.number}',style:const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20
              ),),
            ),
         const   SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                   
                  final TextEditingController nameController = TextEditingController(text: student.name);
     final TextEditingController ageController = TextEditingController(text: student.age);
 final TextEditingController placeController = TextEditingController(text: student.Place);
    final TextEditingController phoneNumberController = TextEditingController(text: student.number);
  //   final TextEditingController phoneNumberController = TextEditingController(text: student.imagetemporary);

  String? pickedImage0; // Variable to store the picked image path
     
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            title:const Text("Update Student"),
            content: ListView(
              children: [
                TextField(controller: nameController,decoration:const InputDecoration(labelText: "Name")),
                TextField(controller: ageController,decoration:const InputDecoration(labelText: "Age")),
                TextField(controller: placeController,decoration:const InputDecoration(labelText: "Place")),
                TextField(controller: phoneNumberController,decoration:const InputDecoration(labelText: "Phone Number")),
                ElevatedButton.icon(
                  onPressed: () async {
                    final imagePicker = ImagePicker();
                    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      setState(() {
                        pickedImage0 = pickedImage.path;
                      });
                    }
                    
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Update Profile Picture'),
                ),
                // Container to display picked image
                pickedImage0 != null
                    ? Container(
                        padding:const EdgeInsets.all(8.0),
                        child: Image.file(File(pickedImage0!)),
                      )
                      :Container(
                        padding:const EdgeInsets.all(8.0) ,
                        child:Image.file(File(student.imagetemporary)) ,
                      )

                    // : SizedBox(),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:const Text("Cancel"),
              ),
               TextButton(
          onPressed: () async {
            // updateStudent(data);
            final updatedName = nameController.text;
            final updatedAge = ageController.text;
            // final updatedAdmissionNumber = admissionNumberController.text;
            final updatedPlace = placeController.text;
            final updatedPhoneNumber = phoneNumberController.text;

            // String? updateProfilePicture = _pickedImage;
            // updatedProfilePicture = updatedProfilePicture;
                      if (updatedName.isNotEmpty) {
              final updatedStudent = StudentModel(
                name: updatedName,
                age: updatedAge,
                Place: updatedPlace,
                number: updatedPhoneNumber,
                imagetemporary:pickedImage0! ,
                // profilePicture: updatedProfilePicture,
              );

              await updateStudent(student.id! as int,updatedStudent);
             Navigator.pop(context);
            }
          },
          child:const Text("Update"),
        ),
            ],
          );
        },
      );
    },
  );
// }


                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black
                  ),
                  child:const Icon(Icons.edit),
                ),
             const    SizedBox(width: 20), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // Confirm and delete the profile
                   deleteStudent(student.id! as int);
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScreenHome()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Change button color to red
                  ),
                  child:const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
      )
    );
  }
}
