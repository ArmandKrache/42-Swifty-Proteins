import 'package:swifty_companion/src/data/base/base_api_repository.dart';
import 'package:swifty_companion/src/data/api_service.dart';
import 'package:swifty_companion/src/domain/models/requests/breaking_news_request.dart';
import 'package:swifty_companion/src/domain/models/requests/login_request.dart';
import 'package:swifty_companion/src/domain/models/responses/breaking_news_response.dart';
import 'package:swifty_companion/src/domain/models/responses/login_response.dart';
import 'package:swifty_companion/src/domain/repositories/api_repository.dart';
import 'package:swifty_companion/src/utils/constants/strings.dart';
import 'package:swifty_companion/src/utils/resources/data_state.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final ApiService _apiService;

  ApiRepositoryImpl(this._apiService);

  @override
  Future<DataState<BreakingNewsResponse>> getBreakingNewsArticles({
    required BreakingNewsRequest request
  }) {
    return getState0f<BreakingNewsResponse>(request: () => _apiService.getBreakingNewsArticles(
      country: request.country,
      category: request.category,
      page: request.page,
      pageSize: request.pageSize,
      authorization: defaultApiKey
    ));
  }

  @override
  Future<DataState<LoginResponse>> getTokens({
    required LoginRequest request
  }) {
    return getState0f<LoginResponse>(request: () => _apiService.getTokens(
        {
          "grant_type" : request.grant_type,
          "client_id" : request.client_id,
          "client_secret" : request.client_secret
        },
      ),
    );
  }

}