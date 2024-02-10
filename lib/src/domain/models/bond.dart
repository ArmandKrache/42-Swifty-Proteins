import 'package:equatable/equatable.dart';

class Bond extends Equatable {
  final int atom1;
  final int atom2;
  final int type;


  const Bond({
    required this.atom1,
    required this.atom2,
    required this.type,
  });


  factory Bond.fromMap(Map<String, dynamic> map) {
    return Bond(
        atom1: map['atom_1'] ?? 1,
        atom2: map['atom_2'] ?? 1,
        type: map['bond_type'] ?? 1,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [atom1, atom2, type];

}
