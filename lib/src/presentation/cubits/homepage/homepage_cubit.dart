import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:swifty_companion/src/config/config.dart';
import 'package:swifty_companion/src/config/router/app_router.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';
import 'package:swifty_companion/src/domain/models/event/event.dart';
import 'package:swifty_companion/src/domain/models/student/student.dart';
import 'package:swifty_companion/src/domain/repositories/api_repository.dart';
import 'package:swifty_companion/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_companion/src/utils/resources/data_state.dart';
import 'package:swifty_companion/src/utils/resources/functions.dart';
import 'package:swifty_companion/src/utils/resources/token_management.dart';

part 'homepage_state.dart';

class HomepageCubit extends BaseCubit<HomepageState, List<String>> {
  final ApiRepository _apiRepository;
  List<Coalition> coalitions = [];
  List<Event> events = [];
  List<Student> students = [];

  HomepageCubit(this._apiRepository) : super(const HomepageLoading(), []);

  Future<void> fetchData() async {
    if (isBusy) return;
    emit(const HomepageLoading());

    coalitions = await fetchParisCoalitions() ?? [];
    events = await fetchParisFutureEvents() ?? [];

    emit(HomepageSuccess(events: events, coalitions: coalitions));

    return;
  }

  Future<void> searchStudent({required String query}) async {
    if (isBusy || query == "") return;

    await run(() async {
      emit(HomepageSearchLoading(coalitions: coalitions, events: events, students: students));
      final response = await _apiRepository.getStudentByLogin(login: query);

      if (response is DataSuccess) {
        //logger.d(response.data);
        students = response.data!.students;
        emit(HomepageSuccess(coalitions: coalitions, events: events, students: students));
      } else if (response is DataFailed) {
        //logger.d(response.exception);
        displayErrorToast('Failed search.\nError ${response.exception?.response?.statusCode}',);
        emit(HomepageSearchFailed(exception: response.exception));
      }
    });
  }

  Future<void> getStudentDetails() async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.getStudentDetails(id: "40550");

      if (response is DataSuccess) {
        logger.d(response.data);
        emit(const HomepageSuccess());
      } else if (response is DataFailed) {
        //logger.d(response.exception);
        displayErrorToast('Couln\'t retrive student details.\nError ${response.exception?.response?.statusCode}',);
        emit(HomepageSearchFailed(exception: response.exception));
      }
    });
  }

  Future<List<Coalition>?> fetchParisCoalitions() async {
    if (isBusy) return null;

    final response = await _apiRepository.getCoalitions(id: "16");

    if (response is DataSuccess) {
      return response.data!.coalitions;
    } else if (response is DataFailed) {
      displayErrorToast('Couldn\'t load Coalitions.\nError ${response.exception?.response?.statusCode}',);
      emit(HomepageCoalitionsFailed(exception: response.exception));
    }
    return null;
  }

  Future<List<Event>?> fetchParisFutureEvents() async {
    if (isBusy) return null;

    final response = await _apiRepository.getParisFutureEvents();

    if (response is DataSuccess) {
      logger.d(response.data);
      return response.data!.events;
    } else if (response is DataFailed) {
      displayErrorToast('Couldn\'t load Events.\nError ${response.exception?.response?.statusCode}',);
      emit(HomepageCoalitionsFailed(exception: response.exception));
    }
    return null;
  }

  Future<void> logOut() async {
    deleteTokens();
    appRouter.popUntil((route) => route.data?.name == "LoginRoute");
  }

}
