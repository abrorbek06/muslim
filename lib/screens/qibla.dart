import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';
class QiblahScreenn extends StatefulWidget {
  const QiblahScreenn({Key? key}) : super(key: key);

  @override
  State<QiblahScreenn> createState() => _QiblahScreennState();
}

class _QiblahScreennState extends State<QiblahScreenn> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  final locationStream = StreamController<LocationStatus>.broadcast();

  Stream<LocationStatus> get stream => locationStream.stream;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  @override
  void dispose() {
    locationStream.close();
    FlutterQiblah().dispose();

    super.dispose();
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();

    if (locationStatus.enabled &&
        (locationStatus.status == LocationPermission.denied ||
            locationStatus.status == LocationPermission.deniedForever)) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      locationStream.sink.add(s);
    } else {
      locationStream.sink.add(locationStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                "Qibla",
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
              image: DecorationImage(image: AssetImage(AppIcons.bg_screen),fit: BoxFit.cover)
          ),          child: Center(
            child: FutureBuilder(
                future: _deviceSupport,
                builder: (context, AsyncSnapshot<bool?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: AppColors.mainColor);
                  }

                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error.toString()}");
                  }

                  return StreamBuilder(
                      stream: stream,
                      builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(color: AppColors.mainColor);
                        }

                        if (!snapshot.data!.enabled) {
                          return const Text("Lokatsiyaga ruxsat berilmagan");
                        }

                        switch (snapshot.data!.status) {
                          case LocationPermission.always:
                          case LocationPermission.whileInUse:
                            return StreamBuilder(
                                stream: FlutterQiblah.qiblahStream,
                                builder: (context,
                                    AsyncSnapshot<QiblahDirection> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator(color: AppColors.mainColor);
                                  }

                                  final qiblahDirection = snapshot.data;

                                  const pi = 3.14;

                                  return Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 500,
                                      maxHeight: 500,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Transform.rotate(
                                            angle: ((qiblahDirection?.direction ??
                                                0) *
                                                (pi / 180) *
                                                -1),
                                            child: SvgPicture.asset(
                                                AppIcons.kompas)),
                                        Transform.rotate(
                                            angle:
                                            ((qiblahDirection?.qiblah ?? 0) *
                                                (pi / 180) *
                                                -1),
                                            child: SvgPicture.asset(
                                                AppIcons.needle)),
                                      ],
                                    ),
                                  );
                                });
                          case LocationPermission.denied:
                            return const Text("Manzilga ruxsat o'chirilgan");
                          case LocationPermission.deniedForever:
                            return const Text(
                                "Manzilga ruxsat butunlayga o'chirilgan");
                          default:
                            return const SizedBox();
                        }
                      });
                }),
          ),
        ),
      ),
    );
  }
}