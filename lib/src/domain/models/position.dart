import 'package:equatable/equatable.dart';

class Position extends Equatable {
  final double x;
  final double y;
  final double z;

  const Position({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [x, y, z];
}