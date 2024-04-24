
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/connect_screen/model/chat_messages_modal.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';

enum ToggleMediaState { on, off }

class ToggleMediaCubit extends Cubit<ToggleMediaState> {
  ToggleMediaCubit() : super(ToggleMediaState.off);

  void toggle() {
    emit(state == ToggleMediaState.on
        ? ToggleMediaState.off
        : ToggleMediaState.on);
  }
}

class ChatMessageController extends GetxController {
  List<ChatMessages> messages = <ChatMessages>[].obs;
  ChatUsers? _chatUser;
  ChatUsers? _prevChatUser;

  putUser(ChatUsers user) {
    if (user.id == _chatUser?.id) {
      return;
    }
    _chatUser = user;
    getMessage();
  }

  getMessage() {
    if (_chatUser == null) {
      return;
    }
    if (_chatUser?.id != _prevChatUser?.id) {
      messages = <ChatMessages>[].obs;
      _prevChatUser = _chatUser;
    }
    return FirebaseHelper.getAllMessages(_chatUser!).listen((event) {
      if (event.docChanges.isNotEmpty) {
        for (var x in event.docChanges) {
          final change = x.doc.data();
          if (change != null) {
            switch (x.type) {
              case DocumentChangeType.added:
                final Map<String, dynamic> y = change;
                final tojson = ChatMessages.fromJson(y);
                if (messages
                        .where((element) => element.sent == tojson.sent)
                        .length ==
                    0) {
                  messages.add(tojson);
                }
                break;
              case DocumentChangeType.removed:
                messages.removeAt(x.oldIndex);
                break;
              case DocumentChangeType.modified:
                final Map<String, dynamic> y = change;
                final tojson = ChatMessages.fromJson(y);
                messages.removeAt(x.oldIndex);
                messages.insert(x.newIndex, tojson);
                break;
              default:
                break;
            }
          }
        }
        return;
      } else {
        messages = <ChatMessages>[].obs;
        for (var x in event.docs) {
          final Map<String, dynamic> y = x.data();
          final tojson = ChatMessages.fromJson(y);
          messages.add(tojson);
        }
      }
    });
  }
}

class ChatProfileController extends GetxController {
  List<ChatUsers> users = <ChatUsers>[].obs;
  ChatUsers? _chatUser;
  ChatUsers? _prevChatUser;

  putUser(ChatUsers user) {
    if (user.id == _chatUser?.id) {
      return;
    }
    _chatUser = user;
    getUser();
  }

  getUser() {
    if (_chatUser == null) {
      return;
    }
    if (_chatUser?.id != _prevChatUser?.id) {
      users = <ChatUsers>[].obs;
      _prevChatUser = _chatUser;
    }
    return FirebaseHelper.getUserInfo(_chatUser!).listen((event) {
      if (event.docChanges.isNotEmpty) {
        for (var x in event.docChanges) {
          final change = x.doc.data();
          if (change != null) {
            switch (x.type) {
              case DocumentChangeType.added:
                final Map<String, dynamic> y = change;
                final tojson = ChatUsers.fromJson(y);
                if (users.where((element) => element.id == tojson.id).length ==
                    0) {
                  users.add(tojson);
                }
                break;
              case DocumentChangeType.removed:
                users.removeAt(x.oldIndex);
                break;
              case DocumentChangeType.modified:
                final Map<String, dynamic> y = change;
                final tojson = ChatUsers.fromJson(y);
                users.removeAt(x.oldIndex);
                users.insert(x.newIndex, tojson);
                break;
              default:
                break;
            }
          }
        }
        return;
      } else {
        users = <ChatUsers>[].obs;
        for (var x in event.docs) {
          final Map<String, dynamic> y = x.data();
          final tojson = ChatUsers.fromJson(y);
          users.add(tojson);
        }
      }
      // for (var x in event.docs) {
      //     final change = x.data();
      //     users = <ChatUsers>[].obs;
      //     final Map<String, dynamic> y = change;
      //     final tojson = ChatUsers.fromJson(y);
      //     users.add(tojson);
      //   }
      //   print(users.length);
    });
  }
}
