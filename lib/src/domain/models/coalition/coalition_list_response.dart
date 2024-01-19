import 'package:equatable/equatable.dart';
import 'package:swifty_companion/src/config/config.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';

class CoalitionListResponse extends Equatable {
  final List<Coalition> coalitions;


  const CoalitionListResponse({
    required this.coalitions,
  });


  factory CoalitionListResponse.fromMap(List<dynamic> items) {
    //logger.d(items);
    Map<String, dynamic> campus = items.first;
    return CoalitionListResponse(
      coalitions: List<Coalition>.from((campus["coalitions"]).map<dynamic>((element) {
        return Coalition.fromMap(element);
      }))..sort((a, b) => b.score - a.score),
    );
  }

  /*
  factory CoalitionListResponse.fromMap(Map<String, dynamic> items) {
    logger.d(items);
    return CoalitionListResponse(
      coalitions: List<Coalition>.from((items as List).map<dynamic>((element) {
        return Coalition.fromMap(element);
      })),
    );
  }*/

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [coalitions];

}