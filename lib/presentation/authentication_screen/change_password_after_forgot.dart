
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/cubit/isValidPassword/is_valid_password_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/ispasswordmatched/ispasswordmarched_cubit.dart';
import 'package:sgt/presentation/authentication_screen/cubit/obscure/obscure_cubit.dart';
import 'package:sgt/presentation/authentication_screen/password_change_success_screen.dart';
import 'package:sgt/presentation/authentication_screen/widget/error_widgets.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_underline_textfield_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/constant/constant.dart';
import '../../utils/const.dart';


class ChangePasswordAfterForgotScreen extends StatefulWidget {
  final String email;
  ChangePasswordAfterForgotScreen({super.key, required this.email});

  @override
  State<ChangePasswordAfterForgotScreen> createState() =>
      _ChangePasswordAfterForgotScreenState();
}

class _ChangePasswordAfterForgotScreenState extends State<ChangePasswordAfterForgotScreen> {
  late TextEditingController _newpasswordController;
  late TextEditingController _reenteredpasswordController;
  
  bool ispasswordvalid = true;
  @override
  void initState() {
    _reenteredpasswordController = TextEditingController();
    _newpasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _reenteredpasswordController.dispose();
    _newpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Reset Password'),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30.h,
              ),
            // CustomUnderlineTextFieldWidget(
            //   bottomPadding: 7,
            //   textfieldTitle: 'New Password',
            //   hintText: 'Enter Password',
            //   obscureText: context.read<ObscureCubit>().state.newpasswordObscure,
            //   controller: _newpasswordController,
            //   suffixIcon: IconButton(
            //     onPressed: () {
            //       context.read<ObscureCubit>().changenewpasswordVisibility();
            //     },
            //     icon: context.watch<ObscureCubit>().state.newpasswordObscure
            //         ? const Icon(
            //             Icons.visibility_off_outlined,
            //             color: Colors.black,
            //             size: 20,
            //           )
            //         : const Icon(
            //             Icons.visibility_outlined,
            //             color: Colors.black,
            //             size: 20,
            //           ),
            //   ),
            // onChanged: (value) {
            //   context.read<IsValidPasswordCubit>().ispasswordValid(_newpasswordController.text.toString());
            //   _newpasswordController.text.toString() == _reenteredpasswordController.text.toString()
            //       ? context.read<IspasswordmarchedCubit>().passwordMatched()
            //       : context.read<IspasswordmarchedCubit>().passwordnotMatched();
            //   },
            // ),
            // SizedBox(
            //   height: 30.h,
            // ),
            // CustomUnderlineTextFieldWidget(
            //   bottomPadding: 7,
            //   textfieldTitle: 'Re-Enter New Password',
            //   hintText: 'Enter password',
            //   controller: _reenteredpasswordController,
            //   obscureText: context.watch<ObscureCubit>().state.isObscure,
            //   suffixIcon: IconButton(
            //     onPressed: () {
            //       context.read<ObscureCubit>().changeVisibility();
            //     },
            //     icon: context.watch<ObscureCubit>().state.isObscure
            //         ? const Icon(
            //             Icons.visibility_off_outlined,
            //             color: Colors.black,
            //             size: 20,
            //           )
            //         : const Icon(
            //             Icons.visibility_outlined,
            //             color: Colors.black,
            //             size: 20,
            //           ),
            //   ),
            //   onChanged: (value) {
            //     _newpasswordController.text.toString() ==
            //             _reenteredpasswordController.text.toString()
            //         ? context.read<IspasswordmarchedCubit>().passwordMatched()
            //         : context
            //             .read<IspasswordmarchedCubit>()
            //             .passwordnotMatched();
            //   },
            // ),
            // Row(
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         context.watch<IsValidPasswordCubit>().state.ispasswordvalid
            //             ? Container()
            //             : Padding(
            //                 padding: const EdgeInsets.only(top: 8.0),
            //                 child: Row(
            //                   mainAxisSize: MainAxisSize.min,
            //                   children: [
            //                     Icon(
            //                       Icons.error_outline,
            //                       color: Colors.red,
            //                       size: 17,
            //                     ),
            //                     SizedBox(
            //                       width: 3,
            //                     ),
            //                     Text(
            //                       'Passwords is too short!',
            //                       style: TextStyle(
            //                           color: Colors.red, fontSize: 13),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //         context
            //                 .watch<IspasswordmarchedCubit>()
            //                 .state
            //                 .ispasswordmatched
            //             ? Container()
            //             : Padding(
            //                 padding: const EdgeInsets.only(top: 8.0),
            //                 child: Row(
            //                   mainAxisSize: MainAxisSize.min,
            //                   children: [
            //                     Icon(
            //                       Icons.error_outline,
            //                       color: Colors.red,
            //                       size: 17,
            //                     ),
            //                     SizedBox(
            //                       width: 3,
            //                     ),
            //                     Text(
            //                       'Password not matched',
            //                       style: TextStyle(
            //                           color: Colors.red, fontSize: 13),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //       ],
            //     ),
            //     Spacer(),
            //     // InkWell(
            //     //   onTap: () {
            //     //     Navigator.of(context).push(
            //     //       PageRouteBuilder(
            //     //         transitionDuration: const Duration(milliseconds: 500),
            //     //         pageBuilder: (context, animation, secondaryAnimation) =>
            //     //             const ForgotPasswordScreen(),
            //     //         transitionsBuilder:
            //     //             (context, animation, secondaryAnimation, child) {
            //     //           return SlideTransition(
            //     //             position: Tween<Offset>(
            //     //                     begin: const Offset(1, 0), end: Offset.zero)
            //     //                 .animate(animation),
            //     //             child: child,
            //     //           );
            //     //         },
            //     //       ),
            //     //     );
            //     //   },
            //     //   child: Text(
            //     //     'Forgot password',
            //     //     textScaleFactor: 1.0,
            //     //     style: GoogleFonts.montserrat(
            //     //       textStyle: TextStyle(color: Colors.blue, fontSize: 12.sp),
            //     //     ),
            //     //   ),
            //     // ),
            //   ],
            // ),    
            // Spacer(),
            // CustomButtonWidget(
            //   buttonTitle: 'Update',
            //   onBtnPress: () {
            //     context.read<IspasswordmarchedCubit>().state.isValid;
            //     print(widget.email);
            //     passwordChanged(widget.email,_newpasswordController.text.toString(),_reenteredpasswordController.text.toString(),context);
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //     builder: (context) {
            //     //       return const PasswordChangeSuccessScreen();
            //     //     },
            //     //   ),
            //     // );
            //     // context.read<IspasswordmarchedCubit>().state.isValid
            //     //     ? Navigator.push(
            //     //         context,
            //     //         MaterialPageRoute(
            //     //           builder: (context) {
            //     //             return const PasswordChangeSuccessScreen();
            //     //           },
            //     //         ),
            //     //       )
            //     //     : null;
            //   },
            //   btnColor: context.watch<IspasswordmarchedCubit>().state.isValid
            //       ? primaryColor
            //       : seconderyColor,
            // ),
            // SizedBox(
            //   height: 30.h,
            // )
          
          CustomUnderlineTextFieldWidget(
              textfieldTitle: 'New Password',
              hintText: 'Enter Password',
              controller: _newpasswordController,
              obscureText:
                  context.watch<ObscureCubit>().state.newpasswordObscure,
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<ObscureCubit>().changenewpasswordVisibility();
                },
                icon: context.watch<ObscureCubit>().state.newpasswordObscure
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
            CustomUnderlineTextFieldWidget(
              bottomPadding: 7,
              textfieldTitle: 'Re-Enter New Password',
              hintText: 'Enter Password',
              controller: _reenteredpasswordController,
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
                _newpasswordController.text.toString() ==
                        _reenteredpasswordController.text.toString()
                    ? BlocProvider.of<IspasswordmarchedCubit>(context)
                        .passwordMatched()
                    : BlocProvider.of<IspasswordmarchedCubit>(context)
                        .passwordnotMatched();
              },
            ),
            CustomErrorWidget.changePasswordError(context),
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
                    // BlocProvider.of<IspasswordmarchedCubit>(context,
                    //             listen: false)
                    //         .state
                    //         .isValid
                    //     ?
                        // print(widget.email);
                        // print(_newpasswordController.text.toString());
                        // print(_reenteredpasswordController.text.toString());
                        passwordChanged(widget.email,_newpasswordController.text.toString(),_reenteredpasswordController.text.toString(),context);
                        //  Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) {
                        //         return const PasswordChangeSuccessScreen();
                        //       },
                        //     ),
                        //   )
                        // : null;
                  },
                ),
              ),
            ),
          
          ]),
        ),
      ),
    );
  }

  void passwordChanged(email,newPassword,reEnterPassword,context) 
    async{  
  // print(email);
  // print(newPassword);
  // print(reEnterPassword);
      var map = new Map<String,dynamic>();
      map['email']= email;
      map['password']=newPassword;
      map['password_confirmation']=reEnterPassword;
      var apiService = ApiCallMethodsService();
      apiService.post(apiRoutes['resetPassword']!, map).then((value) {
        screenNavigator(context, PasswordChangeSuccessScreen());
      }).onError((error, stackTrace) {
        print(error);
      });
   }
}
