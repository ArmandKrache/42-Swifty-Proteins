
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/src/config/app_assets.dart';
import 'package:swifty_companion/src/config/app_colors.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';
import 'package:swifty_companion/src/utils/constants.dart';

class CoalitionBannerWidget extends StatelessWidget {
  final Coalition coalition;
  final double width;
  final double height;
  final bool titleVisibility;
  final bool scoreVisibility;

  const CoalitionBannerWidget({
    super.key,
    required this.coalition,
    this.width = 96,
    this.height = 128,
    this.titleVisibility = true,
    this.scoreVisibility = true,
  });

  @override
  Widget build(BuildContext context) {
    String banner = "";
    String icon = "";
    Color color = AppColors.order;
    String title = "";

    switch (coalition.coalition) {
      case (CoalitionType.order):
        banner = AppAssets.orderBanner;
        icon = AppAssets.orderIcon;
        color = AppColors.order;
        title = orderTitle;
        break;
      case (CoalitionType.alliance):
        banner = AppAssets.allianceBanner;
        icon = AppAssets.allianceIcon;
        color = AppColors.alliance;
        title = allianceTitle;
        break;
      case (CoalitionType.assembly):
        banner = AppAssets.assemblyBanner;
        icon = AppAssets.assemblyIcon;
        color = AppColors.assembly;
        title = assemblyTitle;
        break;
      case (CoalitionType.federation):
        banner = AppAssets.federationBanner;
        icon = AppAssets.federationIcon;
        color = AppColors.federation;
        title = federationTitle;
        break;
      default:
        banner = AppAssets.orderBanner;
        icon = AppAssets.orderIcon;
        color = AppColors.order;
        title = orderTitle;
    }

    return SizedBox(
      width: width + 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: titleVisibility,
            child: Text(title,
              style: TextStyle(fontWeight: FontWeight.w800, color: color, fontSize: 14),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                Center(child: SvgPicture.asset(banner, width: width,)),
                Center(child: SvgPicture.asset(icon, width: width / 1.618,)),
              ],
            ),
          ),
          const SizedBox(height: 8,),
          Visibility(
            visible: scoreVisibility,
            child: const Text("Score",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Visibility(
            visible: scoreVisibility,
            child: Text(coalition.score.toString(),
              style: TextStyle(fontWeight: FontWeight.w800, color: color, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}