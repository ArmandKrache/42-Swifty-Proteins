import 'package:auto_route/auto_route.dart';

import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/data/parsing/parser.dart';
import 'package:swifty_proteins/src/domain/repositories/api_repository.dart';
import 'package:swifty_proteins/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_proteins/src/utils/resources/authentication_service.dart';
part 'homepage_state.dart';

class HomepageCubit extends BaseCubit<HomepageState, List<String>> {
  final ApiRepository _apiRepository;
  List<String> ligands = [];

  HomepageCubit(this._apiRepository) : super(const HomepageLoading(), []);

  Future<void> rebuild() async {
    emit(HomepageLoading(ligands: ligands));
    emit(HomepageSuccess(ligands: ligands));
  }

  Future<void> initData() async {
    if (isBusy) return;
    emit(const HomepageLoading());

    ligands = await parseLigandNamesFile();

    emit(HomepageSuccess(ligands: ligands,));
    return;
  }

  Future<void> logOut() async {
    removeCurrentUser();
    appRouter.popUntil((route) => route.data?.name == "LoginRoute");
  }

}
