import 'package:auto_route/auto_route.dart';
import 'package:swifty_companion/src/config/router/app_router.dart';
import 'package:swifty_companion/src/domain/repositories/api_repository.dart';
import 'package:swifty_companion/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_companion/src/utils/resources/token_management.dart';

part 'homepage_state.dart';

class HomepageCubit extends BaseCubit<HomepageState, List<String>> {
  final ApiRepository _apiRepository;

  HomepageCubit(this._apiRepository) : super(const HomepageSuccess(), []);

  Future<void> getSomething() async {
    if (isBusy) return;

    await run(() async {
      /*final response = await _apiRepository.getBreakingNewsArticles(request: BreakingNewsRequest(page: _page));

      if (response is DataSuccess) {

        emit(HomepageSuccess());
      } else if (response is DataFailed) {
        emit(HomepageFailed(exception: response.exception));
      }*/
    });
  }

  Future<void> logOut() async {
    deleteTokens();
    appRouter.popUntil((route) => route.data?.name == "LoginRoute");
  }

}
