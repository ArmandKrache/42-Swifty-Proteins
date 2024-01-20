import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  static String getProjectStatus(String state) {
    switch (state) {
      case ("finished"):
        return tr("projects.finished");
      case ("in_progress"):
        return tr("projects.in_progress");
      case ("waiting_for_correction"):
        return tr("projects.waiting_for_correction");
      case ("failed"):
        return tr("projects.failed");
      case ("searching_a_group"):
        return tr("projects.searching_a_group");
      default:
        return "";
    }
  }

  static String getEventKind(String kind) {
    switch (kind) {
      case ("association"):
        return tr("events.association");
      case ("event"):
        return tr("events.event");
      case ("extern"):
        return tr("events.extern");
      case ("partnership"):
        return tr("events.partnership");
      default:
        return "";
    }
  }
}