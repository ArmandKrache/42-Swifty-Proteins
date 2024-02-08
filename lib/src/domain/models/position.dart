import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String password;

  const User({
    required this.username,
    required this.password,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [username];
}