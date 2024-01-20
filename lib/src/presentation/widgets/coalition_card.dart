
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/src/config/app_assets.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';
import 'package:swifty_companion/src/utils/coalition_functions.dart';

class CoalitionCard extends StatelessWidget {
  final Coalition coalition;
  final double width;
  final double height;
  final bool first;
  final bool last;

  const CoalitionCard({
    super.key,
    required this.coalition,
    this.width = 144,
    this.height = 144,
    this.first = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 8),
      margin: EdgeInsets.only(top: 2, bottom: 2, left: first ? 0 : 8, right: last ? 0 : 8),
      decoration: BoxDecoration(
        color: getCoalitionColor(coalition.coalition),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(getCoalitionIcon(coalition.coalition), width: width / 4.2,),
              const SizedBox(width: 8,),
              Expanded(
                child: Text(getCoalitionTitle(coalition.coalition),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Text(tr("coalitions.score"),
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8,),
          Text(coalition.score.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );

    return SizedBox(
      width: width + 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(getCoalitionTitle(coalition.coalition),
            style: TextStyle(fontWeight: FontWeight.w800, color: getCoalitionColor(coalition.coalition), fontSize: 14),
            maxLines: 2,
            textAlign: TextAlign.center,
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
        ],
      ),
    );
  }
}