import 'package:dio/dio.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/domain/models/login_request.dart';
import 'package:swifty_proteins/src/domain/repositories/api_repository.dart';
import 'package:swifty_proteins/src/locator.dart';
import 'package:swifty_proteins/src/utils/resources/data_state.dart';

Future<void> storeAccessToken(String token) async {
  await storage.write(key: 'access_token', value: token);
}

// Retrieve access token
Future<String?> getAccessToken() async {
  return await storage.read(key: 'access_token');
}

// Remove access token
Future<void> deleteTokens() async {
  await storage.delete(key: 'access_token');
}

Future<String?> refreshToken() async {
  final response = await locator<ApiRepository>().getTokens(request: LoginRequest(client_secret: "", client_id: ""));
  if (response is DataSuccess) {
    await storeAccessToken(response.data!.accessToken);
    return await getAccessToken();
  }
  return null;
}


class TokenInterceptor extends Interceptor {
  final Dio dio;
  final Map<Uri, bool> isRefreshing = {};

  TokenInterceptor() : dio = Dio();


  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  Future onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if (err.response?.statusCode == 401) {
      final originalRequest = err.requestOptions;
      final uri = originalRequest.uri;

      //logger.d(isRefreshing[uri]);

      if (isRefreshing[uri] == null) {
        isRefreshing[uri] = true;

        final refreshedAccessToken = await refreshToken();

        isRefreshing[uri] = false;

        if (refreshedAccessToken != null) {
          originalRequest.headers['Authorization'] = 'Bearer $refreshedAccessToken';

          try {
            final response = await dio.fetch(originalRequest);
            handler.resolve(response);
            isRefreshing.remove(uri);
            return;
          } catch (e) {
            /// Handle any errors during the retry, if needed
          }
        }
      }
    }
    super.onError(err, handler);
  }
}