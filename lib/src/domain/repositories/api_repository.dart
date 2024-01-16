import 'package:swifty_companion/src/domain/models/login_request.dart';
import 'package:swifty_companion/src/domain/models/login_response.dart';
import 'package:swifty_companion/src/domain/models/token_info_response.dart';
import 'package:swifty_companion/src/utils/resources/data_state.dart';

abstract class ApiRepository {
  Future<DataState<LoginResponse>> getTokens({
    required LoginRequest request,
  });

  Future<DataState<TokenInfoResponse>> getTokenInfo();
}