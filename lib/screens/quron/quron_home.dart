import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';
import 'package:taqvim/screens/quron/Widgets/wbook_card.dart';
import 'package:taqvim/screens/quron/resource/data/book_data.dart';

class QuronHome extends StatefulWidget {
  const QuronHome({super.key});

  @override
  State<QuronHome> createState() => _QuronHomeState();
}

class _QuronHomeState extends State<QuronHome> {
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
              "Quron",
              style: AppStyles.titleStyle,
            ),
          ],
        ),
        flexibleSpace: SvgPicture.asset(AppIcons.galaxy, fit: BoxFit.cover),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29),
        child: Scrollbar(child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return WbookCard(book: books[index]);
          },
          itemCount: books.length,
        ),)
      ),
    );
  }
}
