import 'package:equatable/equatable.dart';
import 'package:swifty_proteins/src/domain/models/position.dart';

class Atom extends Equatable {
  final Position position;
  final String element;


  const Atom({
    required this.position,
    required this.element,
  });


  factory Atom.fromMap(Map<String, dynamic> map) {
    return Atom(
      element: map['element'] ?? "",
      position: Position(x: map["x"] ?? 0.0, y: map["y"] ?? 0.0, z: map["z"] ?? 0.0,)
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [element, position];

}
