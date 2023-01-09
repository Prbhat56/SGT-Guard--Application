import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgt/presentation/connect_screen/cubit/islongpressed/islongpress_cubit.dart';
import 'package:sgt/presentation/connect_screen/cubit/issearching/issearching_cubit.dart';
import 'package:sgt/presentation/connect_screen/widgets/chat_model.dart';
import '../../utils/const.dart';
import '../guard_tools_screen/guard_tools_screen.dart';
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
                  elevation: 0,
                  leadingWidth: 0,
                  backgroundColor: white,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
              : AppBar(
                  toolbarHeight: 48,
                  shadowColor: Color.fromARGB(255, 186, 185, 185),
                  elevation: 6,
                  backgroundColor: white,
                  leading: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: greenColor,
                    ),
                  ),
                  leadingWidth: 30,
                  title: Text(
                    'Connect',
                    style: TextStyle(color: black, fontWeight: FontWeight.w400),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const GuardToolScreen(),
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
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: SvgPicture.asset('assets/tool.svg'),
                      ),
                    )
                  ],
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
                    ? Container()
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
                            Text(
                              'Mark All As Read',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                Divider(
                  thickness: 3,
                  color: seconderyColor,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: state.selectedChatTile.isNotEmpty
                        ? MediaQuery.of(context).size.height * 4 / 5
                        : MediaQuery.of(context).size.height * 3.56 / 5,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
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
