import 'package:swifty_companion/src/domain/models/responses/breaking_news_response.dart';
import 'package:swifty_companion/src/domain/models/responses/login_response.dart';
import 'package:swifty_companion/src/utils/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/top-headlines')
  Future<HttpResponse<BreakingNewsResponse>> getBreakingNewsArticles({
    @Query("country") String? country,
    @Query("category") String? category,
    @Query("page") int? page,
    @Query("pageSize") int? pageSize,
    @Header("Authorization") String? authorization
  });

  @POST('https://api.intra.42.fr/oauth/token')
  Future<HttpResponse<LoginResponse>> getTokens(@Body() Map<String, dynamic> credentials);
}