import 'package:app_vitavibe/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:app_vitavibe/other/Theme/colors.dart';
import 'package:app_vitavibe/other/firebase/registeration_method/register_user_method.dart';
import 'package:app_vitavibe/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../other/app_dimensions/app_dimensions.dart';
import '../../other/widgets/custom_textformfield.dart';
import '../../other/widgets/glowingbuttonwidget.dart';
import '../../other/widgets/text_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
 static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  late SignInBloc _signInBloc;
  late AuthService _auth;

 @override
  void initState() {
   super.initState();
   _auth=AuthService();
   _signInBloc =SignInBloc(_auth);
 }
  @override
  Widget build(BuildContext context) {
    final dimension = AppDimensions(context);
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (_)=>_signInBloc,
          child: BlocBuilder<SignInBloc,SignInState>(
            builder: (context,state){
              if(state.signInStatus ==SignInStatus.loading){
                Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
              }else if (state.signInStatus ==SignInStatus.success) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(builder: (context) => const Dashboard()),
                    ModalRoute.withName('/dashboard'),
                  );
                });
              }
              else if(state.signInStatus ==SignInStatus.error){
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
                children: [SingleChildScrollView(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                    child: Form(
                      key: RegistrationScreen._formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: dimension.height * 0.01),
                          Image.asset(
                            'assets/images/pills.png',
                            scale: 5,
                          ),
                          const TextWidget(
                            text: "VitaVibe",
                            fontSize: 45,
                          ),
                          const TextWidget(
                            text: "Welcome! Please Enter Your Details",
                            fontSize: 18,
                          ),
                          BlocBuilder<SignInBloc,SignInState>(
                            buildWhen: (current,previous)=>current.email!=previous.email,
                            builder: (context, state) {
                              return CustomTextFormField(
                                isShowIcon: false,
                                keyboardType: TextInputType.name,
                                hintText: 'Name',
                                onChanged:(value){
                                  context.read<SignInBloc>().add(NameChanged(name: value));
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                }, showPass: () {  },
                              );
                            },
                          ),
                          BlocBuilder<SignInBloc, SignInState>(
                            builder: (context, state) {
                              return CustomTextFormField(
                                isShowIcon: false,
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Email',
                                onChanged: (value) {
                                  context.read<SignInBloc>().add(EmailChanged(email: value));
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                }, showPass: () {  },
                              );
                            },
                          ),
                          CustomTextFormField(
                            isShowIcon: true,
                            hintText: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) => context
                                .read<SignInBloc>()
                                .add(PasswordChanged(passwordChanged: value)),
                            isPassword: state.isPasswordVisible1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },  showPass: () {
                            context.read<SignInBloc>().add(TogglePasswordVisibility1());
                          },
                          ),
                          CustomTextFormField(
                            isShowIcon: true,
                            hintText: 'Confirm Password',
                            onChanged: (value) => context
                                .read<SignInBloc>()
                                .add(ConfirmPasswordChanged(confirmPasswordChanged:value)),
                            isPassword: state.isPasswordVisible2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            }, showPass: () {
                            context.read<SignInBloc>().add(TogglePasswordVisibility2());
                          },
                          ),
                          SizedBox(
                            height: dimension.height * 0.03,
                            width: dimension.width,
                          ),
                         GlowingButton(
                                onPressed: state.signInStatus ==SignInStatus.loading
                                    ? (){}
                                    : (){
                                  if (RegistrationScreen._formKey.currentState!.validate()) {
                                    context.read<SignInBloc>().add(RegisteredUser());
                                  }
                                },

                                title: "Register",
                                height: dimension.height * 0.07,
                                width: dimension.width * 0.5,
                              ),
                          SizedBox(
                            height: dimension.height * 0.01,
                            width: dimension.width,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextWidget(
                                text: "Already have an account?",
                                fontSize: 14,
                              ),
                              SizedBox(
                                width: dimension.width * 0.05,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/');
                                },
                                child: const TextWidget(
                                  text: "Login",
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                  state.signInStatus ==SignInStatus.loading ?
              Center(child: CircularProgressIndicator(color: AppColor.primaryColor,),):
                const SizedBox(),
                ],
              );
            },
          )
        ),
      ),
    );
  }
}
