import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:intl/intl.dart';
import 'responsive.dart';

class PoppinsText extends StatelessWidget {
  const PoppinsText(
      {super.key,
      required this.text,
      this.fontSize = 12,
      this.textColor = Colors.black,
      this.fontWeight = FontWeight.w400,
      this.overflow = TextOverflow.ellipsis,
      this.textAlign,
      this.textScaleFactor,
      this.maxLines,
      this.decoration,
      this.height});
  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getPoppinsStyle(
          height: height,
          decoration: decoration,
          fontSize: fontSize,
          textColor: textColor,
          fontWeight: fontWeight),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: false,
    );
  }
}

getPoppinsStyle(
    {double? height,
    TextDecoration? decoration,
    double? fontSize = 12,
    Color? textColor,
    FontWeight? fontWeight}) {
  return GoogleFonts.poppins(
      height: height,
      decoration: decoration,
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight);
}

createCustomDateFormat(DateTime day) {
  return "${day.day} ${DateFormat.MMM().format(day)} ${day.year}";
}

class MandatoryText extends StatelessWidget {
  const MandatoryText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          )),
      TextSpan(
          text: "*",
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xffEF4444),
            fontWeight: FontWeight.w400,
          ))
    ]));
  }
}

vFill(double height) {
  return SizedBox(
    height: height,
  );
}

hFill(double width) {
  return SizedBox(
    width: width,
  );
}

bool isLoading = false;
showLoading(message) {
  isLoading = true;
  showDialog(
    context: Get.overlayContext!,
    barrierDismissible: false,
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                  // boxShadow: getBoxShadow()
                ),
                child: CircularProgressIndicator(
                    // value: 0.5,
                    strokeWidth: 2.5,
                    color: Colors.blue),
              ),
              vFill(10),
              Text('$message...',
                  style: const TextStyle(fontSize: 20, color: Colors.white))
            ],
          ),
        ),
      ),
    ),
  );
}

showToastText(message) {
  showToast(message ?? "",
      textPadding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      duration: const Duration(seconds: 5),
      textStyle: const TextStyle(color: Colors.white),
      position: ToastPosition.bottom,
      backgroundColor: Colors.blue);
}

getResponsiveSize(
    context, double mobileSize, double tabsize, double desktopSize) {
  if (Responsive.isMobile(context)) {
    return mobileSize;
  } else if (Responsive.isTablet(context)) {
    return tabsize;
  } else {
    return desktopSize;
  }
}

List<BoxShadow> getBoxShadow() {
  return [
    BoxShadow(
      color: Colors.grey.shade300,
      offset: const Offset(
        0,
        4,
      ),
      blurRadius: 10,
      spreadRadius: 1.0,
    ),
    const BoxShadow(
      color: Colors.white,
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ),
  ];
}

List<BoxShadow> getBoxShadowOfTitle() {
  return [
    BoxShadow(
      color: Colors.grey.shade50,
      offset: const Offset(
        0,
        4,
      ),
      blurRadius: 10,
      spreadRadius: 1.0,
    ),
    const BoxShadow(
      color: Colors.white,
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ),
  ];
}

closeLoading() {
  if (isLoading) {
    isLoading = false;
    Navigator.of(Get.overlayContext!).pop();
  }
}

getStrCapFirst(String str) {
  if (str.isNotEmpty) {
    return str[0].toUpperCase() + str.toString().toLowerCase().substring(1);
  }
}

String getHyphenDateFormat(DateTime d) {
  return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
}
