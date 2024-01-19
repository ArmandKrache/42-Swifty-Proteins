
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/src/config/app_assets.dart';
import 'package:swifty_companion/src/config/app_colors.dart';
import 'package:swifty_companion/src/config/config.dart';
import 'package:swifty_companion/src/domain/models/event/event.dart';

String _formatDateAndStartingHour(DateTime start) {
  return "${start.day}/${start.month}/${start.year} - ${start.hour}:${start.minute}${start.minute == 0 ? "0" : ""}";
}

String _formatDeltaBetweenStartAndEnd(DateTime start, DateTime end) {
  Duration delta = end.difference(start);
  if (delta.inHours < 2) {
    return "${delta.inMinutes} minutes";
  }
  return "${delta.inHours} hours";
}

class EventCardWidget extends StatelessWidget {
  final Event event;

  const EventCardWidget({
    super.key,
    required this.event
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.event;
    switch (event.kind) {
      case ("partnership"):
        borderColor = AppColors.eventPartnership;
        break;
      case ("association"):
        borderColor = AppColors.eventAssociation;
        break;
      case ("extern"):
        borderColor = AppColors.eventExtern;
        break;
    }


    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(4),
        color: borderColor.withOpacity(0.1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(text: TextSpan(
            children: [
              TextSpan(text: "${event.kind} - ", style: TextStyle(fontWeight: FontWeight.bold, color: borderColor),),
              TextSpan(text: event.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),),
            ],
          ),
          ),
          const SizedBox(height: 4,),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16,),
              Expanded(child: Text(event.location))
            ],
          ),
          const SizedBox(height: 4,),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 16,),
              Text(_formatDateAndStartingHour(event.start)),
              const Expanded(child: SizedBox()),
              const Icon(Icons.hourglass_empty_outlined, size: 16,),
              Text(_formatDeltaBetweenStartAndEnd(event.start, event.end)),
            ],
          ),
        ],
      ),
    );
  }
}