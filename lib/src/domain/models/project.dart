import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int id;
  final int mark;
  final String status;
  final int projectId;
  final String name;
  final int cursusId;

  const Project({
    required this.id,
    required this.mark,
    required this.status,
    required this.projectId,
    required this.name,
    required this.cursusId,
  });


  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] ?? -1,
      mark: map['final_mark'] ?? "",
      status: map['status'] ?? "",
      projectId: map['projectId'] ?? -1,
      name: map["project"]['name'] ?? "",
      cursusId: (map['cursus_ids'] as List).first ?? -1,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, mark];

}
