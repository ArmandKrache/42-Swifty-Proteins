import 'package:swifty_companion/src/domain/models/requests/breaking_news_request.dart';
import 'package:swifty_companion/src/domain/models/responses/breaking_news_response.dart';
import 'package:swifty_companion/src/utils/resources/data_state.dart';

abstract class ApiRepository {
  Future<DataState<BreakingNewsResponse>> getBreakingNewsArticles({
    required BreakingNewsRequest request,
  });
}