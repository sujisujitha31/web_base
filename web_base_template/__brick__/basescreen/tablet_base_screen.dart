import 'package:flutter/material.dart';

class TabletBaseScreen extends StatelessWidget {
  const TabletBaseScreen({
    super.key,
  });

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Get.find<MainController>().exitFromApp();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
          ),
          // backgroundColor: c.screenBgColor,
          drawer: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const SizedBox()),
          // key: controller.scaffoldState,
          body: SafeArea(
            child: buildBodyContent(
              context,
            ),
          )),
    );
  }

// this is content area
  // buildBodyContent(BuildContext context) {
  //   return const SizedBox();
  // }

  buildBodyContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const SingleChildScrollView(child: SizedBox()),
    );
  }
}
