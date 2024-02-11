import 'package:easy_localization/easy_localization.dart';

class ElementsString {
  static String getElementName(String element) {
    switch (element) {
      case "C":
        return tr("elements.C");
      case "O":
        return tr("elements.O");
      case "F":
        return tr("elements.F");
      case "N":
        return tr("elements.N");
      case "H":
        return tr("elements.H");
      case "S":
        return tr("elements.S");
      case "Br":
        return tr("elements.Br");
      case "Cl":
        return tr("elements.Cl");
      case "B":
        return tr("elements.B");
      case "P":
      return tr("elements.P");
      default:
        return element;
    }
  }

  static String getElementDetails(String element) {
    switch (element) {
      case "C":
        return tr("elements.descriptions.C");
      case "O":
        return tr("elements.descriptions.O");
      case "F":
        return tr("elements.descriptions.F");
      case "N":
        return tr("elements.descriptions.N");
      case "H":
        return tr("elements.descriptions.H");
      case "S":
        return tr("elements.descriptions.S");
      case "Br":
        return tr("elements.descriptions.Br");
      case "Cl":
        return tr("elements.descriptions.Cl");
      case "B":
        return tr("elements.descriptions.B");
      case "P":
        return tr("elements.descriptions.P");
      default:
        return tr("elements.descriptions.no_description");
    }
  }
}
