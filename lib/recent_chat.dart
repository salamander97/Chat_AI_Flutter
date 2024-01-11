// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hihihi/Accounts/login_ui.dart';
import 'package:hihihi/chat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class RecentConversation extends StatefulWidget {
  const RecentConversation({Key? key}) : super(key: key);

  @override
  RecentConversationState createState() => RecentConversationState();
}

class RecentConversationState extends State<RecentConversation> {
  List<Map<String, dynamic>> _messages = [];
  final _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedChat = prefs.getStringList('savedChat');
    if (savedChat != null) {
      setState(() {
        _messages = savedChat.map((message) {
          var decoded = jsonDecode(message);
          // Kiểm tra xem decoded có phải là Map<String, dynamic> không
          if (decoded is Map<String, dynamic>) {
            return decoded;
          } else {
            // Nếu không phải, trả về một Map<String, dynamic> rỗng hoặc xử lý theo cách khác
            return <String, dynamic>{};
          }
        }).toList();
      });
    }
  }

  List<Map<String, dynamic>> _filterMessages(int days) {
    DateTime now = DateTime.now();
    DateTime before = now.subtract(Duration(days: days));
    return _messages.where((message) {
      DateTime timestamp = DateTime.parse(message['timestamp']);
      return timestamp.isAfter(before) && timestamp.isBefore(now);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> todayMessages = _filterMessages(1);
    List<Map<String, dynamic>> sevenDaysMessages = _filterMessages(7);
    List<Map<String, dynamic>> thirtyDaysMessages = _filterMessages(30);
    // Hàm tạo ra một widget tin nhắn
    Widget buildMessageItem(Map<String, dynamic> message) {
      String content = message['content'] ?? '';
      // Hiển thị tối đa 15 ký tự
      String shortContent =
          content.length > 15 ? '${content.substring(0, 15)}...' : content;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            const Icon(Icons.chat_outlined, color: Colors.white),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                shortContent,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 290,
            color: const Color(0xFF292929),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 90),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: [
                      PopupMenuButton<String>(
                          onSelected: (String result) {
                            switch (result) {
                              case 'profile':
                                // Logic cho 'Thông tin cá nhân'

                                break;
                              case 'logout':
                                // Xoá token từ Secure Storage
                                _secureStorage.delete(key: 'authToken');
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginUI(), // Sử dụng MaterialPageRoute để quay lại màn hình đăng nhập
                                  ),
                                );
                                break;
                            }
                          },
                          icon: const Icon(Icons.person,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 50),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'profile',
                                  textStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  child: Text('Thông tin cá nhân'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'logout',
                                  textStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  child: Text('Đăng xuất'),
                                ),
                              ],
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),

                      // Thêm logo ChatGPT
                      const SizedBox(width: 0), // Khoảng cách giữa logo và text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trung Hiếu',
                            style: GoogleFonts.cabin(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Row(
                            children: [
                              // Thêm icon Credit
                              Icon(
                                Icons.currency_bitcoin_outlined,
                                color: Color.fromARGB(255, 250, 0, 0),
                                size: 20,
                              ),

                              SizedBox(width: 0),
                              Text(
                                ':',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Unlimited',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 247, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    'Today',
                    style: GoogleFonts.cabin(
                      color: const Color.fromARGB(255, 255, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'Bạn là ai?', // Text bạn muốn thêm
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'Ai là người giàu nhất?', // Text bạn muốn thêm
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'Xin chào! Giúp bạn?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'Chuỗi rỗng biến "attack"',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    '7 Days',
                    style: GoogleFonts.cabin(
                      color: const Color.fromARGB(255, 255, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'Call to Supervisor',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'User seeks assistance',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'Fix Constructor Key Error',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'Exception has occurred',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'Analyze this file data',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'The app has a React/Vite',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    '30 Days',
                    style: GoogleFonts.cabin(
                      color: const Color.fromARGB(255, 255, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'Mojikabe Issue resolution',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      const SizedBox(
                          width: 10), // Khoảng cách giữa icon và text
                      const Text(
                        'BottomBar Design',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16, // Màu sắc của text
                            fontWeight: FontWeight.w500),
                      ),
                      if (todayMessages.isNotEmpty)
                        for (var message in todayMessages)
                          buildMessageItem(message),
                    ],
                  ),
                ),
                const SizedBox(height: 60), // Khoảng cách sau "30 Days"
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: InkWell(
                    onTap: () async {
                      // Xoá token từ Secure Storage
                      await _secureStorage.delete(key: 'authToken');
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginUI(), // Quay lại màn hình đăng nhập
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.logout, // Biểu tượng đăng xuất
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                        const SizedBox(
                            width: 5), // Khoảng cách giữa icon và chữ
                        Text(
                          'Đăng xuất', // "Đăng xuất"
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Phần bên phải (các Transform)
          Expanded(
            child: Container(
              color: const Color(0xFF292929), // Màu nền cho phần Expanded
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Các widget Transform
                    Transform.translate(
                      offset: const Offset(30.0, 270.0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.25),
                        child: Container(
                          width: 362.93,
                          height: 799.29,
                          decoration: ShapeDecoration(
                            color: const Color.fromARGB(255, 90, 88, 88),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(35.0, -570),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.22),
                        child: Container(
                          width: 362.93,
                          height: 799.29,
                          decoration: ShapeDecoration(
                            color: const Color.fromARGB(255, 56, 55, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(45.0, -1400.0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(0 - 0.18),
                        child: Container(
                          width: 362.93,
                          height: 799.29,
                          decoration: ShapeDecoration(
                            color: const Color.fromARGB(255, 20, 19, 19),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(20.0, -2150.0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.18),
                        child: GestureDetector(
                          onTap: () {
                            print('Hôm nay:$todayMessages');
                            print('7 ngày:$sevenDaysMessages');
                            print('30 ngày:$thirtyDaysMessages');

                            // Sử dụng Navigator để quay lại ChatPage với hiệu ứng chuyển cảnh
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const ChatPage(),
                                transitionsBuilder:
                                    (context, animation1, animation2, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation =
                                      animation1.drive(tween); //
                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          },
                          child: Container(
                            width: 90.63,
                            height: 90.63,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Icon(
                              Icons.menu,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Khung chat
                    Transform.translate(
                      offset: const Offset(250, -3100),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.18),
                        child: Container(
                          width: 221.13,
                          height: 189.91,
                          decoration: const ShapeDecoration(
                            color: Color.fromARGB(255, 70, 68, 68),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.66),
                                topRight: Radius.circular(12.66),
                                bottomRight: Radius.circular(12.66),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Khung chat
                    Transform.translate(
                      offset: const Offset(100, -2320),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.18),
                        child: Container(
                          width: 221.13,
                          height: 189.91,
                          decoration: const ShapeDecoration(
                            color: Color.fromARGB(255, 255, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.66),
                                topRight: Radius.circular(12.66),
                                bottomRight: Radius.circular(12.66),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: 200, // Điều chỉnh chiều rộng của Text
                              height: 50, // Điều chỉnh chiều cao của Text
                              child: Text(
                                'Chào bạn! Tôi có thể giúp gì cho bạn?',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
