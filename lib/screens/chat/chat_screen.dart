import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  String owner_Name;
  String property_Id;
  ChatScreen(this.owner_Name,this.property_Id,{Key? key}) : super(key: key);

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
  String? ownerName;
  String? propertyId;

  List<String>? chatLocalMessages ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPrefController().clear();
    loadChatMessages(); // Load chat messages when the screen is initialized.
    WidgetsBinding.instance.addObserver(this);
    ownerName = widget.owner_Name;
    propertyId = widget.property_Id;
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
    var messageRef =  _firestore.collection('ChatRooms/PropertyId($propertyId)/Messages');
    await messageRef
        .doc(fileName).set({
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
      await messageRef
          .doc(fileName)
          .update({'message': imageUrl});
      print('======>$imageUrl');
      setState(() {
        imageFile = null;
      });
    }
  }

  void onSendMessage() async {
    var messageRef = _firestore.collection('ChatRooms/PropertyId($propertyId)/Messages');
    if (_messageController.text.isNotEmpty) {
      SharedPrefController().saveChatMessage(_messageController.text);
      var message = {
        'sendby': _auth.currentUser!.displayName,
        'message': _messageController.text,
        'type': 'text',
        'time': FieldValue.serverTimestamp()
      };
      _messageController.clear();
      messageRef.add(message);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var messageRef = _firestore.collection('ChatRooms/PropertyId($propertyId)/Messages');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/chat.svg",
              color: Colors.white,
              height: 30.h,
              width: 30.w,
            ),
            SizedBox(
              width: 4.w,
            ),
            const Text(' تشات '),
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
                  List<String> allMessages = [];
                  allMessages.addAll(chatLocalMessages ?? []); // Existing messages from shared preferences
                  print('Gooooooooooo$allMessages');

                  if (snapshot.data!.docs != null ) {
                    print('7777777${snapshot.data!.docs}777777');
                    print(snapshot.data!.docs.reversed);
                    var messages = snapshot.data!.docs.reversed;
                    // var messagesTexts = [];
                    var messagesSenders = [];
                    var messagesTimes = [];
                    var messagesTypes = [];

                    for (var m in messages) {
                      final messageText = m.get('message');
                      final messageSender = m.get('sendby');
                      final messageType = m.get('type');
                      final messageTime = m.get('time') == null
                          ? DateTime.now()
                          : m.get('time').toDate();
                      DateTime now = messageTime;
                      String formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(now);

                      allMessages.add(messageText); // Messages from Firestore
                      // messagesTexts.add(messageText);
                      messagesSenders.add(messageSender);
                      messagesTimes.add(formattedDate);
                      messagesTypes.add(messageType);
                    }
                    return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return messageContainer(
                              allMessages[index],
                              messagesSenders[index],
                              messagesTimes[index],
                              messagesTypes[index],
                              context);
                        });
                  } else {
                    if(allMessages.length < 1){
                      SharedPrefController().saveChatMessage('مرحباً بك في متجرنا!');
                      loadChatMessages();
                      print('Gooooooooooooooooooooooooooooooood');
                      var messagesSenders = [];
                      var messagesTimes = [];
                      var messagesTypes = [];
                      messagesSenders.add('');
                      messagesTimes.add( DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()));
                      messagesTypes.add('text');
                      return ListView.builder(
                          reverse: true,
                          itemCount: allMessages.length,
                          itemBuilder: (context, index) {
                            return messageContainer(
                                allMessages[index],
                                messagesSenders[index],
                                messagesTimes[index],
                                messagesTypes[index],
                                context);
                          });
                    }else{
                      return const SizedBox();
                    }
                  }
                },
              ),
            )
          ),
          SizedBox(
            height: 70,
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
                        hintText: 'Type here ...',
                        contentPadding: const EdgeInsets.symmetric(vertical: 5 ,horizontal: 15),
                        suffixIcon: IconButton(
                          icon:  Icon(Icons.photo_outlined
                          ,color: inputFocusNode.hasFocus ? kPrimaryColor :Colors.grey,),
                          onPressed: () {
                            getImage();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: kPrimaryColor, width: 2),
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
                    icon: const Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget messageContainer(
      var message, var sender, var time, var type, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return type == 'text'
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            alignment: sender == _auth.currentUser?.displayName
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Column(
              crossAxisAlignment: sender == _auth.currentUser?.displayName
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Text(
                        '$sender',
                        style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                      ),
                const SizedBox(),
                Container(
                  decoration: BoxDecoration(
                      color: sender == _auth.currentUser?.displayName
                          ? kPrimaryColor
                          : Colors.grey[400]!,
                      borderRadius: sender == _auth.currentUser?.displayName
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            )
                          : const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                            )),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
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
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '$time',
                          style:
                              const TextStyle(fontSize: 9, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: sender == _auth.currentUser?.displayName
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Text(
                  '$sender',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ),
              Stack(
                children: [
                  Container(
                  height: size.height / 2.5,
                  width: size.width,
                  // margin: const EdgeInsets.all(10),
                  alignment: sender == _auth.currentUser?.displayName
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
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
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 3,
                            color: sender == _auth.currentUser?.displayName
                                ? kPrimaryColor
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
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            )
                    ),
                  ),
                ),
                  Positioned(
                    bottom: 10,
                    left: 15,
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      color: Colors.black.withAlpha(30).withOpacity(0.3),
                      child: Text(
                        '$time',
                        style: const TextStyle(fontSize: 9, color: Colors.white),
                      ),
                    ),
                  ),
               ]
              ),
            ],
              ),
          );
  }

/*  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance.window.viewInsets.bottom;
    if (value == 0) {
      inputFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    inputFocusNode.dispose();
    super.dispose();
  }*/
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
