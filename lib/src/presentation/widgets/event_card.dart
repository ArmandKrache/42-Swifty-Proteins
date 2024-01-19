
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/src/config/app_assets.dart';
import 'package:swifty_companion/src/config/app_colors.dart';
import 'package:swifty_companion/src/domain/models/event/event.dart';
import 'package:swifty_companion/src/utils/constants.dart';

class EventCardWidget extends StatelessWidget {
  /*final Event event;*/

  const EventCardWidget({
    super.key,
    /*required this.event*/
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 2),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.event),
        borderRadius: BorderRadius.circular(4)
      ),
      child: const Column(
        children: [
          Text("[42Entrepreneurs] Soirée Pizza Start-up 🍕 Spécial FinTech"),
          SizedBox(height: 4,),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 16,),
              Text("BESS Les Garages")
            ],
          ),
          SizedBox(height: 4,),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 16,),
              Text("15 Janvier - 5h87"),
              Expanded(child: SizedBox()),
              Icon(Icons.hourglass_empty_outlined, size: 16,),
              Text("4 heures"),
            ],
          ),
        ],
      ),
    );
  }
}