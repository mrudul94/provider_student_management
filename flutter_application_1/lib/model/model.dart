import 'dart:io';

class StudentModel{
   int? id;
   String name;
   String age;
   String Place;
   String number;
   String imagetemporary;
 


  StudentModel({
   required this.name,
   required this. Place,
   required this.number,
   required this.age ,
   required this.imagetemporary,
   this.id,
   });

   static StudentModel fromMap(Map<String, Object?> map){
    final id =map['id'] as int;
    final name =map['name'] as String;
    final age = map['age'] as String;
    final place =map['place'] as String;
    final number= map['number'] as String;
    final imagetemparary =map['imageTemporary'] as String ;

   return StudentModel(id: id ,name: name, number: number, age: age, Place: place,imagetemporary: imagetemparary);
   }
   

 
}