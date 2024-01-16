import 'package:swifty_companion/src/domain/models/login_response.dart';
import 'package:swifty_companion/src/domain/models/token_info_response.dart';
import 'package:swifty_companion/src/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('https://api.intra.42.fr/oauth/token')
  Future<HttpResponse<LoginResponse>> getTokens(@Body() Map<String, dynamic> credentials);

  @GET('https://api.intra.42.fr/oauth/token/info')
  Future<HttpResponse<TokenInfoResponse>> getTokenInfo();
}