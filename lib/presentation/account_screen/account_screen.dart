import 'package:flutter/material.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';
import '../widgets/custom_underline_textfield_widget.dart';
import '../widgets/main_appbar_widget.dart';
import 'widgets/guard_card_widget.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(appBarTitle: 'Account'),
      backgroundColor: white,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: grey,
                    backgroundImage: const NetworkImage(
                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    ),
                  ),
                ),
                Text(
                  'Personal',
                  style: CustomTheme.blackTextStyle(21),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  textfielsTitle: 'Name',
                  hintText: 'Jenny Doe',
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  textfielsTitle: 'Email',
                  hintText: 'johndoe@mail.com',
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  textfielsTitle: 'Phone',
                  hintText: '(808)628 8343',
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Address',
                  style: CustomTheme.blackTextStyle(21),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  textfielsTitle: 'Street',
                  hintText: 'Sample Street',
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  textfielsTitle: 'City',
                  hintText: 'Los Angeles',
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  textfielsTitle: 'State',
                  hintText: 'CA',
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  textfielsTitle: 'Zipcode',
                  hintText: '90045',
                  readonly: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Guard Cards',
                  style: CustomTheme.blackTextStyle(21),
                ),
                const SizedBox(
                  height: 16,
                ),
                GuardCard(),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
