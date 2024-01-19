
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/src/config/app_assets.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';
import 'package:swifty_companion/src/utils/coalition_functions.dart';

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

    return SizedBox(
      width: width + 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: titleVisibility,
            child: Text(getCoalitionTitle(coalition.coalition),
              style: TextStyle(fontWeight: FontWeight.w800, color: getCoalitionColor(coalition.coalition), fontSize: 14),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                Center(child: SvgPicture.asset(getCoalitionBanner(coalition.coalition), width: width,)),
                Center(child: SvgPicture.asset(getCoalitionIcon(coalition.coalition), width: width / 1.618,)),
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
              style: TextStyle(fontWeight: FontWeight.w800, color: getCoalitionColor(coalition.coalition), fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}