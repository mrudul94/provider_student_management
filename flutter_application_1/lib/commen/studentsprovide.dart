

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/servises/functions.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class StudentProvider with ChangeNotifier {
  List<StudentModel> _studentList = [];
  List<StudentModel> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  List<StudentModel> get searchResults => _searchResults;
    String _searchQuery = ''; // Define searchQuery variable

  String get searchQuery => _searchQuery; // Getter for searchQuery

  final ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier<List<StudentModel>>([]);

  void getAllStudents() async {
    _studentList = await getallstudent();
    studentListNotifier.value = _studentList;
  }
   void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void performSearch(String searchTerm) {
    if (searchTerm.isNotEmpty) {
      _searchResults = _studentList.where((student) => student.name.toLowerCase().contains(searchTerm.toLowerCase())).toList();
    } else {
      _searchResults.clear();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
    _searchResults.clear();
    notifyListeners();
  }

  

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Handle picked image
    }
  }

  // Future<void> deleteStudent(int id) async {
  //   // Delete student with provided id
  //   await deleteStudentById(id);
  //   // Refresh the student list
  //   getAllStudents();
  // }

  void signOut(BuildContext context) async {
    // Perform sign out action
    // Redirect to login screen
  }
}



