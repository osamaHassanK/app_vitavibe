import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../other/firebase/login_user_method.dart';

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
  }

  void _emailChanged(ChangeEmail event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(ChangePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _forgetPasswordEmailChanged(ForgetPasswordEmailChangeEvent event, Emitter<LoginState> emit) {
    print("changed ${event.forgetEmail}");
    emit(state.copyWith(forgetScreenEmail: event.forgetEmail ));
  }

  Future<void> _loginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));

    try {
      // Instance of method class (assuming LoginUserMethod is correctly implemented)
      LoginUserMethod userLogin = LoginUserMethod();
      User? user = await userLogin.loginUser(state.email, state.password);

      if (user != null) {
        emit(state.copyWith(loginStatus: LoginStatus.success));
      } else {
        emit(state.copyWith(
            loginStatus: LoginStatus.failure, message: 'Login failed'));
      }
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
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          emit(state.copyWith(loginStatus: LoginStatus.success));
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

  Future<void> _resetPasswordMethod(ResetPassword event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: state.forgetScreenEmail);
      emit(state.copyWith(loginStatus: LoginStatus.success, message: 'Password reset email sent!'));
    } catch (error) {
      emit(state.copyWith(loginStatus: LoginStatus.error, message: error.toString()));
    }
  }
}
