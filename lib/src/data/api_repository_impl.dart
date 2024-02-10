import 'package:swifty_proteins/src/data/base/base_api_repository.dart';
import 'package:swifty_proteins/src/data/api_service.dart';
import 'package:swifty_proteins/src/domain/repositories/api_repository.dart';
import 'package:swifty_proteins/src/utils/resources/data_state.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final ApiService _apiService;

  ApiRepositoryImpl(this._apiService);

  @override
  Future<DataState<dynamic>> getLigand(String id) {
    return getState0f<dynamic>(request: () => _apiService.getLigand(id));
  }
}