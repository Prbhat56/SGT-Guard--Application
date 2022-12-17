import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/helper/validator.dart';
import 'package:sgt/presentation/authentication_screen/cubit/obscure/obscure_cubit.dart';
import 'package:sgt/presentation/authentication_screen/forgot_password_screen.dart';
import 'package:sgt/presentation/authentication_screen/sign_up_screen.dart';
import 'package:sgt/presentation/home.dart';
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
  bool isButtonActive = false;
  List<String> languages = [
    'English',
    'Deutsch',
    'Spanish',
    'Language 4 (native)',
    'Башҡортса',
    'Українська',
    'Yorùbá',
    '中文',
    'Кыргызча',
    'Português'
  ];
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            context: context,
                            builder: (context) => SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 3.7 / 5,
                              child: Container(
                                color: white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Container(
                                      color: white,
                                      child: Center(
                                        child: Text(
                                          'Change Language',
                                          textScaleFactor: 1.0,
                                          style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                  fontSize: 25.sp,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: white,
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 4.0, color: grey),
                                          )
                                          // boxShadow: const [
                                          //   BoxShadow(
                                          //       color: Colors.black54,
                                          //       blurRadius: .0,
                                          //       spreadRadius: 2,
                                          //       offset: Offset(
                                          //         0.0,
                                          //         15.0,
                                          //       ))
                                          // ],
                                          ),
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: grey),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: grey),
                                          ),
                                          prefixIcon: const Icon(Icons.search),
                                          hintText: 'Spanish',
                                          hintStyle: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                  color: grey, fontSize: 17)),
                                          focusColor: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: languages.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                bottom: BorderSide(
                                                    width: 2.0, color: grey),
                                              )),
                                              child: Center(
                                                child: Text(languages[index],
                                                    textScaleFactor: 1.0,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          color: black,
                                                          fontSize: 17),
                                                    )),
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Fontisto.world_o,
                              size: 17,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                textScaleFactor: 1.0,
                                'English',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
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
                      height: 10.h,
                    ),
                    Center(
                      child: Text(
                          textScaleFactor: 1.0,
                          'Sign in to continue',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Email',
                      textScaleFactor: 1.0,
                      style: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                    TextFormField(
                      controller: _emailController,
                      // validator: (input) => input!.isValidEmail()
                      //     ? null
                      //     : " \u26A0 Email ID is Incorrect",
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2),
                          ),
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: grey, fontSize: 15),
                          focusColor: primaryColor),
                      onChanged: (value) {
                        setState(() {
                          iseamilvalid = value.isValidEmail;
                        });
                        // _formKey.currentState!.validate()
                        //     ? setState(() {
                        //         isButtonActive = !isButtonActive;
                        //       })
                        //     : null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password',
                      textScaleFactor: 1.0,
                      style: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      // validator: (input) => input!.isValidPassword()
                      //     ? null
                      //     : 'Password Is Incorrect',

                      //    input == null ? 'Password is Empty' : null,
                      obscureText:
                          BlocProvider.of<ObscureCubit>(context, listen: true)
                              .state
                              .isObscure,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2),
                          ),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: grey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              BlocProvider.of<ObscureCubit>(context)
                                  .changeVisibility();
                            },
                            icon: BlocProvider.of<ObscureCubit>(context,
                                        listen: true)
                                    .state
                                    .isObscure
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
                          )),
                      onChanged: (value) {
                        print(value.isValidPassword);
                        setState(() {
                          ispasswordvalid = value.isValidPassword;
                        });
                        // _formKey.currentState!.validate()
                        //     ? setState(() {})
                        //     : null;
                      },
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
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
                                          'Password is Incorrect',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 13),
                                        ),
                                      ],
                                    ),
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
                                          'Email ID is Incorrect',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: iseamilvalid && ispasswordvalid
                                  ? 200.w
                                  : 72.w,
                              right: 0),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const ForgotPasswordScreen();
                                }));
                              },
                              child: Text('Forgot password',
                                  textScaleFactor: 1.0,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12.sp)))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Center(
                      child: CupertinoButton(
                          disabledColor: seconderyColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 120.w, vertical: 15),
                          color: iseamilvalid && ispasswordvalid
                              ? primaryColor
                              : seconderyColor,
                          child: Text(
                            'Sign In',
                            textScaleFactor: 1.0,
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(fontSize: 15.sp)),
                          ),
                          onPressed: () {
                            iseamilvalid && ispasswordvalid
                                ? Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                    return const Home();
                                  }))
                                : null;
                          }),
                    ),
                    const SizedBox(height: 160),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignUpScreen();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text(
                                "Don't have an account?",
                                textScaleFactor: 1.0,
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 17)),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Sign Up",
                                textScaleFactor: 1.0,
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
