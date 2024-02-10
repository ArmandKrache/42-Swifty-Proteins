import 'package:equatable/equatable.dart';
import 'package:three_dart/three_dart.dart' as three;


class Atom extends Equatable {
  //final Position position;
  final String element;
  final three.Vector3 position;


  const Atom({
    //required this.position,
    required this.element,
    required this.position,
  });


  factory Atom.fromMap(Map<String, dynamic> map) {
    return Atom(
      element: map['element'] ?? "",
      position: three.Vector3(map["x"] ?? 0.0, map["y"] ?? 0.0, map["z"] ?? 0.0),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [element, position];

}
