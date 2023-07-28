import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  String? store_Name;
  String? store_Id;

  ChatScreen({
    Key? key,
    this.store_Name,
    this.store_Id,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final FocusNode inputFocusNode = FocusNode();

  // final _collectionMessages = 'ChatRooms/Owner(${ownerName})/PropertyId()/Messages';
  final TextEditingController _messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User signedInUser;
  bool showImageBeforeSend = false;
  XFile? xFile;
  File? imageFile;
  String? storeName;
  String? storeId;
  List<String>? chatLocalMessages;
  File? _imageFile;
  String? _firstName;
  RandomColor _randomColor = RandomColor();
  AvatarGlow? avatarGlow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProfileImage();
    // SharedPrefController().clear();
    loadChatMessages(); // Load chat messages when the screen is initialized.
    WidgetsBinding.instance.addObserver(this);
    storeName = widget.store_Name;
    storeId = widget.store_Id;
  }

  void _getProfileImage() {
    // Combine the first letter of the name and a random background color
    String initial = SharedPrefController().name.substring(0, 1).toUpperCase();
    print('=================>$initial');
    Color randomColor = _randomColor.randomColor(colorBrightness: ColorBrightness.dark);

    // Add the glowing effect using AvatarGlow widget
     avatarGlow =  AvatarGlow(
      startDelay: const Duration(milliseconds: 1000),
      glowColor: randomColor,
      endRadius: 20.0,
      duration: const Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: const Duration(milliseconds: 100),
      child: Material(
        elevation: 8.0,
        shape: const CircleBorder(),
        child: CircleAvatar(
          backgroundColor: randomColor,
          radius: 50.0,
          child: Text(
            initial,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> loadChatMessages() async {
    chatLocalMessages = SharedPrefController().chatMessages;
    print('${chatLocalMessages}');
  }

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        setState(() {
          showImageBeforeSend = true;
        });
      }
    });
  }

  Future uploadImage() async {
    int status = 1;
    String fileName = const Uuid().v1();
    var messageRef =
        _firestore.collection('ChatRooms/StoreId($storeId)/Messages');
    await messageRef.doc(fileName).set({
      'sendby': _auth.currentUser!.displayName,
      'message': '',
      'type': 'img',
      'time': FieldValue.serverTimestamp()
    });

    var ref =
        FirebaseStorage.instance.ref().child('images').child('$fileName.jpg');

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      messageRef.doc(fileName).delete();
      status = 0;
      print('error======>$error');
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await messageRef.doc(fileName).update({'message': imageUrl});
      print('======>$imageUrl');
      setState(() {
        imageFile = null;
      });
    }
  }

  void onSendMessage() async {
    var messageRef =
        _firestore.collection('ChatRooms/StoreId($storeId)/Messages');
    if (_messageController.text.isNotEmpty) {
      SharedPrefController().saveChatMessage(_messageController.text);
      var message = {
        'sendby': _auth.currentUser!.displayName,
        'message': _messageController.text,
        'type': 'text',
        // 'userImageProfile': '',
        'time': FieldValue.serverTimestamp()
      };
      _messageController.clear();
      messageRef.add(message);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var messageRef =
        _firestore.collection('ChatRooms/StoreId($storeId)/Messages');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/chat.svg",
              color: Colors.white,
              height: 20.h,
              width: 20.w,
            ),
            SizedBox(
              width: 4.w,
            ),
            SmallText(
              text: ' متجر $storeName ',
              size: 15,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 11,
            child: showImageBeforeSend
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    // padding: const EdgeInsets.only(top: 15),
                    height: MediaQuery.of(context).size.height / 1.25,
                    width: MediaQuery.of(context).size.width,
                    alignment: AlignmentDirectional.topStart,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: messageRef
                          .orderBy('time', descending: false)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data != null) {
                          var messages = snapshot.data!.docs.reversed;

                          var messagesTexts = [];
                          var messagesSenders = [];
                          var messagesTimes = [];
                          var messagesTypes = [];
                          // var messagesUserImageProfile = [];

                          for (var m in messages) {
                            final messageText = m.get('message');
                            final messageSender = m.get('sendby');
                            final messageType = m.get('type');
                            // final messageUserImageProfile = m.get('userImageProfile');
                            final messageTime = m.get('time') == null
                                ? DateTime.now()
                                : m.get('time').toDate();
                            DateTime now = messageTime;
                            String formattedDate =
                                DateFormat('yyyy-MM-dd – kk:mm').format(now);
                            messagesTexts.add(messageText);
                            messagesSenders.add(messageSender);
                            messagesTimes.add(formattedDate);
                            messagesTypes.add(messageType);
                            // messageUserImageProfile.add(messageUserImageProfile);

                          }
                          return ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return messageContainer(
                                    messagesTexts[index],
                                    messagesSenders[index],
                                    messagesTimes[index],
                                    messagesTypes[index],
                                    // messagesUserImageProfile[index],
                                    context);
                              });
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
          ),
          SizedBox(
            height: 70.h,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _messageController,
                      focusNode: inputFocusNode,
                      expands: true,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'مراسلة ...',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.photo_outlined,color: inputFocusNode.hasFocus ? kPrimaryColor: Colors.grey,),
                          onPressed: () {
                            getImage();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xC57D8D7B), width: 2),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      onSendMessage();
                      setState(() {
                        showImageBeforeSend = false;
                      });
                      if (imageFile != null) {
                        uploadImage();
                      }
                    },
                    icon: Icon(Icons.send,color: inputFocusNode.hasFocus ? kPrimaryColor: Colors.grey,)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget messageContainer(var message, var sender, var time, var type, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return type == 'text'
        ? Container(
            margin: EdgeInsets.only(top: 4.h,bottom: 2.h,left: 40.w,right: 5.w),
            alignment: sender == _auth.currentUser?.displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: sender == _auth.currentUser?.displayName
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '$sender',
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                const SizedBox(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // sender == _auth.currentUser?.displayName
                    //     ? avatarGlow!
                    //     : Flexible(child: SizedBox(width: 20.w,height: 20.h,)),
                    // const SizedBox(width: 8),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            color: sender == _auth.currentUser?.displayName
                                ? Color(0xC57D8D7B)
                                : Colors.grey[400]!,
                            borderRadius: sender == _auth.currentUser?.displayName
                                ?  BorderRadius.only(
                                    topLeft: Radius.circular(20.0.r),
                                    topRight: Radius.circular(20.0.r),
                                    bottomLeft: Radius.circular(20.0.r),
                                  )
                                : BorderRadius.only(
                                    topLeft: Radius.circular(20.0.r),
                                    topRight: Radius.circular(20.0.r),
                                    bottomRight: Radius.circular(20.0.r),
                                  )),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.h, horizontal: 14.w),
                          child: Column(
                            crossAxisAlignment:
                                sender == _auth.currentUser?.displayName
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                            children: [
                              Text(
                                message,
                                style: TextStyle(
                                  color: sender == _auth.currentUser?.displayName
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                '$time',
                                style: TextStyle(
                                    fontSize: 9.sp, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            margin:  EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
      alignment: sender == _auth.currentUser?.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: sender == _auth.currentUser?.displayName
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Text(
                  '$sender',
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey[500]),
                ),
                Stack(children: [
                  Container(
                    height: size.height / 2.5,
                    width: size.width,
                    // margin: const EdgeInsets.all(10),
                    alignment: sender == _auth.currentUser?.displayName
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ShowImage(imageUrl: message),
                        ),
                      ),
                      child: Container(
                          height: size.height / 2.5,
                          width: size.width / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                                width: 3.w,
                                color: sender == _auth.currentUser?.displayName
                                    ? const Color(0xC57D8D7B)
                                    : Colors.grey[400]!),
                          ),
                          child: message != ''
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.network(
                                    message,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: const CircularProgressIndicator(),
                                    ),
                                  ],
                                )),
                    ),
                  ),
                  Positioned(
                    bottom: 10.h,
                    right: 15.w,
                    child: Container(
                      padding: const EdgeInsets.all(0).r,
                      color: Colors.black.withAlpha(30).withOpacity(0.3),
                      child: Text(
                        '$time',
                        style:
                         TextStyle(fontSize: 9.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          );
  }
/*
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance.window.viewInsets.bottom;
    if (value == 0) {
      inputFocusNode.unfocus();
    }
  }*/

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    inputFocusNode.dispose();
    super.dispose();
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  // ignore: use_key_in_widget_constructors
  const ShowImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}
