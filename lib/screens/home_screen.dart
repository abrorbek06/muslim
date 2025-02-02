import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';
import 'package:taqvim/screens/quron/quron_splash_screen.dart';
import 'package:taqvim/screens/ramazon_taqvim_screen.dart';
import 'package:taqvim/screens/tasbeh/tasbih_home.dart';
import 'package:taqvim/screens/time_namaz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppIcons.bg), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 52),
                    
                    SvgPicture.asset(AppIcons.logo),
                    const SizedBox(height: 34),
                    _Title1(
                      title: "Quron",
                      icon: AppIcons.quron,
                      screen: const QuronSplashScreen(),
                    ),

                    _Title1(
                      title: "Namoz Vaqtlari",
                      icon: AppIcons.nomoz_vaqtlari_icon,
                      screen: const TimeNamazScreen(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Title2(
                          title: "Tasbeh",
                          icon: AppIcons.tasbeh_icon,
                          screen: const TasbehListScreen(),
                        ),
                        _Title2(
                          title: "Ramazon\ntaqvimi",
                          icon: AppIcons.roza_vaqtlari_icon,
                          screen: const RamazonTaqvim(),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: -430,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      SvgPicture.asset(AppIcons.developer_icon),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Developed with ",
                              style: AppStyles.developedStyle),
                          Text(
                            "Flutter",
                            style: AppStyles.developedStyle
                                .copyWith(color: AppColors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _Title1({
    required String title,
    required String icon,
    required Widget screen,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screen));
          },
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.mainColor, width: 7)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.asset(
                    icon,
                    width: 52,
                  ),
                  const SizedBox(width: 15),
                  Text(title, style: AppStyles.titleStyle),
                ],
              ),
            ),
          ),
        ),
      );
  _Title2({
    required String title,
    required String icon,
    required Widget screen,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screen));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.40,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.mainColor, width: 7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  width: 44,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Text(title, style: AppStyles.titleStyle.copyWith(fontSize: 16)),
              ],
            ),
          ),
        ),
      );
}
