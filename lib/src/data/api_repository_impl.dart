import 'package:swifty_proteins/src/data/base/base_api_repository.dart';
import 'package:swifty_proteins/src/data/api_service.dart';
import 'package:swifty_proteins/src/domain/models/coalition/campus_coalitions_list_response.dart';
import 'package:swifty_proteins/src/domain/models/coalition/user_coalitions_list_response.dart';
import 'package:swifty_proteins/src/domain/models/event/event_list_response.dart';
import 'package:swifty_proteins/src/domain/models/login_request.dart';
import 'package:swifty_proteins/src/domain/models/login_response.dart';
import 'package:swifty_proteins/src/domain/models/student/student_details.dart';
import 'package:swifty_proteins/src/domain/models/student/student_list_response.dart';
import 'package:swifty_proteins/src/domain/models/token_info_response.dart';
import 'package:swifty_proteins/src/domain/repositories/api_repository.dart';
import 'package:swifty_proteins/src/utils/resources/data_state.dart';

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

  @override
  Future<DataState<dynamic>> getLigand(String id) {
    return getState0f<dynamic>(request: () => _apiService.getLigand(id));
  }
}