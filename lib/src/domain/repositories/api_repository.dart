import 'package:swifty_proteins/src/domain/models/coalition/campus_coalitions_list_response.dart';
import 'package:swifty_proteins/src/domain/models/coalition/user_coalitions_list_response.dart';
import 'package:swifty_proteins/src/domain/models/event/event_list_response.dart';
import 'package:swifty_proteins/src/domain/models/login_request.dart';
import 'package:swifty_proteins/src/domain/models/login_response.dart';
import 'package:swifty_proteins/src/domain/models/student/student.dart';
import 'package:swifty_proteins/src/domain/models/student/student_details.dart';
import 'package:swifty_proteins/src/domain/models/student/student_list_response.dart';
import 'package:swifty_proteins/src/domain/models/token_info_response.dart';
import 'package:swifty_proteins/src/utils/resources/data_state.dart';

abstract class ApiRepository {
  Future<DataState<LoginResponse>> getTokens({
    required LoginRequest request,
  });

  Future<DataState<TokenInfoResponse>> getTokenInfo();

  Future<DataState<dynamic>> getLigand(String id);

}