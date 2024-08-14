import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../other/firebase/add_notification/add_notification_firebase.dart';
import '../../other/firebase/registeration_method/register_user_method.dart';
import '../../other/notification_service/flutter_local_noti/init_function.dart';
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
    on<TogglePasswordVisibility1>(_togglePasswordVisibility1);
    on<TogglePasswordVisibility2>(_togglePasswordVisibility2);
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
    final localNotification = FlutterLocalNotification();
    int id = 0;
    localNotification.showNotification(
      id++,
      "VitaVibe",
      'Welcome to VitaVibe Mobile Application',
    );
    AddNotificationFirebase.addNotificationToFirebase(
        notification: 'Welcome to VitaVibe Mobile Application');
    emit(state.copyWith(signInStatus: SignInStatus.success));
  } catch (error) {
    emit(state.copyWith(signInStatus: SignInStatus.error, message: error.toString()));
  }
}
  void _togglePasswordVisibility1(TogglePasswordVisibility1 event, Emitter<SignInState> emit) {
    emit(state.copyWith(isPasswordVisible1: !state.isPasswordVisible1));
    // print('event ${state.isPasswordVisible1}');          ==> for testing
  }
  void _togglePasswordVisibility2(TogglePasswordVisibility2 event, Emitter<SignInState> emit) {
    emit(state.copyWith(isPasswordVisible2: !state.isPasswordVisible2));
    // print('event ${state.isPasswordVisible2}');            ==> for testing
  }
}


