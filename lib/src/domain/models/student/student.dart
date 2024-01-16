import 'package:equatable/equatable.dart';
import 'package:swifty_companion/src/domain/models/cursus.dart';
import 'package:swifty_companion/src/domain/models/project.dart';

class Student extends Equatable {
  final int id;
  final String email;
  final String login;
  final String displayName;
  final String phone;
  final String picture;
  final String location;
  final int wallet;
  final int correctionPoints;
  final Cursus cursus;
  final List<Project> projects;

  const Student({
    required this.id,
    required this.email,
    required this.login,
    required this.displayName,
    required this.phone,
    required this.picture,
    required this.location,
    required this.wallet,
    required this.correctionPoints,
    required this.cursus,
    required this.projects,
  });


  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? -1,
      email: map['email'] ?? "",
      login: map['login'] ?? "",
      displayName: map['displayname'] ?? "",
      phone: map['phone'] ?? "",
      picture: map['image']['link'] ?? "",
      location: map['location'] ?? "",
      wallet: map['wallet'] ?? 0,
      correctionPoints: map['correction_points'] ?? 0,
      cursus: map['cursus_users'] ?? 0,
      projects: List<Project>.from((map['projects_users'] ?? []).map<dynamic>((element) {
        return Project.fromMap(element);
      })),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [login];

}