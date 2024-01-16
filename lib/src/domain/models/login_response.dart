import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String scope;

  const LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
  });


  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      accessToken: map['access_token'] ?? "",
      tokenType: map['token_type'] ?? "",
      expiresIn: map['expires_in'] ?? -1,
      scope: map['scope'] ?? "",
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [accessToken, expiresIn];

}