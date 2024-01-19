import 'package:equatable/equatable.dart';

class Cursus extends Equatable {
  final int level;
  final String grade;
  final List<Skill> skills;

  const Cursus({
    required this.level,
    required this.grade,
    required this.skills,
  });


  factory Cursus.fromMap(Map<String, dynamic> map) {
    return Cursus(
      level: map['level'] ?? -1,
      grade: map['grade'] ?? "",
      skills: map['login'] ?? "",
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [grade, level];

}

class Skill extends Equatable {
  final int id;
  final double level;
  final String name;

  const Skill({
    required this.id,
    required this.level,
    required this.name,
  });


  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      id: map['id'] ?? -1,
      level: map['level'] ?? 0.0,
      name: map['name'] ?? "",
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, level];

}