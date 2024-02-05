import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/domain/models/coalition/campus_coalitions_list_response.dart';
import 'package:swifty_proteins/src/domain/models/coalition/user_coalitions_list_response.dart';
import 'package:swifty_proteins/src/domain/models/event/event_list_response.dart';
import 'package:swifty_proteins/src/domain/models/login_response.dart';
import 'package:swifty_proteins/src/domain/models/student/student.dart';
import 'package:swifty_proteins/src/domain/models/student/student_details.dart';
import 'package:swifty_proteins/src/domain/models/student/student_list_response.dart';
import 'package:swifty_proteins/src/domain/models/token_info_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api.intra.42.fr/", parser: Parser.MapSerializable)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('oauth/token')
  Future<HttpResponse<LoginResponse>> getTokens(@Body() Map<String, dynamic> credentials);

  @GET('oauth/token/info')
  Future<HttpResponse<TokenInfoResponse>> getTokenInfo();

  @GET('https://files.rcsb.org/ligands/download/{id}_ideal.sdf')
  Future<HttpResponse<dynamic>> getLigand(@Path() String id);

}