import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/connect_screen/cubit/islongpressed/islongpress_cubit.dart';
import 'package:sgt/presentation/connect_screen/widgets/chat_model.dart';
import 'package:sgt/service/socket_home.dart';
import '../../utils/const.dart';
import '../widgets/main_appbar_widget.dart';
import 'widgets/chattile_widget.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IslongpressCubit, IslongpressState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: state.selectedChatTile.isNotEmpty
              ? AppBar(
                  leadingWidth: 0,
                  backgroundColor: white,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: black,
                    ),
                    onPressed: () {},
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          context.read<IslongpressCubit>().removeAll();
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: black,
                          size: 25,
                        ))
                  ],
                )
              : MainAppBarWidget(
                  appBarTitle: 'Connect',
                ),
          backgroundColor: white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                state.selectedChatTile.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 10, right: 16),
                        child: Text(
                          'Chats',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 10, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chats',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                screenNavigator(context, SocketHome());
                              },
                              child: Text(
                                'Mark All As Read',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                state.selectedChatTile.isNotEmpty
                    ? Container()
                    : Divider(
                        thickness: 3,
                        color: seconderyColor,
                      ),
                SizedBox(
                  height: 90 * dummyData.length.toDouble(),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dummyData.length,
                    itemBuilder: (context, index) => ChatTileWidget(
                      index: index,
                      color: context
                              .read<IslongpressCubit>()
                              .state
                              .selectedChatTile
                              .contains(index)
                          ? seconderyColor
                          : Colors.transparent,
                      cubit: BlocProvider.of(context),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
