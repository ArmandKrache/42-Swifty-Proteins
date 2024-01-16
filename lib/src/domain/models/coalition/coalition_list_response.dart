import 'package:equatable/equatable.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';

class CoalitionListResponse extends Equatable {
  final List<Coalition> coalitions;


  const CoalitionListResponse({
    required this.coalitions,
  });


  factory CoalitionListResponse.fromMap(List<Map<String, dynamic>> items) {
    return CoalitionListResponse(
      coalitions: List<Coalition>.from((items).map<dynamic>((element) {
        return Coalition.fromMap(element);
      })),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [coalitions];

}