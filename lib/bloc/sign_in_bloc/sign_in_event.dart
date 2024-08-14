part of 'sign_in_bloc.dart';


abstract class SignInEvent extends Equatable{
const SignInEvent();
  @override
  List get props=> [];
}

class NameChanged extends SignInEvent{
  final String name;
  const NameChanged({required this.name});

  @override
  List get props => [name];
}

class EmailChanged extends SignInEvent{
  final String email;
  const EmailChanged({required this.email});
  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends SignInEvent{
  final String passwordChanged;
  const PasswordChanged({required this.passwordChanged});
  @override
  List<Object?> get props => [passwordChanged];
}

class ConfirmPasswordChanged extends SignInEvent{
  final String confirmPasswordChanged;
  const ConfirmPasswordChanged({required this.confirmPasswordChanged});
  @override
  List get props => [confirmPasswordChanged];
}

class RegisteredUser extends SignInEvent{
}

class SignInWithGoogle extends SignInEvent{

}
class TogglePasswordVisibility1 extends SignInEvent {
  const TogglePasswordVisibility1();

  @override
  List<Object> get props => [];
}
class TogglePasswordVisibility2 extends SignInEvent {
  const TogglePasswordVisibility2();

  @override
  List<Object> get props => [];
}
