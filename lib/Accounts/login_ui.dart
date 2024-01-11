// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:hihihi/accounts/register_ui.dart';
import 'package:hihihi/chat_page.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  LoginUIState createState() => LoginUIState();
}

class LoginUIState extends State<LoginUI> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  _checkAutoLogin() async {
    String? token = await _secureStorage.read(key: 'authToken');

    if (token != null) {
      // Người dùng đã đăng nhập, chuyển đến trang ChatPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatPage(),
        ),
      );
    }
  }

  void _login() async {
    print("Attempting to login...");
    if (_emailController.text == 'admin' &&
        _passwordController.text == 'admin') {
      // Hiển thị SnackBar thông báo đăng nhập thành công
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: const Text(
            'Đã đăng nhập thành công',
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 1), // 1.5 giây
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.green, // Màu nền thông báo thành công
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Đợi SnackBar hiển thị xong
      await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

      // Lưu thông tin đăng nhập an toàn vào Flutter Secure Storage
      await _secureStorage.write(key: 'authToken', value: 'exampleToken');

      // Chuyển đến trang ChatPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatPage(),
        ),
      );
    } else {
      // Hiển thị SnackBar nếu thông tin đăng nhập không chính xác
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: const Text(
            'Tài khoản hoặc mật khẩu không đúng',
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 430,
        height: 930,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 430,
                height: 932,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 17, 17, 17),
                ),
              ),
            ),
            Positioned(
              left: 107,
              top: 100,
              child: Text(
                'Chat AI',
                style: GoogleFonts.k2d(
                  color: Colors.white,
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
            Positioned(
              left: 60,
              top: 190,
              child: SizedBox(
                width: 500,
                child: Text(
                  'Vui lòng đăng nhập tài khoản của bạn',
                  style: GoogleFonts.k2d(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 50,
              top: 250,
              child: SizedBox(
                width: 250,
                height: 80,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: 80,
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 80,
                                height: 70,
                                decoration: ShapeDecoration(
                                  color: const Color.fromARGB(255, 46, 44, 44),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Hiển thị SnackBar với thông báo
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Chức năng đang được hoàn thiện vui lòng quay lại sau"),
                                          duration: Duration(
                                              seconds:
                                                  1), // Thời gian hiển thị là 1 giây
                                        ),
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      'lib/assets/icons/google.svg',
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
            ),
            // Facebook
            Positioned(
              left: 170,
              top: 250,
              child: SizedBox(
                width: 80,
                height: 70,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 80,
                        height: 70,
                        decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 46, 44, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () {
                              // Hiển thị SnackBar với thông báo
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Chức năng đang được hoàn thiện vui lòng quay lại sau"),
                                  duration: Duration(
                                      seconds:
                                          1), // Thời gian hiển thị là 1 giây
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              'lib/assets/icons/facebook.svg',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Apple
            Positioned(
              left: 290,
              top: 250,
              child: SizedBox(
                width: 80,
                height: 70,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 80,
                        height: 70,
                        decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 46, 44, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () {
                              // Hiển thị SnackBar với thông báo
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Chức năng đang được hoàn thiện vui lòng quay lại sau"),
                                  duration: Duration(
                                      seconds:
                                          1), // Thời gian hiển thị là 1 giây
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              'lib/assets/icons/apple.svg',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 105,
              top: 370,
              child: SizedBox(
                width: 200,
                height: 20,
                child: Stack(
                  children: [
                    Positioned(
                      left: 100,
                      top: 0,
                      child: Text(
                        'or',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 470,
              child: SizedBox(
                width: 355,
                height: 64,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 355,
                        height: 53,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF292929),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 5,
                      child: SizedBox(
                        width: 300,
                        height: 40,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 19,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.k2d(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  height: 1.42,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nhập Email',
                                  hintStyle: GoogleFonts.k2d(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                  ),
                                  enabledBorder: InputBorder.none,
                                ),
                                onChanged: (value) =>
                                    _emailController.text = value.trim(),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 550,
              child: SizedBox(
                width: 355,
                height: 64,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 355,
                        height: 53,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF292929),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 5,
                      child: SizedBox(
                        width: 300,
                        height: 40,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 19,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.k2d(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  height: 1.42,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nhập mật khẩu',
                                  hintStyle: GoogleFonts.k2d(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                  ),
                                  enabledBorder: InputBorder.none,
                                ),
                                obscureText: true,
                                onChanged: (value) =>
                                    _passwordController.text = value.trim(),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 670,
              child: SizedBox(
                width: 355,
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _login,
                        child: Container(
                          width: 350,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 135,
                      top: 15,
                      child: Text(
                        'Đăng Nhập',
                        style: GoogleFonts.k2d(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 300,
              top: 630,
              child: Text(
                'Quên mật khẩu',
                style: GoogleFonts.k2d(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
            Positioned(
              left: 160,
              top: 750,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Chưa có tài khoản? ',
                      style: GoogleFonts.k2d(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                    TextSpan(
                      text: 'Đăng ký ngay!',
                      style: GoogleFonts.k2d(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 142,
              top: 895,
              child: SizedBox(
                width: 300,
                height: 50,
                child: Text(
                  'Powered by TrungHieu',
                  style: GoogleFonts.irishGrover(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
