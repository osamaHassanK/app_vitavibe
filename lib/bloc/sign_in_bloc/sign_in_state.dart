part of 'sign_in_bloc.dart';

enum SignInStatus { initial, loading, success, error, failure }

class SignInState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String message;
  final String name;
  final SignInStatus signInStatus;
  final bool isPasswordVisible1;
  final bool isPasswordVisible2;

  const SignInState({
    this.email = '',
    this.message = '',
    this.password = '',
    this.confirmPassword = '',
    this.name = '',
    this.signInStatus = SignInStatus.initial,
    this.isPasswordVisible1 = false,
    this.isPasswordVisible2 = false,
  });

  SignInState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? message,
    String? name,
    SignInStatus? signInStatus,
    bool? isPasswordVisible1,
    bool? isPasswordVisible2,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      signInStatus: signInStatus ?? this.signInStatus,
      message: message ?? this.message,
      name: name ?? this.name,
      isPasswordVisible1: isPasswordVisible1 ?? this.isPasswordVisible1,
      isPasswordVisible2: isPasswordVisible2 ?? this.isPasswordVisible2,
    );
  }

  @override
  List<Object> get props => [email, confirmPassword, password, signInStatus, message, name, isPasswordVisible1,isPasswordVisible2];
}

