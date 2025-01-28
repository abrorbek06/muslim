import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taqvim/resours/colors.dart';
import 'package:taqvim/resours/icons.dart';
import 'package:taqvim/resours/styles.dart';
import 'package:taqvim/screens/quron/resource/data/entities.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Readscreen extends StatefulWidget {
  final Book book;
  const Readscreen({super.key, required this.book});

  @override
  State<Readscreen> createState() => _ReadscreenState();
}

class _ReadscreenState extends State<Readscreen> {
  bool isFailed = false;
  String errorText = "";
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
            Text(
              widget.book.title,
              style: AppStyles.titleStyle,
            ),
          ],
        ),
        flexibleSpace: SvgPicture.asset(AppIcons.galaxy, fit: BoxFit.cover),
      ),
      body: isFailed
          ? Text(errorText, style: AppStyles.tasbih_soni)
          : SfPdfViewer.asset(
              widget.book.book,
              enableTextSelection: false,
              onDocumentLoadFailed: (value) {
                setState(() {
                  isFailed = true;
                  errorText = value.description;
                });
              },
            ),
    );
  }
}
