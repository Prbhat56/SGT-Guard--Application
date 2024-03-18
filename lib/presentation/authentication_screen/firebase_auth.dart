import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sgt/main.dart';
import 'package:sgt/presentation/account_screen/model/guard_details_model.dart';
import 'package:sgt/presentation/connect_screen/model/chat_messages_modal.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import 'package:sgt/presentation/connect_screen/model/live_location_modal.dart';
import 'package:sgt/utils/database_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FirebaseHelper {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //For accessing the cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //For accessing the image storage database
  static FirebaseStorage storage = FirebaseStorage.instance;

  //For accessing firebase messaging (Push Notification)
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // to return current user
  static User get user => auth.currentUser!;

  //static late ChatUsers me;
  static DataManager dataManager = DataManager();

  // for storing self information
  static ChatUsers me = ChatUsers(
    profileUrl: prefs.getString('profile_image').toString(),
    name: prefs.getString('name').toString(),
    createdAt: '',
    isOnline: true,
    id: user.uid,
    lastActive: '',
    email: user.email.toString(),
    pushToken: '',
    location: '',
    position: '',
    recentMessageTimestamp: '',
  );

  //SIGN UP METHOD
  static Future signUp(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //SIGN IN METHOD
  static Future signIn(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      final idToken = await user.getIdToken(true);
      await dataManager.setData(idToken.toString());
      String savedData = dataManager.data;
      print('Id Token ${savedData}');
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //SIGN OUT METHOD
  static Future<void> signOut() async {
    try {
      await updateActiveStatus(false).then((value) async {
        await auth.signOut();
      });
      print('signout');
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  //Forgot PASSWORD

  //Change Password
  static Future<void> changePassword(String newPassword) async {
    await user.updatePassword(newPassword).then((_) {
      print("Your password changed Succesfully ");
    }).catchError((err) {
      print("You can't change the Password" + err.toString());
    });
  }

  static Future<void> changeMyPassword(String newPassword) async {
    final String API_KEY = 'AIzaSyB8UGWEUdZg7o7vw_TpvWlvaRrCxgPYK4o';
    final String changePasswordUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key=$API_KEY';

    final Map<String, dynamic> payload = {
      'idToken': dataManager.data,
      'password': newPassword,
      'returnSecureToken': true
    };
    try {
      await http.post(
        Uri.parse(changePasswordUrl),
        body: json.encode(payload),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (error) {
      print("You can't change the Password" + error.toString());
      throw error;
    }
  }

  //CHECK EXISTING USERS
  static Future<bool> userExists() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);
    return (await firestore
            .collection(
                'property_owner_${userDetails.userDetails!.propertyOwnerId.toString()}')
            .doc(user.uid)
            .get())
        .exists;
  }

  // for adding an chat user for our conversation
  // static Future<bool> addChatUser(String email) async {
  //   final data = await firestore
  //       .collection('users')
  //       .where('email', isEqualTo: email)
  //       .get();

  //   print('data: ${data.docs}');

  //   if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
  //     print('user exists: ${data.docs.first.data()}');

  //     firestore
  //         .collection('users')
  //         .doc(user.uid)
  //         .collection('my_users')
  //         .doc(data.docs.first.id)
  //         .set({});

  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  //GET MY INFO
  static Future<void> getSelfInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);

    await firestore
        .collection(
            'property_owner_${userDetails.userDetails!.propertyOwnerId.toString()}')
        .doc(user.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        me = ChatUsers.fromJson(user.data()!);
        await getFirebaseMessagingToken();
        FirebaseHelper.updateActiveStatus(true);
        print('My Data: ${user.data()}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  //CREATE NEW USER
  static Future<void> createUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);
    final currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUsers(
      profileUrl:
          "${userDetails.imageBaseUrl}${userDetails.userDetails!.avatar.toString()}",
      name:
          "${userDetails.userDetails!.firstName.toString()} ${userDetails.userDetails!.lastName.toString()}",
      createdAt: currentTime,
      isOnline: true,
      id: user.uid,
      lastActive: currentTime,
      email: user.email.toString(),
      pushToken: '',
      location:
          "${userDetails.userDetails!.street.toString()}, ${userDetails.userDetails!.cityText.toString()}",
      position: "${userDetails.userDetails!.guardPosition.toString()}",
      recentMessageTimestamp: '',
    );

    return await firestore
        .collection(
            'property_owner_${userDetails.userDetails!.propertyOwnerId.toString()}')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Future<void> createPropertyOwner() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);
    final currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUsers(
      profileUrl:
          "${userDetails.imageBaseUrl}${userDetails.userDetails!.avatar.toString()}",
      name:
          "${userDetails.userDetails!.firstName.toString()} ${userDetails.userDetails!.lastName.toString()}",
      createdAt: currentTime,
      isOnline: true,
      id: user.uid,
      lastActive: currentTime,
      email: user.email.toString(),
      pushToken: '',
      location:
          "${userDetails.userDetails!.street.toString()}, ${userDetails.userDetails!.cityText.toString()}",
      position: "${userDetails.userDetails!.guardPosition.toString()}",
      recentMessageTimestamp: '',
    );

    return await firestore
        .collection(
            'property_owner_${userDetails.userDetails!.propertyOwnerId.toString()}')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  // for getting id's of known users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return firestore
        .collection(
            'property_owner_${prefs.getString('property_owner_id').toString()}')
        .doc(user.uid)
        .collection('my_users')
        .snapshots();
  }

//GET ALL USERS METHOD
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection(
            'property_owner_${prefs.getString('property_owner_id').toString()}')
        .orderBy('recentMessageTimestamp', descending: true)
        .snapshots();
  }

  // for adding an user to my user when first message is send
  // static Future<void> sendFirstMessage(
  //     ChatUsers chatUser, String msg, type) async {
  //   await firestore
  //       .collection('users')
  //       .doc(chatUser.id)
  //       .collection('my_users')
  //       .doc(user.uid)
  //       .set({}).then((value) => sendMessage(chatUser, msg, type));
  // }

  // for updating user information
  static Future<void> updateUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);
    await firestore
        .collection(
            'property_owner_${userDetails.userDetails!.propertyOwnerId.toString()}')
        .doc(user.uid)
        .update({
      'name': me.name,
    });
  }

  //UPDATE PROFILE IMAGES
  static Future<void> updateProfilePicture(File file) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);
    final ext = file.path.split('.').last;
    print('Extension: $ext');

    try {
      Reference ref = storage.ref().child(
          'profile_images/${DateTime.now().millisecondsSinceEpoch}.$ext');

      await ref
          .putFile(file, SettableMetadata(contentType: 'image/$ext'))
          .then((p0) {
        print('Data transferred: ${p0.bytesTransferred / 1000} kb');
      });

      // Get the download URL of the uploaded image
      String imageUrl = await ref.getDownloadURL();
      print("Image uploaded successfully. Download URL: $imageUrl");

      me.profileUrl = imageUrl;
      await firestore
          .collection(
              'property_owner_${userDetails.userDetails!.propertyOwnerId.toString()}')
          .doc(user.uid)
          .update({'profileUrl': me.profileUrl});
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  ///************ Chat Screen Related ****************/

//GET CONVERSATION ID
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

//GET MESSAGES METHOD
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUsers chatUsers) {
    String? converseId = getConversationID(chatUsers.id);
    if (chatUsers.position == "property_owner") {
      converseId = "${user.uid}_${chatUsers.id}";
    } else {
      converseId = getConversationID(chatUsers.id);
    }
    // return firestore
    //     .collection('chats/${getConversationID(chatUsers.id)}/messages/')
    //     .orderBy('sent', descending: true)
    //     .snapshots();
    return firestore
        .collection('chats/${getConversationID(chatUsers.id)}/messages/')
        .orderBy('sent', descending: false)
        .snapshots();
  }

  //GET UNREAD MESSAGES METHOD
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUnreadMessages(
      ChatUsers chatUsers) {
    String? converseId = getConversationID(chatUsers.id);
    if (chatUsers.position == "property_owner") {
      converseId = "${user.uid}_${chatUsers.id}";
    } else {
      converseId = getConversationID(chatUsers.id);
    }
    return firestore
        // .collection('chats/${getConversationID(chatUsers.id)}/messages/')
        .collection('chats/${converseId}/messages/')
        .where('toId', isEqualTo: user.uid)
        .where('read', isEqualTo: '')
        .snapshots();
  }

  //FOR SENDING MESSAGE
  static Future<void> sendMessage(
      ChatUsers chatUser, String msg, String msgType) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final ChatMessages message = ChatMessages(
      toId: chatUser.id,
      message: msg,
      read: '',
      type: msgType,
      fromId: user.uid,
      sent: time,
      isSendByMe: false,
    );
    String? converseId = getConversationID(chatUser.id);
    if (chatUser.position == "property_owner") {
      converseId = "${user.uid}_${chatUser.id}";
    } else {
      converseId = getConversationID(chatUser.id);
    }
    print("Conversation Id ===========> ${getConversationID(chatUser.id)}");

    // final ref = firestore
    //     .collection('chats/${getConversationID(chatUser.id)}/messages/');
    final ref = firestore.collection('chats/${converseId}/messages/');
    await ref
        .doc(time)
        .set(message.toJson())
        .then((value) => sendPushNotification(chatUser, msg, msgType));
  }

//update read status of message
  static Future<void> updateMessageReadStatus(ChatMessages msg) async {
    await firestore
        .collection('chats/${getConversationID(msg.fromId)}/messages/')
        .doc(msg.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //update read status of message
  static Future<void> updateRecentMessageTime(ChatUsers chatUser) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);
    await firestore
        .collection(
            'property_owner_${userDetails.userDetails!.propertyOwnerId.toString()}')
        .doc(chatUser.id)
        .update({
      'recentMessageTimestamp':
          DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUsers chatUsers) {
    String? converseId = getConversationID(chatUsers.id);
    if (chatUsers.position == "property_owner") {
      converseId = "${user.uid}_${chatUsers.id}";
    } else {
      converseId = getConversationID(chatUsers.id);
    }
    return firestore
        // .collection('chats/${getConversationID(chatUsers.id)}/messages/')
        .collection('chats/${converseId}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //send chat image
  static Future<void> sendChatImage(ChatUsers chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    try {
      Reference ref = storage.ref().child(
          'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

      await ref
          .putFile(file, SettableMetadata(contentType: 'image/$ext'))
          .then((p0) {
        print('Data transferred: ${p0.bytesTransferred / 1000} kb');
      });

      // Get the download URL of the uploaded image
      final imageUrl = await ref.getDownloadURL();
      print("Image uploaded successfully. Download URL: $imageUrl");

      await sendMessage(chatUser, imageUrl, 'photo');
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  //STORE VIDEOS
  static Future<void> uplodVideo(
      ChatUsers chatUser, String videoFilePath) async {
    final file = File(videoFilePath);
    final ext = file.path.split('.').last;

    try {
      TaskSnapshot taskSnapshot = await storage
          .ref()
          .child(
              'videos/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext')
          .putFile(file);
      final vdoUrl = await taskSnapshot.ref.getDownloadURL();
      print("Video uploaded successfully. Download URL: $vdoUrl");
      await sendMessage(chatUser, vdoUrl, 'video');
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  //GET USER Info METHOD
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUsers chatUser) {
    return firestore
        .collection(
            'property_owner_${prefs.getString('property_owner_id').toString()}')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  //UPDATE USER Info METHOD
  static Future<void> updateActiveStatus(bool isOnline) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);
    await firestore
        .collection(
            'property_owner_${userDetails.userDetails!.propertyOwnerId.toString()}')
        .doc(user.uid)
        .update({
      'isOnline': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  //delete message
  static Future<void> deleteMessage(ChatMessages message) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .delete();

    if (message.type == 'photo' || message.type == 'video') {
      await storage.refFromURL(message.message).delete();
    }
  }

  //update message
  static Future<void> updateMessage(
      ChatMessages message, String updatedMsg) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .update({'message': updatedMsg});
  }

  //delete users
  static Future<void> deleteContact(ChatUsers user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);
    await firestore
        .collection(
            'property_owner_${userDetails.userDetails!.propertyOwnerId.toString()}')
        .doc(user.id)
        .delete();
  }

  ///************************** Push Notification *////

// for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        print('Push Token: $t');
      }
    });

    // for handling foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  // for sending push notification
  static Future<void> sendPushNotification(
      ChatUsers chatUser, String msg, String msgType) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": me.name, //our name should be send
          "body": msgType == 'photo'
              ? '📷 Photo'
              : msgType == 'video'
                  ? '📹 Video'
                  : msg,
          "android_channel_id": "chats"
        },
        "data": {
          "some_data": "User ID: ${me.id}",
        },
      };

      var res =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader:
                    'key=AAAA-TmZdJo:APA91bElMirKmr3uhnf2BPNjFFKL8RIaSTFENpYgGqRLo140v68CFAAn88aBPBAW6V0PHYjkKIOvb0y7IzTDxMxAjntmaXtK0JOBm87ILsU0neFLsygzmmHcAnx5A5gdlyPAFVxfEkZQ'
              },
              body: jsonEncode(body));
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      print('\nsendPushNotificationE: $e');
    }
  }

  /****************/ //LIVE LOCATION///****************** */

  static Future<void> createGuardLocation(String lat, String long, String shift,
      String checkpId, String routeId, String propertyId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);
    final currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    // print("lat -- ${lat}");
    // print("long -- ${long}");
    // print("shift -- ${shift}");
    // print("checkpId -- ${checkpId}");
    // print("routeId -- ${routeId}");
    final userLocation = GuardLocation(
        latitude: lat,
        longitude: long,
        timeStamp: currentTime,
        propertyId: propertyId,
        shiftId: shift,
        checkpointId: checkpId);

    String userId = user.uid.toString();
    // print("userId ===> ${userId}");
    // print('liveLocation/property_${userDetails.userDetails!.propertyOwnerId.toString()}/route_${routeId}/${userId}/${userDetails.userDetails!.emailAddress.toString()}');
    final ref = firestore.collection(
        'liveLocation/property_${propertyId.toString()}/route_${routeId}/${userId}/${userDetails.userDetails!.emailAddress.toString()}');

    await ref.doc(currentTime).set(userLocation.toJson());
  }

  //GET LOCATION METHOD
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLiveLocation() {
    return firestore.collection('liveLocation').snapshots();
  }

  //UPDATE Location METHOD
  static Future<void> updateLiveLocation(String lat, String long) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(pref.getString('user_profile').toString());
    var userDetails = GuardDetails.fromJson(json);
    String userId = user.uid.toString();
    await firestore
        .collection(
            'liveLocation/property_${userDetails.userDetails!.propertyOwnerId.toString()}/route_265/${userId}/${userDetails.userDetails!.emailAddress.toString()}')
        .doc(user.uid)
        .update({
      'latitude': lat,
      'longitude': long,
      'timeStamp': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }
}
/**
 StreamBuilder(
              stream: messagesStream(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return SizedBox();

                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;

                    messages = data
                            ?.map((e) => ChatMessages.fromJson(
                                e.data() as Map<String, dynamic>))
                            .toList() ??
                        [];
                    print(messages.length);

                    if (messages.isNotEmpty) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return MessageCard(message: messages[index]);
                          });
                    } else {
                      return Center(
                        child: Text(
                          'Say Hi...👋',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      );
                    }
                }
              },
            ),
 */