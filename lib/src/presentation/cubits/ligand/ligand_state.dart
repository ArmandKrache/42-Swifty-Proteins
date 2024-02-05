part of 'ligand_cubit.dart';

abstract class LigandState extends Equatable {
  final DioException? exception;
  final Ligand? ligand;

  const LigandState({this.exception, this.ligand});

  @override
  List<Object?> get props => [];
}

class LigandLoading extends LigandState {
  const LigandLoading({super.ligand});
}

class LigandSuccess extends LigandState {
  const LigandSuccess({super.ligand});
}

class LigandFailed extends LigandState {
  const LigandFailed({super.exception});
}