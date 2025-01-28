import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
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
          child: Center(
            child: SvgPicture.asset(AppIcons.logo),
          ),
        ),
      ),
    );
  }
}
