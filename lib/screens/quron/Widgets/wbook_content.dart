import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';
import 'package:taqvim/screens/quron/resource/data/entities.dart';
import 'package:taqvim/screens/quron/screens/ListenScreenArab.dart';
import 'package:taqvim/screens/quron/screens/ListenScreenUzb.dart';
import 'package:taqvim/screens/quron/screens/ReadScreen.dart';

class WbookContent extends StatefulWidget {
  final Book book;
  const WbookContent({super.key, required this.book});

  @override
  State<WbookContent> createState() => _WbookContentState();
}

class _WbookContentState extends State<WbookContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 500,
          // margin: const EdgeInsets.symmetric(),
          decoration: const BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${widget.book.surahnumber}",
                            style: AppStyles.ramadantitleStyle,
                          ),
                          Text('Tartib raqami',
                              style:
                              AppStyles.hijri.copyWith(fontSize: 16))
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${widget.book.ayat}",
                            style: AppStyles.ramadantitleStyle,
                          ),
                          Text('Oyatlar soni',
                              style:
                              AppStyles.hijri.copyWith(fontSize: 16))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Qisqacha ma'lumot",
                    style: AppStyles.noAdsStyle
                        .copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.book.deskription,
                    style: AppStyles.hijri.copyWith(fontSize: 14),
                  ),
                  // const SizedBox(height: 24),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     _Buttons("O'qish", AppIcons.readIcon, Readscreen(book: widget.book)),
                  //     _Buttons("Eshitish(uzb)", AppIcons.listenIcon, Listenscreenuzb(book: widget.book)),
                  //   ],
                  // ),
                  // const SizedBox(height: 16),
                  // Center(
                  //   child: _Buttons("Eshitish(arb)", AppIcons.listenIcon, Listenscreenarab(book: widget.book)),
                  // ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: -150,
          child: Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              widget.book.image,
            ),
          ),
        ),
      ],
    );
  }

  _Buttons(String title, String image, Widget screen) => GestureDetector(
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
    },
    child: Container(
      width: 153,
      height: 43,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.mainColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppStyles.developedStyle.copyWith(color: AppColors.white),),
          const SizedBox(width: 4),
          SvgPicture.asset(image),
        ],
      ),
    ),
  );
}
