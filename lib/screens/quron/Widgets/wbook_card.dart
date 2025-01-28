import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';
import 'package:taqvim/screens/quron/Widgets/wbook_content.dart';
import 'package:taqvim/screens/quron/resource/data/entities.dart';

class WbookCard extends StatefulWidget {
  final Book book;
  const WbookCard({super.key, required this.book});

  @override
  State<WbookCard> createState() => _WbookCardState();
}

class _WbookCardState extends State<WbookCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            barrierColor: Colors.black12.withOpacity(0.5),
            builder: (c) => WbookContent(book: widget.book),
          );
        },
        child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.mainColor),
            borderRadius: BorderRadius.circular(10),
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
                    Text(widget.book.title, style: AppStyles.titleStyle.copyWith(fontSize: 20)),
                    const SizedBox(height: 6),
                    Text(
                      '${widget.book.surahnumber}-sura, ${widget.book.ayat} oyat',
                      style: AppStyles.hijri.copyWith(fontSize: 16),
                    )
                  ],
                ),
                SvgPicture.asset(
                  AppIcons.right_arrow_svg,
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
