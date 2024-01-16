
// ignore_for_file: non_constant_identifier_names

class LoginRequest {
  final String grant_type;
  final String client_id;
  final String client_secret;

  LoginRequest({
    this.grant_type = 'client_credentials',
    required this.client_id,
    required this.client_secret,
  });

}