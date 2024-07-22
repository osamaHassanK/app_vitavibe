import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../other/firebase/register_user_method.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';



class SignInBloc extends Bloc<SignInEvent, SignInState> {

  final AuthService _authService;

  SignInBloc(this._authService) : super(const SignInState()) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<NameChanged>(_nameChanged);
    on<ConfirmPasswordChanged>(_confirmPasswordChanged);
    on<RegisteredUser>(_registeredUser);
  }

  void _emailChanged(EmailChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(PasswordChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.passwordChanged));
  }

  void _nameChanged(NameChanged event, Emitter<SignInState> emit) {
   emit(state.copyWith(name: event.name));
  }

  void _confirmPasswordChanged(ConfirmPasswordChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPasswordChanged));
  }


Future<void> _registeredUser(RegisteredUser event, Emitter<SignInState> emit)async{
  emit(state.copyWith(signInStatus: SignInStatus.loading));

  try {
    await _authService.registerWithEmailAndPassword(
      state.email,
      state.password,
      state.name,
    );
    emit(state.copyWith(signInStatus: SignInStatus.success));
  } catch (error) {
    emit(state.copyWith(signInStatus: SignInStatus.error, message: error.toString()));
  }
}
}


