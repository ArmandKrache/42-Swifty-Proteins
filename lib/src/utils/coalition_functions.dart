import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:swifty_proteins/src/config/app_assets.dart';
import 'package:swifty_proteins/src/config/app_colors.dart';
import 'package:swifty_proteins/src/domain/models/coalition/coalition.dart';

Color getCoalitionColor(CoalitionType coalition) {
  switch (coalition) {
    case CoalitionType.order:
      return AppColors.order;
    case CoalitionType.alliance:
      return AppColors.alliance;
    case CoalitionType.assembly:
      return AppColors.assembly;
    case CoalitionType.federation:
      return AppColors.federation;
  }
}

String getCoalitionBanner(CoalitionType coalition) {
  switch (coalition) {
    case CoalitionType.order:
      return AppAssets.orderBanner;
    case CoalitionType.alliance:
      return AppAssets.allianceBanner;
    case CoalitionType.assembly:
      return AppAssets.assemblyBanner;
    case CoalitionType.federation:
      return AppAssets.federationBanner;
  }
}

String getCoalitionIcon(CoalitionType coalition) {
  switch (coalition) {
    case CoalitionType.order:
      return AppAssets.orderIcon;
    case CoalitionType.alliance:
      return AppAssets.allianceIcon;
    case CoalitionType.assembly:
      return AppAssets.assemblyIcon;
    case CoalitionType.federation:
      return AppAssets.federationIcon;
  }
}

String getCoalitionBackground(CoalitionType coalition) {
  switch (coalition) {
    case CoalitionType.order:
      return AppAssets.orderBackground;
    case CoalitionType.alliance:
      return AppAssets.allianceBackground;
    case CoalitionType.assembly:
      return AppAssets.assemblyBackground;
    case CoalitionType.federation:
      return AppAssets.federationBackground;
  }
}

String getCoalitionTitle(CoalitionType coalition) {
  switch (coalition) {
    case CoalitionType.order:
      return tr("coalitions.order");
    case CoalitionType.alliance:
      return tr("coalitions.alliance");
    case CoalitionType.assembly:
      return tr("coalitions.assembly");
    case CoalitionType.federation:
      return tr("coalitions.federation");
  }
}