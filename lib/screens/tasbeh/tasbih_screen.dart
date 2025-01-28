import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';

class TasbehScreen extends StatefulWidget {
  final String tasbeh;
  final String tasbeha;
  final int initialCount;
  final ValueChanged<int> onCountUpdated;

  const TasbehScreen({
    super.key,
    required this.tasbeh,
    required this.tasbeha,
    required this.initialCount,
    required this.onCountUpdated,
  });

  @override
  State<TasbehScreen> createState() => _TasbehScreenState();
}

class _TasbehScreenState extends State<TasbehScreen> {
  late int count;
  int _a = 0;
  bool i = false;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  void _increment() {
    setState(() {
      count++;
      _a++;
      if (i == false && _a == 33 ||
          i == false && _a == 66 ||
          i == false && _a == 99) {
        _a = 0;
      } else if (i == true && _a == 99) {
        _a = 0;
      }
      widget.onCountUpdated(count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.asset(
                      AppIcons.left_arrow_png,
                      width: 25,
                    ),
                  )),
              const SizedBox(width: 14),
              Text(
                widget.tasbeh,
                style: AppStyles.titleStyle.copyWith(fontSize: widget.tasbeh.length >= 20 ? 18 : 24),
              ),
            ],),
            // SizedBox(width: MediaQuery.of(context).size.width * 0.28),
            GestureDetector(
              onTap: () {
                setState(() {
                  _a = 0;
                  count = 0;
                  widget.onCountUpdated(count);
                });
              },
              child: Image.asset(
                AppIcons.refresh,
                width: 25,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: SvgPicture.asset(AppIcons.galaxy, fit: BoxFit.cover),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppIcons.bg_screen), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        i == false ? i = true : i = false;
                      });
                    },
                    child: Container(
                      width: 75,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(width: 2, color: AppColors.gray),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$_a/${i == false ? "33" : "99"}",
                            style: AppStyles.tasbih_soni,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 43),
              Text(
                widget.tasbeha,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                '$count',
                style: AppStyles.titleStyle.copyWith(fontSize: 96),
              ),
              const SizedBox(height: 55),
              GestureDetector(
                onTap: _increment,
                child: Image.asset(
                  AppIcons.tasbeh,
                  width: 193,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
