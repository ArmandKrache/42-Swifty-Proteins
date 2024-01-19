import 'package:equatable/equatable.dart';
import 'package:swifty_companion/src/domain/models/cursus.dart';
import 'package:swifty_companion/src/domain/models/project.dart';

class StudentDetails extends Equatable {
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

  const StudentDetails({
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


  factory StudentDetails.fromMap(Map<String, dynamic> map) {
    Cursus cursus = Cursus.fromMap(const {});
    if (map['cursus_users'] != null) {
      Map<String, dynamic> res = (map['cursus_users']).singleWhere((element) => element['cursus_id'] == 21,
          orElse: () => Cursus.fromMap(const {})
      );
      cursus = Cursus.fromMap(res);
    }

    return StudentDetails(
      id: map['id'] ?? -1,
      email: map['email'] ?? "",
      login: map['login'] ?? "",
      displayName: map['displayname'] ?? "",
      phone: map['phone'] ?? "",
      picture: map['image']?['link'] ?? "",
      location: map['location'] ?? "Unavailable",
      wallet: map['wallet'] ?? 0,
      correctionPoints: map['correction_points'] ?? 0,
      cursus: cursus,
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