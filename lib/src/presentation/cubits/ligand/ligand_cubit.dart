import 'dart:developer';

import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/data/parsing/parser.dart';
import 'package:swifty_proteins/src/domain/models/coalition/coalition.dart';
import 'package:swifty_proteins/src/domain/models/ligand/ligand.dart';
import 'package:swifty_proteins/src/domain/models/login_request.dart';
import 'package:swifty_proteins/src/domain/models/student/student.dart';
import 'package:swifty_proteins/src/domain/models/student/student_details.dart';
import 'package:swifty_proteins/src/domain/repositories/api_repository.dart';
import 'package:swifty_proteins/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_proteins/src/utils/resources/data_state.dart';
import 'package:swifty_proteins/src/utils/resources/functions.dart';
import 'package:swifty_proteins/src/utils/resources/token_management.dart';

part 'ligand_state.dart';

class LigandCubit extends BaseCubit<LigandState, Ligand?> {
  final ApiRepository _apiRepository;
  Ligand? ligand;

  LigandCubit(this._apiRepository) : super(const LigandLoading(), null);


  Future<void> getLigand({String id = "HEM"}) async {
    if (isBusy) return;

    final response =
    await _apiRepository.getLigand(id);

    if (response is DataSuccess) {
      ligand = parseRawData(response.data);

      emit(LigandSuccess(ligand: ligand,));

    } else if (response is DataFailed) {
      logger.d(response.exception);
      emit(LigandFailed(exception: response.exception,));
    }
    return;
  }
}
