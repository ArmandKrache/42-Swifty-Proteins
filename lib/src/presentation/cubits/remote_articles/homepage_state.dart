part of 'homepage_cubit.dart';

abstract class HomepageState extends Equatable {
  final DioException? exception;

  const HomepageState({
    this.exception
  });

  @override
  List<Object?> get props => [exception];
}

class HomepageLoading extends HomepageState {
  const HomepageLoading();
}

class HomepageSuccess extends HomepageState {
  const HomepageSuccess();
}

class HomepageFailed extends HomepageState {
  const HomepageFailed({super.exception});
}
