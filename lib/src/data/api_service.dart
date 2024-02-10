import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api.intra.42.fr/", parser: Parser.MapSerializable)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('https://files.rcsb.org/ligands/download/{id}_ideal.sdf')
  Future<HttpResponse<dynamic>> getLigand(@Path() String id);

}