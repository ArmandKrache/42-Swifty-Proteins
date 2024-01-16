import 'package:equatable/equatable.dart';

class TokenInfoResponse extends Equatable {
  final int expiresIn;

  const TokenInfoResponse({
    required this.expiresIn,
  });


  factory TokenInfoResponse.fromMap(Map<String, dynamic> map) {
    return TokenInfoResponse(
      expiresIn: map['expires_in_seconds'] ?? -1,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [expiresIn];

}