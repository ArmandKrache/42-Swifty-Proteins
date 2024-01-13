import 'package:swifty_companion/src/data/datasources/remote/base/base_api_repository.dart';
import 'package:swifty_companion/src/data/datasources/remote/news_api_service.dart';
import 'package:swifty_companion/src/domain/models/requests/breaking_news_request.dart';
import 'package:swifty_companion/src/domain/models/responses/breaking_news_response.dart';
import 'package:swifty_companion/src/domain/repositories/api_repository.dart';
import 'package:swifty_companion/src/utils/constants/strings.dart';
import 'package:swifty_companion/src/utils/resources/data_state.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final NewsApiService _newsApiService;

  ApiRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<BreakingNewsResponse>> getBreakingNewsArticles({
    required BreakingNewsRequest request
  }) {
    return getState0f<BreakingNewsResponse>(request: () => _newsApiService.getBreakingNewsArticles(
      country: request.country,
      category: request.category,
      page: request.page,
      pageSize: request.pageSize,
      authorization: defaultApiKey
    ));
  }
}