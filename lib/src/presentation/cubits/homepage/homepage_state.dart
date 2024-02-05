part of 'homepage_cubit.dart';

abstract class HomepageState extends Equatable {
  final DioException? exception;
  final List<String>? ligands;

  const HomepageState({
    this.exception,
    this.ligands,
  });

  @override
  List<Object?> get props => [exception];
}

class HomepageLoading extends HomepageState {
  const HomepageLoading({super.ligands,});
}

class HomepageSuccess extends HomepageState {
  const HomepageSuccess({super.ligands,});
}

class HomepageFailed extends HomepageState {
  const HomepageFailed({super.ligands, super.exception});
}
