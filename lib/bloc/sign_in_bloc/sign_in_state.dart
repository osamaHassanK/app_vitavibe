part of 'sign_in_bloc.dart';

enum SignInStatus { initial, loading, success, error, failure }

 class SignInState extends Equatable {
 final String email, password, confirmPassword, message,name;
  final SignInStatus signInStatus;
  const SignInState(
      {this.email = '',
      this.message = '',
      this.password = '',
      this.confirmPassword = '',
        this.name='',
      this.signInStatus = SignInStatus.initial});
  SignInState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? message,
    String? name,
    SignInStatus? signInStatus,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      signInStatus: signInStatus ?? this.signInStatus,
      message: message ?? this.message,
      name: name ?? this.name
    );
  }

  @override
  List<Object?> get props => [email,confirmPassword,password,signInStatus,message,name
  ];
}
