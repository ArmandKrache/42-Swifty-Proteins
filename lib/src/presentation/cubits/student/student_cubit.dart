import 'dart:developer';

import 'package:swifty_companion/src/config/config.dart';
import 'package:swifty_companion/src/config/router/app_router.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';
import 'package:swifty_companion/src/domain/models/login_request.dart';
import 'package:swifty_companion/src/domain/models/student/student.dart';
import 'package:swifty_companion/src/domain/models/student/student_details.dart';
import 'package:swifty_companion/src/domain/repositories/api_repository.dart';
import 'package:swifty_companion/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_companion/src/utils/resources/data_state.dart';
import 'package:swifty_companion/src/utils/resources/functions.dart';
import 'package:swifty_companion/src/utils/resources/token_management.dart';

part 'student_state.dart';

class StudentCubit extends BaseCubit<StudentState, StudentDetails?> {
  final ApiRepository _apiRepository;

  StudentCubit(this._apiRepository) : super(const StudentLoading(), null);


  Future<void> getStudentDetails({required String id}) async {
    emit(const StudentLoading());

    final response =
      await _apiRepository.getStudentDetails(id: id);

    if (response is DataSuccess) {
      final student = response.data!;

      final userCoalitionResponse = await _apiRepository.getUserCoalitions(id: id);
      if (userCoalitionResponse is DataSuccess) {
        Coalition? userCoalition = userCoalitionResponse.data?.coalitions.singleWhere((element) => element.slug.startsWith("42cursus-paris"),
            orElse: () => const Coalition(coalition: CoalitionType.order));
        if (userCoalition != null) {
          student.coalition = userCoalition;
        }
      }

      emit(StudentSuccess(student: student));
    } else if (response is DataFailed) {
      log(response.exception.toString());
      displayErrorToast("Couldn't load profile data:\nError ${response.exception?.response?.statusCode}");
      appRouter.pop();
      emit(StudentFailed(exception: response.exception));
    }
  }
}
