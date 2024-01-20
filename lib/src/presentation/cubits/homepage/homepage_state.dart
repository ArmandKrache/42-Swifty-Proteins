part of 'homepage_cubit.dart';

abstract class HomepageState extends Equatable {
  final DioException? exception;
  final List<Coalition>? coalitions;
  final List<Event>? events;
  final List<Student>? students;

  const HomepageState({
    this.exception,
    this.coalitions,
    this.events,
    this.students,
  });

  @override
  List<Object?> get props => [exception];
}

class HomepageLoading extends HomepageState {
  const HomepageLoading({super.coalitions, super.events, super.students});
}

class HomepageSuccess extends HomepageState {
  const HomepageSuccess({super.coalitions, super.events, super.students});
}

class HomepageFailed extends HomepageState {
  const HomepageFailed({super.coalitions, super.events, super.students, super.exception});
}

class HomepageSearchFailed extends HomepageState {
  const HomepageSearchFailed({super.coalitions, super.events, super.students, super.exception});
}

class HomepageSearchLoading extends HomepageState {
  const HomepageSearchLoading({super.coalitions, super.events, super.students, super.exception});
}

class HomepageCoalitionsFailed extends HomepageState {
  const HomepageCoalitionsFailed({super.coalitions, super.events, super.students, super.exception});
}

class HomepageCoalitionsLoading extends HomepageState {
  const HomepageCoalitionsLoading({super.coalitions, super.events, super.students, super.exception});
}

class HomepageEventsFailed extends HomepageState {
  const HomepageEventsFailed({super.coalitions, super.events, super.students, super.exception});
}

class HomepageEventsLoading extends HomepageState {
  const HomepageEventsLoading({super.coalitions, super.events, super.students, super.exception});
}
