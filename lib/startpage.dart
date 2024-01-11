import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hihihi/Accounts/login_ui.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 430,
        height: 932,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://s3-alpha-sig.figma.com/img/b550/edae/2d89b53b74c5172f29b550a1bb719640?Expires=1704067200&Signature=g6bXSO3iPNlyvTRlVSNfKIwME44FMX5pyCjq728wG6aAW1Gy6ssTzhyL09K-h692iPUz4jBF8fZm-B5IBXJv8I6kHsZk2GZBPnKDoOLud06-m4cJb6SWVs6hHbHHmI~IDmNEG2vCGjOFFYSkrOwUHQxwXtoqOUwmge3j6IAWAUt7ZTCWIchE2GLbgeNOb9dxwy9OjQWjCkRQ11MC4ky78GxC6Sy56akTbn0eH3oXN7nJ0x997WEOnak8xCn45jciw2bwPjglTc9G4krD4pRg1bVciaMNeLLil1~dNvo6ypOPgPNi0Q6gFiHPL6P-GK9eMZGWb8~SkikAglyKUZk~QA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: -20,
              child: Container(
                width: 470,
                height: 980,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://s3-alpha-sig.figma.com/img/b550/edae/2d89b53b74c5172f29b550a1bb719640?Expires=1704067200&Signature=g6bXSO3iPNlyvTRlVSNfKIwME44FMX5pyCjq728wG6aAW1Gy6ssTzhyL09K-h692iPUz4jBF8fZm-B5IBXJv8I6kHsZk2GZBPnKDoOLud06-m4cJb6SWVs6hHbHHmI~IDmNEG2vCGjOFFYSkrOwUHQxwXtoqOUwmge3j6IAWAUt7ZTCWIchE2GLbgeNOb9dxwy9OjQWjCkRQ11MC4ky78GxC6Sy56akTbn0eH3oXN7nJ0x997WEOnak8xCn45jciw2bwPjglTc9G4krD4pRg1bVciaMNeLLil1~dNvo6ypOPgPNi0Q6gFiHPL6P-GK9eMZGWb8~SkikAglyKUZk~QA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 430,
                height: 932,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: const Alignment(1.50, -0.40),
                        end: const Alignment(0, 1),
                        colors: [Colors.black.withOpacity(0), Colors.black])),
              ),
            ),
            Positioned(
              left: 20,
              top: 400,
              child: SizedBox(
                width: 330,
                child: Text(
                  'The Future of Chat is Here\n With AI Technology',
                  style: GoogleFonts.bitter(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40,
              top: 510,
              child: SizedBox(
                width: 300,
                height: 280,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '"The future of chat is here with AI technology"',
                        style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: GoogleFonts.cabin(
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text:
                            'sự kết hợp của trí tuệ nhân tào và công nghệ trò chuyện đã bắt đầu và đây là một phát triển hứng thú cho cách chúng ta giao tiếp',
                        style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 38,
              top: 800,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginUI()),
                  );
                },
                child: SizedBox(
                  width: 355,
                  height: 53,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 355,
                          height: 53,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD71D1D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 130,
                        top: 10,
                        child: SizedBox(
                          width: 90,
                          height: 55,
                          child: Text(
                            'Bắt đầu',
                            style: GoogleFonts.cabin(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                            textAlign:
                                TextAlign.center, // Căn giữa theo chiều ngang
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 70,
              top: 880,
              child: SizedBox(
                width: 300,
                height: 50,
                child: Align(
                  alignment: Alignment.center,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
