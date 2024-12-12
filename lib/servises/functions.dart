import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> studentlistnotifair = ValueNotifier([]);
late Database _db;
Future<void> initializedatabase() async {
  _db = await openDatabase('studend.db', version: 2,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE student (id INTEGER PRYMARY KEY, name TEXT, age TEXT, place TEXT, number TEXT , imageTemporary TEXT)');
  });
}

Future<void> addStudent(StudentModel value) async {
  await _db.rawInsert(
      'INSERT INTO student (name,age,place,number,id,imageTemporary) VALUES (?,?,?,?,?,?) ',
      [
        value.name,
        value.age,
        value.Place,
        value.number,
        value.id,
        value.imagetemporary
      ]);
  getallstudent();
}

Future getallstudent() async {
  final values = await _db.rawQuery('SELECT * FROM student');
  print(values);
  studentlistnotifair.value.clear();

  values.forEach((Map) {
    final student = StudentModel.fromMap(Map);
    studentlistnotifair.value.add(student);

  });

  // ignore: invalid_use_of_protected_member
  studentlistnotifair.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
  studentlistnotifair.notifyListeners();
  await getallstudent();
}

Future<void> updateStudent(int id, StudentModel updatedStudent) async {
  final updatedStudend = updatedStudent;

  await _db.rawUpdate(
    'UPDATE student SET name = ?, age = ?, place = ?, number = ?, imagetemporary = ? WHERE id = ?',
    [
      updatedStudend.name,
      updatedStudend.age,
      updatedStudend.Place,
      updatedStudend.number,
      updatedStudend.imagetemporary,
      id,
    ],
  );
  await getallstudent();
}