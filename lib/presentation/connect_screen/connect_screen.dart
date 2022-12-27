import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgt/presentation/connect_screen/cubit/islongpressed/islongpress_cubit.dart';
import 'package:sgt/presentation/connect_screen/cubit/issearching/issearching_cubit.dart';
import 'package:sgt/presentation/connect_screen/widgets/chat_model.dart';
import '../../utils/const.dart';
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
                  elevation: 0,
                  leadingWidth: 0,
                  backgroundColor: white,
                  title:
                      BlocProvider.of<IssearchingCubit>(context, listen: true)
                              .state
                              .isSearching
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: grey,
                                    isDense: true,
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(30, 5, 30, 0),
                                    prefixIcon: Icon(
                                      Icons.arrow_back_ios,
                                      color: black,
                                      size: 25,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0.0),
                                    ),
                                    hintText: 'Search',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        context
                                            .read<IssearchingCubit>()
                                            .searchingChecker();
                                      },
                                      icon: Icon(
                                        Icons.search,
                                        size: 25,
                                        color: black,
                                      ),
                                    )),
                              ),
                            )
                          : Container(),
                  actions: [
                    context.watch<IssearchingCubit>().state.isSearching
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<IssearchingCubit>()
                                    .searchingChecker();
                              },
                              icon: Icon(
                                Icons.search,
                                color: black,
                                size: 35,
                              ),
                            ),
                          ),
                  ],
                ),
          backgroundColor: white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.selectedChatTile.isNotEmpty
                    ? Container()
                    : const Padding(
                        padding: EdgeInsets.only(left: 16.0, bottom: 10),
                        child: Text(
                          'Connect',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                state.selectedChatTile.isNotEmpty
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                        child: Text(
                          'Chats',
                          style: TextStyle(color: black, fontSize: 20),
                        ),
                      ),
                Divider(
                  thickness: 3,
                  color: primaryColor,
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
