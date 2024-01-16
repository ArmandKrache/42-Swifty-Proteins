import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final int id;
  final String name;
  final String description;
  final String location;
  final String kind;
  final int maxPeople;
  final int subscribers;
  final DateTime start;
  final DateTime end;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.kind,
    required this.maxPeople,
    required this.subscribers,
    required this.start,
    required this.end,
  });


  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? -1,
      name: map['name'] ?? "",
      description: map['score'] ?? "",
      location: map['location'] ?? "",
      kind: map['kind'] ?? "",
      maxPeople: map['max_people'] ?? -1,
      subscribers: map['subscribers'] ?? -1,
      start: map['begin_at'] == null ? DateTime.now() : DateTime.parse(map['begin_at']),
      end: map['end_at'] == null ? DateTime.now() : DateTime.parse(map['end_at']),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name];

}