import 'package:equatable/equatable.dart';

import '../../screens/login_screen/login_screen.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmail extends LoginEvent {
  final String email;
  const ChangeEmail({required this.email});

  @override
  List<Object> get props => [email];
}
class ForgetPasswordEmailChange extends LoginEvent {
  final String forgetPasswordEmailChange;
  const ForgetPasswordEmailChange({required this.forgetPasswordEmailChange});

  @override
  List<Object> get props => [forgetPasswordEmailChange];
}

class ChangePassword extends LoginEvent {
  final String password;
  const ChangePassword({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginUser extends LoginEvent {}

class ResetPassword extends LoginEvent {

}

class ForgetPasswordEmailChangeEvent extends LoginEvent {
  final String forgetEmail;
  ForgetPasswordEmailChangeEvent({required this.forgetEmail});
  @override
  List<Object> get props => [forgetEmail];
}

class NavigateToSignIn extends LoginScreen {
  NavigateToSignIn({super.key});
}

class ShowPassword extends LoginEvent{

}

class SignInWithGoogle extends LoginEvent {}
