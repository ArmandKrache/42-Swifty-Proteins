import 'package:swifty_companion/src/domain/models/coalition/coalition_list_response.dart';
import 'package:swifty_companion/src/domain/models/event/event_list_response.dart';
import 'package:swifty_companion/src/domain/models/login_request.dart';
import 'package:swifty_companion/src/domain/models/login_response.dart';
import 'package:swifty_companion/src/domain/models/student/student.dart';
import 'package:swifty_companion/src/domain/models/student/student_details.dart';
import 'package:swifty_companion/src/domain/models/student/student_list_response.dart';
import 'package:swifty_companion/src/domain/models/token_info_response.dart';
import 'package:swifty_companion/src/utils/resources/data_state.dart';

abstract class ApiRepository {
  Future<DataState<LoginResponse>> getTokens({
    required LoginRequest request,
  });

  Future<DataState<TokenInfoResponse>> getTokenInfo();

  Future<DataState<StudentListResponse>> getStudentByLogin({
    required String login,
  });

  Future<DataState<StudentDetails>> getStudentDetails({
    required String id,
  });

  Future<DataState<CoalitionListResponse>> getCoalitions({
    required String id,
  });

  Future<DataState<EventListResponse>> getParisFutureEvents();

}