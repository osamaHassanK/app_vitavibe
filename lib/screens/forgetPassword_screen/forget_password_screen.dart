import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../bloc/login_bloc/login_event.dart';
import '../../../bloc/login_bloc/login_state.dart';
import '../../../other/Theme/colors.dart';
import '../../../other/app_dimensions/app_dimensions.dart';
import '../../../other/widgets/custom_textformfield.dart';
import '../../../other/widgets/glowingbuttonwidget.dart';
import '../../../other/widgets/text_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = AppDimensions(context);

    return BlocProvider(
      create: (context) => _loginBloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state.loginStatus == LoginStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    );
                  } else if (state.loginStatus == LoginStatus.success) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password reset email sent!'),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  } else if (state.loginStatus == LoginStatus.error) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                  }
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: _forgotPasswordFormKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                            child: Column(
                              children: [
                                SizedBox(height: dimension.height * 0.02),
                                Image.asset(
                                  'assets/images/pills.png',
                                  scale: 5,
                                ),
                                const TextWidget(
                                  text: "VitaVibe",
                                  fontSize: 45,
                                ),
                                const TextWidget(
                                  text: "Reset Your Password",
                                  fontSize: 18,
                                ),
                                SizedBox(height: dimension.height * 0.03),
                                CustomTextFormField(
                                  hintText: 'Email',
isShowIcon: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your email';
                                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  onChanged: (email) {
                                    print(email);
                                    context.read<LoginBloc>().add(ForgetPasswordEmailChangeEvent(forgetEmail: email));
                                  }, showPass: () {  },
                                ),
                                SizedBox(height: dimension.height * 0.02),
                                GlowingButton(
                                  onPressed: state.loginStatus == LoginStatus.loading
                                      ? () {}
                                      : () {
                                    if (_forgotPasswordFormKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(ResetPassword());
                                    }
                                  },
                                  title: "Send Password Reset Email",
                                  height: dimension.height * 0.07,
                                  width: dimension.width * 0.8,
                                ),
                                SizedBox(height: dimension.height * 0.03),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const TextWidget(
                                    text: "Back",
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (state.loginStatus == LoginStatus.loading)
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
