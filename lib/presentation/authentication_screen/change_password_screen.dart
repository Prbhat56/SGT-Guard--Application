import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/helper/validator.dart';
import 'package:sgt/presentation/authentication_screen/cubit/isValidPassword/is_valid_password_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/ispasswordmatched/ispasswordmarched_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/obscure/obscure_cubit.dart';
import 'package:sgt/presentation/authentication_screen/password_change_success_screen.dart';
import '../../utils/const.dart';
import 'forgot_password_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _oldpasswordController;
  late TextEditingController _newpasswordController;
  late TextEditingController _reenteredpasswordController;
  bool ispasswordvalid = true;
  @override
  void initState() {
    _reenteredpasswordController = TextEditingController();
    _newpasswordController = TextEditingController();
    _oldpasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _reenteredpasswordController.dispose();
    _newpasswordController.dispose();
    _oldpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Change Password',
            textScaleFactor: 1.0,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500)),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Old Password',
              textScaleFactor: 1.0,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: Colors.grey, fontSize: 16.sp)),
            ),
            TextFormField(
              obscureText: BlocProvider.of<ObscureCubit>(context, listen: true)
                  .state
                  .oldpasswordObscure,
              controller: _oldpasswordController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: grey, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
                hintText: 'Enter password',
                focusColor: primaryColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    BlocProvider.of<ObscureCubit>(context)
                        .changeoldpasswordVisibility();
                  },
                  icon: BlocProvider.of<ObscureCubit>(context, listen: true)
                          .state
                          .oldpasswordObscure
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
              ),
              onChanged: (value) {},
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'New Password',
              textScaleFactor: 1.0,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: Colors.grey, fontSize: 16.sp)),
            ),
            TextFormField(
              obscureText: BlocProvider.of<ObscureCubit>(context, listen: true)
                  .state
                  .newpasswordObscure,
              controller: _newpasswordController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: grey, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
                hintText: 'Enter password',
                focusColor: primaryColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    BlocProvider.of<ObscureCubit>(context)
                        .changenewpasswordVisibility();
                  },
                  icon: BlocProvider.of<ObscureCubit>(context, listen: true)
                          .state
                          .newpasswordObscure
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
              ),
              onChanged: (value) {
                context
                    .read<IsValidPasswordCubit>()
                    .ispasswordValid(_newpasswordController.text);
                _newpasswordController.text.toString() ==
                        _reenteredpasswordController.text.toString()
                    ? BlocProvider.of<IspasswordmarchedCubit>(context)
                        .passwordMatched()
                    : BlocProvider.of<IspasswordmarchedCubit>(context)
                        .passwordnotMatched();
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Re-Enter New Password',
              textScaleFactor: 1.0,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: Colors.grey, fontSize: 16.sp)),
            ),
            TextFormField(
              controller: _reenteredpasswordController,
              obscureText: BlocProvider.of<ObscureCubit>(context, listen: true)
                  .state
                  .isObscure,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: grey, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
                hintText: 'Enter password',
                focusColor: primaryColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    BlocProvider.of<ObscureCubit>(context).changeVisibility();
                  },
                  icon: BlocProvider.of<ObscureCubit>(context, listen: true)
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
                ),
              ),
              onChanged: (value) {
                _newpasswordController.text.toString() ==
                        _reenteredpasswordController.text.toString()
                    ? BlocProvider.of<IspasswordmarchedCubit>(context)
                        .passwordMatched()
                    : BlocProvider.of<IspasswordmarchedCubit>(context)
                        .passwordnotMatched();
              },
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.watch<IsValidPasswordCubit>().state.ispasswordvalid
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'Passwords is too short!',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                    BlocProvider.of<IspasswordmarchedCubit>(context,
                                listen: true)
                            .state
                            .ispasswordmatched
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'Password not matched',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const ForgotPasswordScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(1, 0), end: Offset.zero)
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
                      textStyle: TextStyle(color: Colors.blue, fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Center(
              child: Container(
                width: 343.w,
                child: CupertinoButton(
                  color: BlocProvider.of<IspasswordmarchedCubit>(context,
                              listen: true)
                          .state
                          .isValid
                      ? primaryColor
                      : seconderyColor,
                  child: Text(
                    'Update',
                    textScaleFactor: 1.0,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(fontSize: 17.sp)),
                  ),
                  onPressed: () {
                    BlocProvider.of<IspasswordmarchedCubit>(context,
                                listen: false)
                            .state
                            .isValid
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const PasswordChangeSuccessScreen();
                              },
                            ),
                          )
                        : null;
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
