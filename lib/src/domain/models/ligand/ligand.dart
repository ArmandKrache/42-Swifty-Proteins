import 'package:equatable/equatable.dart';
import 'package:swifty_proteins/src/domain/models/atom.dart';
import 'package:swifty_proteins/src/domain/models/bond.dart';

class Ligand extends Equatable {
  final String name;
  final List<Atom> atoms;
  final List<Bond> bonds;

  const Ligand({
    required this.name,
    required this.atoms,
    required this.bonds,
  });


  factory Ligand.fromMap(Map<String, dynamic> map) {
    return Ligand(
      name: map['name'] ?? "",
      atoms: List<Atom>.from((map['atoms'] ?? []).map<dynamic>((element) {
        return Atom.fromMap(element);
      })),
      bonds: List<Bond>.from((map['bonds'] ?? []).map<dynamic>((element) {
        return Bond.fromMap(element);
      })),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name];

}
