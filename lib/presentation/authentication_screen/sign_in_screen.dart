import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/helper/validator.dart';
import 'package:sgt/presentation/authentication_screen/cubit/email_checker/email_checker_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/obscure/obscure_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/password_checker/password_checker_cubit.dart';
import 'package:sgt/presentation/authentication_screen/forgot_password_screen.dart';
import 'package:sgt/presentation/authentication_screen/widget/error_widgets.dart';
import 'package:sgt/presentation/authentication_screen/widget/language_change_oprion_widget.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_underline_textfield_widget.dart';
import 'package:sgt/theme/custom_theme.dart';

import 'cubit/issign_in_valid/issigninvalid_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  LanguageChangeOptionWidget(), //language change optionwidget
                  SizedBox(
                    height: 44.h,
                  ),
                  Center(
                    child: Text(
                      'Welcome back',
                      textScaleFactor: 1.0,
                      style: CustomTheme.blackTextStyle(25),
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Center(
                    child: Text(
                        textScaleFactor: 1.0,
                        'Sign in to continue',
                        style: CustomTheme.greyTextStyle(17)),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomUnderlineTextFieldWidget(
                    bottomPadding: 7,
                    textfieldTitle: 'Email',
                    hintText: 'Enter Email',
                    controller: _emailController,
                    onChanged: (value) {
                      print(value);
                      context.read<EmailCheckerCubit>().checkEmail(value);
                    },
                  ),
                  context.watch<EmailCheckerCubit>().state.isemailValid
                      ? Container()
                      : CustomErrorWidget.emailError(),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomUnderlineTextFieldWidget(
                    bottomPadding: 7,
                    textfieldTitle: 'Password',
                    hintText: 'Enter Password',
                    controller: _passwordController,
                    obscureText: context.watch<ObscureCubit>().state.isObscure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<ObscureCubit>().changeVisibility();
                      },
                      icon: context.watch<ObscureCubit>().state.isObscure
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black,
                              size: 20,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                    ),
                    onChanged: (value) {
                      context.read<PasswordCheckerCubit>().checkPassword(value);
                      context.read<IssigninvalidCubit>().checkSignIn(context
                              .read<EmailCheckerCubit>()
                              .state
                              .isemailValid ||
                          context.read<PasswordCheckerCubit>().state.password);
                    },
                  ),

                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      context.watch<PasswordCheckerCubit>().state.password
                          ? Container()
                          : CustomErrorWidget.passwordError(),
                      InkWell(
                        onTap: () {
                          screenNavigator(context, ForgotPasswordScreen());
                        },
                        child: Text(
                          'Forgot password',
                          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),

                  CustomButtonWidget(
                      isValid: context
                          .watch<IssigninvalidCubit>()
                          .state
                          .issigninValid,
                      buttonTitle: 'Sign In',
                      onBtnPress: () {
                        screenNavigator(context, Home());
                      }),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
