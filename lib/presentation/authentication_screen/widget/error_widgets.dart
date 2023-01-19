import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgt/helper/navigator_function.dart';

import '../cubit/isValidPassword/is_valid_password_cubit.dart';
import '../cubit/ispasswordmatched/ispasswordmarched_cubit.dart';
import '../forgot_password_screen.dart';

class CustomErrorWidget {
  //email error widget function
  static emailError() {
    return SizedBox(
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
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        ],
      ),
    );
  }

//password error widget function
  static passwordError() {
    return SizedBox(
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
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        ],
      ),
    );
  }

//change password error

  static changePasswordError(BuildContext context) {
    return Row(
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
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
            BlocProvider.of<IspasswordmarchedCubit>(context, listen: true)
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
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () {
            screenNavigator(context, ForgotPasswordScreen());
          },
          child: Text(
            'Forgot password',
            textScaleFactor: 1.0,
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
