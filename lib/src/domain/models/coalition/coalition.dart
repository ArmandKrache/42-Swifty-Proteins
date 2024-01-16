import 'package:equatable/equatable.dart';

enum CoalitionType {
  order,
  assembly,
  alliance,
  federation
}

class Coalition extends Equatable {
  final int id;
  final String name;
  final int score;
  final CoalitionType coalition;

  const Coalition({
    required this.id,
    required this.name,
    required this.score,
    required this.coalition,
  });


  factory Coalition.fromMap(Map<String, dynamic> map) {
    CoalitionType coalition = CoalitionType.order;
    switch (map["name"]) {
      case ("The Federation"):
        coalition = CoalitionType.federation;
        break;
      case ("The Order"):
        coalition = CoalitionType.order;
        break;
      case ("The Assembly"):
        coalition = CoalitionType.alliance;
        break;
      case ("The Alliance"):
        coalition = CoalitionType.assembly;
        break;
    }

    return Coalition(
      id: map['id'] ?? -1,
      name: map['name'] ?? "",
      score: map['score'] ?? 0,
      coalition: coalition,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, score];

}