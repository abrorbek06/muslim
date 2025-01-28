import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';

class RamazonTaqvim extends StatefulWidget {
  const RamazonTaqvim({super.key});

  @override
  State<RamazonTaqvim> createState() => _RamazonTaqvimState();
}

class _RamazonTaqvimState extends State<RamazonTaqvim> {
  Future<Position> _detectPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Lokatsiya xizmati o'chirislgan");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return Future.error("Lokatsiyadan foydalanishga ruxsat berilmagn");
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Map<String, dynamic>> fetchPrayerTime(
      double latitude, double longitude) async {
    final dio = Dio();

    try {
      final response =
      await dio.get("http://api.aladhan.com/v1/calendar", queryParameters: {
        "latitude": latitude,
        "longitude": longitude,
        "method": 2,
        "month": DateTime.now().month,
        "year": DateTime.now().year,
      });

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Xatolik sodir bo'ldi ma'lumotlarni yuklashda");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<dynamic> result = [];

  getData() async {
    final Position position = await _detectPosition();
    final response =
    await fetchPrayerTime(position.latitude, position.longitude);

    setState(() {
      result = response['data'];
      // ignore: avoid_print
      print(result);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
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
              "Ramazon taqvimi",
              style: AppStyles.titleStyle,
            ),
          ],
        ),
        flexibleSpace: SvgPicture.asset(AppIcons.galaxy, fit: BoxFit.cover),
      ),
      body: result.isEmpty
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.orangeAccent,
        ),
      )
          : Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppIcons.bg_screen),
              fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: [
            const Divider(
              thickness: 0.5,
              color: AppColors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.09),
                  const Text("Sana", style: AppStyles.ramadantitleStyle),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.18),
                  Text(
                    "Saharlik",
                    style: AppStyles.ramadantitleStyle
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Text(
                    "Iftorlik",
                    style: AppStyles.ramadantitleStyle
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: AppColors.gray)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  result[index]['date']['readable'],
                                  style: const TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),Row(
                                  children: [
                                    Text(
                                      "${result[index]['date']['hijri']['month']['en']} ",
                                      style: AppStyles.hijri,
                                    ),
                                    Text(
                                      "${result[index]['date']['hijri']['day']}, ",
                                      style: AppStyles.hijri,
                                    ),
                                    Text(
                                      "${result[index]['date']['hijri']['date'].split("-")[2]}",
                                      style: AppStyles.hijri,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            Text(
                              "${result[index]['timings']['Fajr'].split(" ")[0]}",
                              style: const TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 16,
                                fontFamily: "Krona One",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${result[index]['timings']['Sunset'].split(" ")[0]}",
                              style: const TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 16,
                                fontFamily: "Krona One",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),
                    ],
                  ),
                ),
                itemCount: result.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
