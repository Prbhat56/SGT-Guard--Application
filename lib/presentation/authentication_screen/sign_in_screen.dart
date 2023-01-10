import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/helper/validator.dart';
import 'package:sgt/presentation/authentication_screen/cubit/obscure/obscure_cubit.dart';
import 'package:sgt/presentation/authentication_screen/forgot_password_screen.dart';
import 'package:sgt/presentation/authentication_screen/widget/language_change_oprion_widget.dart';
import 'package:sgt/presentation/home.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_underline_textfield_widget.dart';
import 'package:sgt/utils/const.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool iseamilvalid = true;
  bool ispasswordvalid = true;
  bool isFormValid = false;

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
    print(iseamilvalid);
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
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Center(
                    child: Text(
                        textScaleFactor: 1.0,
                        'Sign in to continue',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomUnderlineTextFieldWidget(
                    textfielsTitle: 'Email',
                    hintText: 'Enter Email',
                    controller: _emailController,
                    onChanged: (value) {
                      setState(() {
                        iseamilvalid = value.isValidEmail;
                      });
                      print(iseamilvalid);
                    },
                  ),

                  const SizedBox(
                    height: 7,
                  ),
                  iseamilvalid
                      ? Container()
                      : SizedBox(
                          width: 143,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 17,
                              ),
                              Text(
                                ' Email ID is Incorrect',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomUnderlineTextFieldWidget(
                    textfielsTitle: 'Password',
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
                      setState(() {
                        ispasswordvalid = value.isValidPassword;
                        iseamilvalid && ispasswordvalid
                            ? isFormValid = true
                            : "";
                      });
                    },
                  ),

                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ispasswordvalid
                          ? Container()
                          : SizedBox(
                              width: 143,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 17,
                                  ),
                                  Text(
                                    ' Wrong password',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const ForgotPasswordScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                          begin: const Offset(1, 0),
                                          end: Offset.zero)
                                      .animate(animation),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Forgot password',
                          textScaleFactor: 1.0,
                          style: GoogleFonts.montserrat(
                            textStyle:
                                TextStyle(color: Colors.blue, fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),

                  CustomButtonWidget(
                      buttonTitle: 'Sign In',
                      btnColor: isFormValid ? primaryColor : seconderyColor,
                      onBtnPress: () {
                        // isFormValid
                        //     ?
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const Home(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero)
                                    .animate(animation),
                                child: child,
                              );
                            },
                          ),
                        );
                        // : null;
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
