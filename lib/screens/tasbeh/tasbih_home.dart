import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';
import 'package:taqvim/screens/tasbeh/tasbih_screen.dart';

class TasbehListScreen extends StatefulWidget {
  const TasbehListScreen({super.key});

  @override
  State<TasbehListScreen> createState() => _TasbehListScreenState();
}

class _TasbehListScreenState extends State<TasbehListScreen> {
  final List<String> tasbehList = [
    'Subhanallah',
    'Alhamdulillah',
    'Allahu Akbar',
    'La ilaha illallah',
    'Astaghfirulloh',
  ];
  final List<String> tasbehAList = [
    'سُبْحَانَ ٱللهِ',
    'ٱلْحَمْدُ لِلَّٰهِ',
    'اللّٰهُ أَكْبَر',
    'لَا إِلَٰهَ إِلَّا ٱللَّٰهُ',
    'أَسْتَغْفِرُ ٱللَّٰهَ',
  ];

  late Map<String, int> counters;

  @override
  void initState() {
    super.initState();
    counters = {};
    _loadCounters();
  }

  Future<void> _loadCounters() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var tasbeh in tasbehList) {
        counters[tasbeh] = prefs.getInt(tasbeh) ?? 0;
      }
    });
  }

  void _openTasbehScreen(String tasbeh, String tasbeha) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TasbehScreen(
          tasbeh: tasbeh,
          tasbeha: tasbeha,
          initialCount: counters[tasbeh] ?? 0,
          onCountUpdated: (newCount) async {
            final prefs = await SharedPreferences.getInstance();
            setState(() {
              counters[tasbeh] = newCount;
              prefs.setInt(tasbeh, newCount);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
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
            const Text(
              "Tasbeh",
              style: AppStyles.titleStyle,
            ),
          ],
        ),
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
          padding: const EdgeInsets.all(24),
          child: ListView.builder(
            itemCount: tasbehList.length,
            itemBuilder: (context, index) {
              final tasbeh = tasbehList[index];
              final tasbeha = tasbehAList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => _openTasbehScreen(tasbeh, tasbeha),
                  child: Container(
                    width: double.infinity,
                    height: 77,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tasbeh,
                                style: AppStyles.noAdsStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                tasbeha,
                                style: AppStyles.tasbih_soni
                                    .copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${counters[tasbeh] ?? 0}',
                                style: AppStyles.tasbih_soni
                                    .copyWith(fontSize: 18),
                              ),
                              const SizedBox(width: 30),
                              SvgPicture.asset(
                                AppIcons.right_arrow_svg,
                                width: 16,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
