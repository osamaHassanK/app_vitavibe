
import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, error, failure }

class LoginState extends Equatable {
  final String email, password, message,forgetScreenEmail;
  final LoginStatus loginStatus;

  const LoginState(
      {
        this.email = '',
        this.forgetScreenEmail='',
        this.password = '',
        this.loginStatus = LoginStatus.initial,
        this.message = ''
      });

  LoginState copyWith({
    String? email,
    String?  message,
    String? password,
    LoginStatus? loginStatus,
    String? forgetScreenEmail
  }) {
    return LoginState(
      email: email ?? this.email,
      forgetScreenEmail:forgetScreenEmail ?? this.forgetScreenEmail,
      password: password ?? this.password,
      loginStatus: loginStatus ?? this.loginStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [email, password, loginStatus, message,forgetScreenEmail];
}
