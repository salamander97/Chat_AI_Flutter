// ignore_for_file: avoid_print, duplicate_ignore, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hihihi/recent_chat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:vnlunar/vnlunar.dart';
import 'Accounts/login_ui.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  late ScrollController _scrollController;
  bool autoScroll = true;
  FocusNode focusNode = FocusNode();
  bool _showUserCopyIcon = false;
  bool _showAICopyIcon = false;
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  _checkAutoLogin() async {
    String? token = await secureStorage.read(key: 'authToken');

    if (token == null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginUI(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          autoScroll = false;
        });
      }
    });
    focusNode.addListener(() {
      setState(() {
        _showUserCopyIcon = false;
        _showAICopyIcon = false;
      });
      if (!focusNode.hasFocus) {
        hideKeyboard();
      }
    });
    _restoreChat(); // Khôi phục cuộc trò chuyện khi khởi động ứng dụng
  }

  void showSavedChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedChat = prefs.getStringList('savedChat');

    if (savedChat != null) {
      for (var message in savedChat) {
        var parsedMessage = jsonDecode(message);
        if (parsedMessage is Map<String, dynamic>) {
          print('Saved message: $parsedMessage');
        } else {
          print('Unexpected message format: $message');
        }
      }
    } else {
      print('No saved chat found.');
    }
  }

  // Ẩn bàn phím
  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // Cuộn xuống cuối trang
  void scrollBottom() {
    if (autoScroll) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void sendMessage(String text) async {
    _textController.clear();
    final userMessage = {
      'role': 'user',
      'content': text,
      'timestamp': DateTime.now().toIso8601String()
    };
    setState(() {
      _messages.add(userMessage);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to the bottom after adding a new message
      _scrollToBottom();
    });
    if (text == 'Bạn là ai') {
      final aiMessage = {
        'role': 'ai',
        'content':
            'Tôi là Chat GPT-4 được tạo bởi OpenAI và được phát triển thêm bởi Trung Hiếu',
        'timestamp': DateTime.now().toIso8601String()
      };
      setState(() {
        _messages.add(aiMessage);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
      setState(() {
        _messages.add(aiMessage);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } else {
      const apiKey = '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';
      //    const apiKey = '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';

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo-1106',
          'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant.'},
            {'role': 'user', 'content': text},
          ],
        }),
      );

      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final aiMessage = {
        'role': 'ai',
        'content': data['choices'][0]['message']['content']
      };

      setState(() {
        _messages.add(aiMessage);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Scroll to the bottom after adding a new message
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
  bool _chatRestored = false;

  void createNewChat() {
    print('Create new chat trước khi lưu : $_messages'); // In ra để kiểm tra
    _saveChat();
    setState(() {
      _messages.clear();
    });
    debugPrint('Saved message:$_messages');
    // ignore: unused_local_variable
    for (var message in _messages) {}
  }

  void _restoreChat() async {
    if (!_chatRestored) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? savedChat = prefs.getStringList('savedChat');
      if (savedChat != null) {
        for (String message in savedChat) {
          var parsedMessage = jsonDecode(message);
          if (parsedMessage is Map<String, dynamic>) {
            _messages.add(parsedMessage);
            debugPrint(
                'Khôi phục tin nhắn: $parsedMessage'); // In ra để kiểm tra
          } else {
            // ignore: avoid_print
            print('Unexpected message format: $_messages');
          }
        }
      }

      _chatRestored = true;
    }
  }

  void _saveChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Tin nhắn trước khi lưu _saveChat: $_messages');

    List<String> chatToSave =
        _messages.map((message) => jsonEncode(message)).toList();
    prefs.setStringList('savedChat', chatToSave);
    print('Saved chat: $chatToSave');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat BOT',
          style: GoogleFonts.k2d(
            height: -0.6,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 168, 158, 158),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 17, 17, 17),
        toolbarHeight: 35,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const RecentConversation(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(-1.0, 0.0);
                  var end = Offset.zero;
                  var curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        actions: <Widget>[
          RotatedBox(
            quarterTurns: 1, // Quay 90 độ
            child: IconTheme(
              data: const IconThemeData(color: Colors.white), // Đặt màu trắng
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    setState(() {
                      _messages.clear();
                    });
                  } else if (value == 'createNew') {
                    createNewChat();
                    showSavedChat();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      title: Text('Xoá hội thoại'),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'createNew',
                    child: ListTile(
                      leading:
                          Icon(Icons.add, color: Color.fromARGB(255, 5, 5, 5)),
                      title: Text('Tạo mới'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 31, 31, 31),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = _messages[index];
                    if (message['role'] == 'user') {
                      return UserMessage(
                        content: message['content'],
                        // showCopyIcon: _showUserCopyIcon,
                        onTap: () {
                          setState(() {
                            _showUserCopyIcon = !_showUserCopyIcon;
                          });
                        },
                      );
                    } else if (message['role'] == 'ai') {
                      return AIMessage(
                        content: message['content'],
                        showCopyIcon: _showAICopyIcon,
                        onTap: () {
                          setState(() {
                            _showAICopyIcon = !_showAICopyIcon;
                          });
                        },
                      );
                    } else {
                      return Text('Unknown role: ${message['role']}');
                    }
                  },
                ),
              ),
            ),
            BottomAppBar(
              color: const Color.fromARGB(255, 17, 17, 17),
              child: Container(
                height: 20,
                margin: const EdgeInsets.only(bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 46, 46, 46),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'Nhập câu hỏi tại đây...',
                          hintStyle: GoogleFonts.inter(
                            color: const Color.fromARGB(255, 254, 254, 254),
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        onSubmitted: sendMessage,
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: () {},
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    Transform.rotate(
                      angle: -30 * 3.14 / 180,
                      child: InkWell(
                        onTap: () => sendMessage(_textController.text),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Transform.translate(
                            offset: const Offset(
                                2.0, -1), // Dịch chuyển sang phải 2 đơn vị
                            child: const Icon(
                              Icons.send,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  final String content;
  final VoidCallback onTap;

  const UserMessage({
    Key? key,
    required this.content,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tính toán widthFactor dựa trên nội dung
    final contentWidthFactor = (content.length / 40)
        .clamp(0.25, 0.65); // Ví dụ: giới hạn từ 0.25 đến 0.75

    return GestureDetector(
      onTap: () {
        _copyToClipboardAndShowPopup(context);
      },
      child: FractionallySizedBox(
        widthFactor: contentWidthFactor,
        alignment: Alignment.centerRight, // Đặt căn lề bên phải
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: const ShapeDecoration(
            color: Color.fromARGB(255, 77, 70, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    content,
                    textStyle: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w500,
                    ),
                    speed: const Duration(milliseconds: 0),
                  ),
                ],
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboardAndShowPopup(BuildContext context) {
    Clipboard.setData(ClipboardData(text: content));

    final overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: MediaQuery.of(context).size.height / 2 - 25,
          left: MediaQuery.of(context).size.width / 2 - 100,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('Đã sao chép nội dung'),
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    // Tắt popup sau 0.5 giây
    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry.remove(); // Loại bỏ overlay
    });
  }
}

class AIMessage extends StatefulWidget {
  final String content;
  final bool showCopyIcon;
  final VoidCallback onTap;

  const AIMessage({
    Key? key,
    required this.content,
    required this.showCopyIcon,
    required this.onTap,
  }) : super(key: key);

  @override
  AIMessageState createState() => AIMessageState();
}

class AIMessageState extends State<AIMessage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _copyToClipboardAndShowPopup(context);
        widget.onTap(); // Gọi hàm onTap của widget cha (nếu cần)
      },
      child: FractionallySizedBox(
        widthFactor: 0.65, // 3/4 chiều ngang màn hình
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: const ShapeDecoration(
            color: Color(0xFFD71D1D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.content,
                style: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w500),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboardAndShowPopup(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.content));

    final overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: MediaQuery.of(context).size.height / 2 - 25,
          left: MediaQuery.of(context).size.width / 2 - 100,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('Đã sao chép nội dung'),
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    // Tắt popup sau 0.5 giây
    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry.remove(); // Loại bỏ overlay
    });
  }
}
