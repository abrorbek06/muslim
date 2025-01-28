import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';

class TimeNamazScreen extends StatefulWidget {
  const TimeNamazScreen({super.key});

  @override
  State<TimeNamazScreen> createState() => _TimeNamazScreenState();
}

class _TimeNamazScreenState extends State<TimeNamazScreen> {
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
              "Namoz vaqtlari",
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
                    image: AssetImage("assets/bg_screen.png"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  const Divider(
                    thickness: 0.5,
                    color: AppColors.white,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Container(
                              width: 245,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: AppColors.gray)),
                              child: Center(
                                child: Text(
                                  result[index]['date']['readable'],
                                  style: const TextStyle(
                                    color: AppColors.gray,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Krona One",
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border:
                                          Border.all(color: AppColors.gray)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        "Bomdod",
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 10,
                                          fontFamily: "Alfa Slab One",
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${result[index]['timings']['Fajr'].split(" ")[0]}",
                                            style: const TextStyle(
                                              color: AppColors.mainColor,
                                              fontSize: 9,
                                              fontFamily: "Krona One",
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "${result[index]['timings']['Sunrise'].split(" ")[0]}",
                                            style: const TextStyle(
                                              color: AppColors.mainColor,
                                              fontSize: 9,
                                              fontFamily: "Krona One",
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                _NomozVaqtlari(index, "Peshin", "${result[index]['timings']['Dhuhr'].split(" ")[0]}"),
                                // const SizedBox(width: 1),
                                _NomozVaqtlari(index, "Asr", "${result[index]['timings']['Asr'].split(" ")[0]}"),
                                _NomozVaqtlari(index, "Shom", "${result[index]['timings']['Sunset'].split(" ")[0]}",),
                                _NomozVaqtlari(index, "Xufton", "${result[index]['timings']['Isha'].split(" ")[0]}"),
                              ],
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
  _NomozVaqtlari(int index, String title, String texxt) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border:
            Border.all(color: AppColors.gray)),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 10,
                fontFamily: "Alfa Slab One",
              ),
            ),
            Text(
              texxt,
              style: const TextStyle(
                color: AppColors.mainColor,
                fontSize: 11,
                fontFamily: "Krona One",
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}


// Expanded(
//   child: ListView.builder(
//     itemBuilder: (_, index) => Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30),
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 55,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(7),
//                 border: Border.all(color: AppColors.mainColor)),
//             child: Center(
//               child: Text(
//                 result[index]['date']['gregorian']['month']['en'],
//                 style: const TextStyle(
//                   color: AppColors.mainColor,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: "Krona One",
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 0,)
//         ],
//       ),
//     ),
//     itemCount: 1,
//   ),
// ),
