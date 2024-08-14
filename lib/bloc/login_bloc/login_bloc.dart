import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../other/firebase/add_notification/add_notification_firebase.dart';

import '../../other/notification_service/flutter_local_noti/init_function.dart';
import '../../other/notification_service/notification_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(const LoginState()) {
    on<ChangeEmail>(_emailChanged);
    on<ChangePassword>(_passwordChanged);
    on<ForgetPasswordEmailChangeEvent>(_forgetPasswordEmailChanged);
    on<LoginUser>(_loginUser);
    on<SignInWithGoogle>(_handleSignInWithGoogle);
    on<ResetPassword>(_resetPasswordMethod);
    on<ShowPassword>(_showPassToggle);
  }
  void _showPassToggle(ShowPassword event, Emitter<LoginState> emit) {
    if (state.isShowingPassword == false) {
      emit(state.copyWith(isShowingPassword: true));
    } else {
      emit(state.copyWith(isShowingPassword: false));
    }
  }

  void _emailChanged(ChangeEmail event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(ChangePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _forgetPasswordEmailChanged(
      ForgetPasswordEmailChangeEvent event, Emitter<LoginState> emit) {
    print("changed ${event.forgetEmail}");
    emit(state.copyWith(forgetScreenEmail: event.forgetEmail));
  }

  Future<void> _loginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      if (userCredential.user != null) {
        emit(state.copyWith(loginStatus: LoginStatus.success));
      } else {
        emit(state.copyWith(
            loginStatus: LoginStatus.failure, message: 'Login failed'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else if (e.code == 'invalid-credential') {
        errorMessage =
            'The supplied auth credential is incorrect, malformed, or has expired.';
      } else {
        errorMessage = 'An unknown error occurred.';
      }
      emit(state.copyWith(
          loginStatus: LoginStatus.failure, message: errorMessage));
    } catch (e) {
      emit(state.copyWith(
          loginStatus: LoginStatus.failure, message: e.toString()));
    }
  }

  Future<void> _handleSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          emit(state.copyWith(loginStatus: LoginStatus.success));

          final localNotification = FlutterLocalNotification();
          int id = 0;
          localNotification.showNotification(
            id++,
            "VitaVibe",
            "You Successfully Logged in with your Google account",
          );
          AddNotificationFirebase.addNotificationToFirebase(
              notification:
                  'You have successfully logged in with your Google account.');
        } else {
          emit(state.copyWith(
            loginStatus: LoginStatus.failure,
            message: 'Google Sign-In Failed',
          ));
        }
      } else {
        emit(state.copyWith(
          loginStatus: LoginStatus.failure,
          message: 'Google Sign-In Failed: No auth details',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loginStatus: LoginStatus.failure,
        message: 'Google Sign-In Failed: ${e.toString()}',
      ));
    }
  }

  Future<void> _resetPasswordMethod(
      ResetPassword event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: state.forgetScreenEmail);
      emit(state.copyWith(
          loginStatus: LoginStatus.success,
          message: 'Password reset email sent!'));
      final localNotification = FlutterLocalNotification();
      int id = 0;

      localNotification.showNotification(
        id++,
        "VitaVibe",
        "Check your email for a reset password",
      );
      AddNotificationFirebase.addNotificationToFirebase(
          notification: 'Password reset email sent!');
    } catch (error) {
      emit(state.copyWith(
          loginStatus: LoginStatus.error, message: error.toString()));
    }
  }
}
