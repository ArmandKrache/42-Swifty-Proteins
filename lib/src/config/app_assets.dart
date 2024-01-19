import 'package:swifty_companion/src/config/app_colors.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';

class AppAssets {
  static const String white42LogoSVG = "assets/images/42_logo.svg";

  static const String orderBackground = "assets/images/bg_order.jpg";
  static const String allianceBackground = "assets/images/bg_alliance.jpeg";
  static const String federationBackground = "assets/images/bg_federation.jpeg";
  static const String assemblyBackground = "assets/images/bg_assembly.jpeg";
  static const String allianceBanner = "assets/images/banner_alliance.svg";
  static const String assemblyBanner = "assets/images/banner_assembly.svg";
  static const String orderBanner = "assets/images/banner_order.svg";
  static const String federationBanner = "assets/images/banner_federation.svg";
  static const String allianceIcon = "assets/images/icon_alliance.svg";
  static const String assemblyIcon = "assets/images/icon_assembly.svg";
  static const String orderIcon = "assets/images/icon_order.svg";
  static const String federationIcon = "assets/images/icon_federation.svg";


  static getCoalitionColor(CoalitionType coalition) {
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

  static getCoalitionBanner(CoalitionType coalition) {
    switch (coalition) {
      case CoalitionType.order:
        return orderBanner;
      case CoalitionType.alliance:
        return allianceBanner;
      case CoalitionType.assembly:
        return assemblyBanner;
      case CoalitionType.federation:
        return federationBanner;
    }
  }

  static getCoalitionIcon(CoalitionType coalition) {
    switch (coalition) {
      case CoalitionType.order:
        return orderIcon;
      case CoalitionType.alliance:
        return allianceIcon;
      case CoalitionType.assembly:
        return assemblyIcon;
      case CoalitionType.federation:
        return federationIcon;
    }
  }

  static getCoalitionBackground(CoalitionType coalition) {
    switch (coalition) {
      case CoalitionType.order:
        return orderBackground;
      case CoalitionType.alliance:
        return allianceBackground;
      case CoalitionType.assembly:
        return assemblyBackground;
      case CoalitionType.federation:
        return federationBackground;
    }
  }

  static getCoalitionTitle(CoalitionType coalition) {
    switch (coalition) {
      case CoalitionType.order:
        return "Order";
      case CoalitionType.alliance:
        return "Alliance";
      case CoalitionType.assembly:
        return "Assembly";
      case CoalitionType.federation:
        return "Federation";
    }
  }
}