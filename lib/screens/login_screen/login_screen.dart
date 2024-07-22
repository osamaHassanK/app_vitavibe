import 'package:app_vitavibe/bloc/login_bloc/login_event.dart';
import 'package:app_vitavibe/other/widgets/loginwithgoogle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import '../../bloc/login_bloc/login_state.dart';
import '../../other/Theme/colors.dart';
import '../../other/app_dimensions/app_dimensions.dart';
import '../../other/widgets/custom_textformfield.dart';
import '../../other/widgets/glowingbuttonwidget.dart';
import '../../other/widgets/text_widget.dart';
import '../dashboard/dashboard.dart';

class LoginScreen extends StatefulWidget {
    LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    late LoginBloc _loginBloc;
    @override
  void initState() {
   _loginBloc= LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = AppDimensions(context);


    return BlocProvider(
      create: (context) => _loginBloc,
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if(state.loginStatus ==LoginStatus.loading){
                Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
              }else if (state.loginStatus == LoginStatus.success) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(builder: (context) => const Dashboard()),
                        (Route<dynamic> route) => false, // This predicate will remove all previous routes
                  );
                });
              }
              else if(state.loginStatus== LoginStatus.error){
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
                children:[ SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10),
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
                            text: "Welcome Back You've Been Missed!",
                            fontSize: 18,
                          ),
                          SizedBox(height: dimension.height * 0.03),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return CustomTextFormField(
                                hintText: 'Email',
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
                                  context
                                      .read<LoginBloc>()
                                      .add(ChangeEmail(email: email));
                                },
                              );
                            },
                          ),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return CustomTextFormField(
                                keyboardType: TextInputType.emailAddress,
                                isPassword: true,
                                hintText: 'Password',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                onChanged: (password) {
                                  context
                                      .read<LoginBloc>()
                                      .add(
                                      ChangePassword(password: password));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, '/forgetPassword');

                                },
                                child: TextWidget(
                                  text: "Forgot password",
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          GlowingButton(
                            onPressed: state.loginStatus ==
                                LoginStatus.loading
                                ? () {}
                                : () {
                              if (_loginFormKey.currentState!.validate()) {
                                context
                                    .read<LoginBloc>()
                                    .add(LoginUser());
                              }
                            },
                            title: "Login",
                            height: dimension.height * 0.07,
                            width: dimension.width * 0.5,
                          ),
                          SizedBox(height: dimension.height * 0.01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextWidget(
                                text: "Don't have an account?",
                                fontSize: 14,
                              ),
                              SizedBox(width: dimension.width * 0.05),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: const TextWidget(
                                  text: "Signup",
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          signInWithGoogleButton(context, ()=>
                              context.read<LoginBloc>().add(SignInWithGoogle()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                  state.loginStatus== LoginStatus.loading ?
                  Center(child: CircularProgressIndicator(color: AppColor.primaryColor,),):
                  const SizedBox(),
                ]
              );
            },
          ),
        ),
      ),
    );
  }
}
