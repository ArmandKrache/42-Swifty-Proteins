// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff2eb8bb);
  static const Color alert = Color(0xffE31B1B);
  static const Color valid = Color(0xff66CC7D);

  static const Color order = Color(0xffed7259);
  static const Color alliance = Color(0xff63c185);
  static const Color assembly = Color(0xff9764cb);
  static const Color federation = Color(0xff517fd4);


  static const Color event = Color(0xff00babd);
  static const Color eventAssociation = Color(0xff8b9ce1);
  static const Color eventPartnership = Color(0xffe57165);
  static const Color eventExtern   = Color(0xffb0a7a7);

  static const Color projectInProgress = Color(0xffeda451);
  static const Color projectFinished = valid;
  static const Color projectFailed = alert;
  static const Color projectSearching = primary;

}

class ElementColors {
  static const Map<String, Color> _elementColorMap = {
    "H" : Color(0xffFFFFFF),
    "D" : Color(0xffFFFFC0),
    "H2" : Color(0xffFFFFC0),
    "T" : Color(0xffFFFFA0),
    "H3" : Color(0xffFFFFA0),
    "He"	: Color(0xffD9FFFF),
    "Li"	: Color(0xffCC80FF),
    "Be"	: Color(0xffC2FF00),
    "B"	: Color(0xffFFB5B5),
    "C"	: Color(0xff909090),
    "C13"	: Color(0xff505050),
    "C14"	: Color(0xff404040),
    "N"	: Color(0xff3050F8),
    "N15"	: Color(0xff105050),
    "O"	: Color(0xffFF0D0D),
    "F"	: Color(0xff90E050),
    "Ne"	: Color(0xffB3E3F5),
    "Na"	: Color(0xffAB5CF2),
    "Mg"	: Color(0xff8AFF00),
    "Al"	: Color(0xffBFA6A6),
    "Si"	: Color(0xffF0C8A0),
    "P"	: Color(0xffFF8000),
    "S"	: Color(0xffFFFF30),
    "Cl"	: Color(0xff1FF01F),
    "Ar"	: Color(0xff80D1E3),
    "K"	: Color(0xff8F40D4),
    "Ca"	: Color(0xff3DFF00),
    "Sc"	: Color(0xffE6E6E6),
    "Ti"	: Color(0xffBFC2C7),
    "V"	: Color(0xffA6A6AB),
    "Cr"	: Color(0xff8A99C7),
    "Mn"	: Color(0xff9C7AC7),
    "Fe"	: Color(0xffE06633),
    "Co"	: Color(0xffF090A0),
    "Ni"	: Color(0xff50D050),
    "Cu"	: Color(0xffC88033),
    "Zn"	: Color(0xff7D80B0),
    "Ga"	: Color(0xffC28F8F),
    "Ge"	: Color(0xff668F8F),
    "As"	: Color(0xffBD80E3),
    "Se"	: Color(0xffFFA100),
    "Br"	: Color(0xffA62929),
    "Kr"	: Color(0xff5CB8D1),
    "Rb"	: Color(0xff702EB0),
    "Sr"	: Color(0xff00FF00),
    "Y"	: Color(0xff94FFFF),
    "Zr"	: Color(0xff94E0E0),
    "Nb"	: Color(0xff73C2C9),
    "Mo"	: Color(0xff54B5B5),
    "Tc"	: Color(0xff3B9E9E),
    "Ru"	: Color(0xff248F8F),
    "Rh"	: Color(0xff0A7D8C),
    "Pd"	: Color(0xff006985),
    "Ag"	: Color(0xffC0C0C0),
    "Cd"	: Color(0xffFFD98F),
    "In"	: Color(0xffA67573),
    "Sn"	: Color(0xff668080),
    "Sb"	: Color(0xff9E63B5),
    "Te"	: Color(0xffD47A00),
    "I"	: Color(0xff940094),
    "Xe"	: Color(0xff429EB0),
    "Cs"	: Color(0xff57178F),
    "Ba"	: Color(0xff00C900),
    "La"	: Color(0xff70D4FF),
    "Ce"	: Color(0xffFFFFC7),
    "Pr"	: Color(0xffD9FFC7),
    "Nd"	: Color(0xffC7FFC7),
    "Pm"	: Color(0xffA3FFC7),
    "Sm"	: Color(0xff8FFFC7),
    "Eu"	: Color(0xff61FFC7),
    "Gd"	: Color(0xff45FFC7),
    "Tb"	: Color(0xff30FFC7),
    "Dy"	: Color(0xff1FFFC7),
    "Ho"	: Color(0xff00FF9C),
    "Er"	: Color(0xff00E675),
    "Tm"	: Color(0xff00D452),
    "Yb"	: Color(0xff00BF38),
    "Lu"	: Color(0xff00AB24),
    "Hf"	: Color(0xff4DC2FF),
    "Ta"	: Color(0xff4DA6FF),
    "W"	: Color(0xff2194D6),
    "Re"	: Color(0xff267DAB),
    "Os"	: Color(0xff266696),
    "Ir"	: Color(0xff175487),
    "Pt"	: Color(0xffD0D0E0),
    "Au"	: Color(0xffFFD123),
    "Hg"	: Color(0xffB8B8D0),
    "Tl"	: Color(0xffA6544D),
    "Pb"	: Color(0xff575961),
    "Bi"	: Color(0xff9E4FB5),
    "Po"	: Color(0xffAB5C00),
    "At"	: Color(0xff754F45),
    "Rn"	: Color(0xff428296),
    "Fr"	: Color(0xff420066),
    "Ra"	: Color(0xff007D00),
    "Ac"	: Color(0xff70ABFA),
    "Th"	: Color(0xff00BAFF),
    "Pa"	: Color(0xff00A1FF),
    "U"	: Color(0xff008FFF),
    "Np"	: Color(0xff0080FF),
    "Pu"	: Color(0xff006BFF),
    "Am"	: Color(0xff545CF2),
    "Cm"	: Color(0xff785CE3),
    "Bk"	: Color(0xff8A4FE3),
    "Cf"	: Color(0xffA136D4),
    "Es"	: Color(0xffB31FD4),
    "Fm"	: Color(0xffB31FBA),
    "Md"	: Color(0xffB30DA6),
    "No"	: Color(0xffBD0D87),
    "Lr"	: Color(0xffC70066),
    "Rf"	: Color(0xffCC0059),
    "Db"	: Color(0xffD1004F),
    "Sg"	: Color(0xffD90045),
    "Bh"	: Color(0xffE00038),
    "Hs"	: Color(0xffE6002E),
    "Mt"	: Color(0xffEB0026),
  };

  static Color getColorFromString(String element) {
    final elementUpperCase = element.toUpperCase();

    if (_elementColorMap.containsKey(elementUpperCase)) {
      return _elementColorMap[elementUpperCase]!;
    } else {
      return _elementColorMap["H"]!;
    }
  }
}