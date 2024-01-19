part of 'student_cubit.dart';

abstract class StudentState extends Equatable {
  final DioException? exception;
  final StudentDetails? student;

  const StudentState({this.exception, this.student});

  @override
  List<Object?> get props => [];
}

class StudentLoading extends StudentState {
  const StudentLoading({super.student});
}

class StudentSuccess extends StudentState {
  const StudentSuccess({super.student});
}

class StudentFailed extends StudentState {
  const StudentFailed({super.exception});
}