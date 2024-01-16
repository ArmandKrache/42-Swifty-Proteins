import 'package:swifty_companion/src/data/base/base_api_repository.dart';
import 'package:swifty_companion/src/data/api_service.dart';
import 'package:swifty_companion/src/domain/models/login_request.dart';
import 'package:swifty_companion/src/domain/models/login_response.dart';
import 'package:swifty_companion/src/domain/models/token_info_response.dart';
import 'package:swifty_companion/src/domain/repositories/api_repository.dart';
import 'package:swifty_companion/src/utils/constants.dart';
import 'package:swifty_companion/src/utils/resources/data_state.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final ApiService _apiService;

  ApiRepositoryImpl(this._apiService);

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

  @override
  Future<DataState<TokenInfoResponse>> getTokenInfo() {
    return getState0f<TokenInfoResponse>(request: () => _apiService.getTokenInfo());
  }

}