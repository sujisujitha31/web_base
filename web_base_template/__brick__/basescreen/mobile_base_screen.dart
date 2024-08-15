import 'package:flutter/material.dart';

class MobileBaseScreen extends StatelessWidget {
  const MobileBaseScreen({
    super.key,
  });

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Get.find<MainController>().exitFromApp();
        return Future.value(true);
      },
      child: Scaffold(
        // backgroundColor: c.screenBgColor,
        appBar: AppBar(
          toolbarHeight: 70,
          actions: [],
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        // drawer: const CustomDrawerWidget(),
        body: Container(
          height: double.infinity,
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: buildBodyContent(context),
          ),
        ),
      ),
    );
  }

  Widget buildBodyContent(BuildContext context) {
    return const SizedBox();
  }
}
