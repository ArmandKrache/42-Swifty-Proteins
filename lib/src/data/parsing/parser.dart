import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:swifty_proteins/src/config/app_assets.dart';
import 'package:swifty_proteins/src/domain/models/ligand/ligand.dart';
import 'package:swifty_proteins/src/utils/resources/functions.dart';


Future<List<String>> parseLigandNamesFile() async {

  try {
    String content = await rootBundle.loadString(AppAssets.ligandsNames);

    List<String> ligands = content.trim().split('\n');

    return ligands;
  } catch (e) {
    displayErrorToast(tr("errors.ligands_list_parsing"));
    return [];
  }

}

Future<Ligand> parseLigandFromFile(String path) async {

  String content = await rootBundle.loadString(path);
  Ligand res = parseRawData(content);

  return res;
}

Ligand parseRawData(String data) {
  List<String> lines = data.split('\n');
  Map<String, dynamic> parsedData = {};

  parsedData['name'] = lines[0];

  List<int> count = lines[3]
      .trim()
      .split(' ')
      .map((value) => int.tryParse(value) ?? 0)
      .toList();

  parsedData['atom_count'] = count[0];
  parsedData['bond_count'] = count[1];

  // Parsing atoms and bonds
  List<Map<String, dynamic>> atoms = [];
  List<Map<String, dynamic>> bonds = [];

  int startingIndex = 4;
  int endIndex = startingIndex + count[0];

  for (int i = startingIndex; i < endIndex; i++) {

    List<String> atomLine = lines[i].trim().split(RegExp(r"\s+"));
    atoms.add({
      'x': double.parse(atomLine[0]),
      'y': double.parse(atomLine[1]),
      'z': double.parse(atomLine[2]),
      'element': atomLine[3],
      // Add other properties as needed
    });
  }

  for (int i = endIndex; i < endIndex + count[1]; i++) {
    List<String> bondLine = lines[i].trim().split(RegExp(r"\s+"));
    bonds.add({
      'atom_1': int.parse(bondLine[0]),
      'atom_2': int.parse(bondLine[1]),
      'bond_type': int.parse(bondLine[2]),
      // Add other properties as needed
    });
  }

  parsedData['atoms'] = atoms;
  parsedData['bonds'] = bonds;

  return Ligand.fromMap(parsedData);
}
