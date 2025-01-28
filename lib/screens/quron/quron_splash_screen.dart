import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';
import 'package:taqvim/screens/home_screen.dart';
import 'package:taqvim/screens/quron/quron_home.dart';

class QuronSplashScreen extends StatefulWidget {
  const QuronSplashScreen({Key? key}) : super(key: key);

  @override
  State<QuronSplashScreen> createState() => _QuronSplashScreenState();
}

class _QuronSplashScreenState extends State<QuronSplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const QuronHome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.quronn, width: 100,height: 100,),
              const SizedBox(height: 340),
              const Text("Ushbu ma'lumotlar ochiq manbalardan olingan!!!", style: AppStyles.hijri,),
              const Text("Manba https://uz.wikipedia.org", style: AppStyles.hijri,),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
