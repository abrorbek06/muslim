import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';
import 'package:taqvim/screens/quron/resource/data/entities.dart';

class Listenscreenuzb extends StatefulWidget {
  final Book book;
  const Listenscreenuzb({super.key, required this.book});

  @override
  State<Listenscreenuzb> createState() => _ListenscreenuzbState();
}

class _ListenscreenuzbState extends State<Listenscreenuzb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
              widget.book.title,
              style: AppStyles.titleStyle,
            ),
          ],
        ),
        flexibleSpace: SvgPicture.asset(AppIcons.galaxy, fit: BoxFit.cover),
      ),
    );
  }
}
