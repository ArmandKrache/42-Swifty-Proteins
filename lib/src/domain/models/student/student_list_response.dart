import 'package:equatable/equatable.dart';
import 'package:swifty_proteins/src/domain/models/coalition/coalition.dart';
import 'package:swifty_proteins/src/domain/models/event/event.dart';
import 'package:swifty_proteins/src/domain/models/student/student.dart';

class StudentListResponse extends Equatable {
  final List<Student> students;


  const StudentListResponse({
    required this.students,
  });


  factory StudentListResponse.fromMap(List<dynamic> items) {
    return StudentListResponse(
      students: List<Student>.from((items).map<dynamic>((element) {
        return Student.fromMap(element);
      })),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [students];

}