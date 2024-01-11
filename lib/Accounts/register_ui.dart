import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hihihi/Accounts/login_ui.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  void showDevelopmentMessage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thông báo'),
        content: const Text(
            'Chức năng này đang được phát triển\nVui lòng đăng nhập với tài khoản và mật khẩu là "admin" để trải nghiệm'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 430,
        height: 932,
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
              left: 115,
              top: 90,
              child: Text(
                'Chat AI',
                style: GoogleFonts.k2d(
                  color: Colors.white,
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              left: 70,
              top: 195,
              child: SizedBox(
                width: 290,
                child: Text(
                  'Vui lòng đăng ký tài khoản của bạn',
                  style: GoogleFonts.k2d(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    height: 1,
                  ),
                  textAlign: TextAlign.center, // Căn giữa theo chiều ngang
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
                                        const SnackBar(
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

            //Facebook
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
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () {
                              // Hiển thị SnackBar với thông báo
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
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

            //Apple
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
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () {
                              // Hiển thị SnackBar với thông báo
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
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
              left: 40,
              top: 430,
              child: SizedBox(
                width: 350,
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 350,
                        height: 50,
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
                            const Icon(Icons.person,
                                color: Colors.white, size: 19),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.k2d(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.42,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nhập tên',
                                  hintStyle: GoogleFonts.k2d(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.42,
                                  ),
                                  enabledBorder: InputBorder.none,
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
            Positioned(
              left: 40,
              top: 520,
              child: SizedBox(
                width: 350,
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 350,
                        height: 50,
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
                            const Icon(Icons.person,
                                color: Colors.white, size: 19),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.k2d(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.42,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nhập Email',
                                  hintStyle: GoogleFonts.k2d(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.42,
                                  ),
                                  enabledBorder: InputBorder.none,
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
            Positioned(
              left: 40,
              top: 610,
              child: SizedBox(
                width: 350,
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 350,
                        height: 50,
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
                            const Icon(Icons.person,
                                color: Colors.white, size: 19),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.k2d(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.42,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nhập mật khẩu',
                                  hintStyle: GoogleFonts.k2d(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.42,
                                  ),
                                  enabledBorder: InputBorder.none,
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
            Positioned(
              left: 30,
              top: 710,
              child: SizedBox(
                width: 360,
                height: 50,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          showDevelopmentMessage();
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Đăng ký',
                        style: GoogleFonts.k2d(
                          color: Colors.white,
                          fontSize: 23,
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
              left: 130,
              top: 790,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Đã có tài khoản?  ',
                      style: GoogleFonts.k2d(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                    TextSpan(
                      text: 'Đăng Nhập!',
                      style: GoogleFonts.k2d(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginUI(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 140,
              top: 890,
              child: SizedBox(
                width: 300,
                height: 50,
                child: Text(
                  'Powered by Trung Hieu',
                  style: GoogleFonts.irishGrover(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
