import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/servises/functions.dart';

import 'package:image_picker/image_picker.dart';

class AddStudentProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  String? imageTemporary;
  bool correctValidate = true;

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageTemporary = pickedImage.path;
      notifyListeners();
    }
  }

 Future<void> addStudents({
  required String name,
  required String age,
  required String place,
  required String number,
}) async {
  if (name.isEmpty || age.isEmpty || place.isEmpty || number.isEmpty) {
    return;
  }

  try {
    final student = StudentModel(
      name: name,
      age: age,
      Place: place,
      number: number,
      id: DateTime.now().millisecondsSinceEpoch.toInt(),
      imagetemporary: imageTemporary!,
    );

    await addStudent(student);

    imageTemporary = null;

    // Clear text controllers
    nameController.clear();
    ageController.clear();
    placeController.clear();
    numberController.clear();

    notifyListeners();
  } catch (e) {
    // Handle error here
    print('Error adding student: $e');
  }
}

}
