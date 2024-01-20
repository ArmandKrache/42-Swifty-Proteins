import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff2eb8bb);
  static const Color alert = Color(0xffbe464c);

  static const Color order = Color(0xffed7259);
  static const Color alliance = Color(0xff63c185);
  static const Color assembly = Color(0xff9764cb);
  static const Color federation = Color(0xff517fd4);


  static const Color event = Color(0xff00babd);
  static const Color eventAssociation = Color(0xff8b9ce1);
  static const Color eventPartnership = Color(0xffe57165);
  static const Color eventExtern   = Color(0xffb0a7a7);

  static const Color projectInProgress = Color(0xff63c185);
  static const Color projectFinished = primary;
  static const Color projectFailed = alert;
  static const Color projectSearching = Color(0xffb0a7a7);

}

Color getProjectColor(String state) {
  switch (state) {
    case ("finished"):
      return AppColors.projectFinished;
    case ("in_progress"):
      return AppColors.projectInProgress;
    case ("waiting_for_correction"):
      return AppColors.projectInProgress;
    case ("failed"):
      return AppColors.projectFailed;
    case ("searching_a_group"):
      return AppColors.projectSearching;
    default:
      return AppColors.primary;
  }
}