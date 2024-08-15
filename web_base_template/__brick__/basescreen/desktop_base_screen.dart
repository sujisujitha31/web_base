import 'package:flutter/material.dart';
// import 'package:neovault_admin/components/body_container.dart';
// import 'package:neovault_admin/constant.dart' as c;

// import '../pages/navigation/navigation_view.dart';
// import 'package:neovault_admin/utils.dart' as u;

class DesktopBaseScreen extends StatelessWidget {
  const DesktopBaseScreen({
    super.key,
  });

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: c.screenBgColor,
        body: SafeArea(
            child: Column(children: [
          Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: buildHeader()),
          Row(
            children: [buildDrawer(context), buildBodyScreen(context)],
          ),
        ])));
  }

// this is drawer
  buildDrawer(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width * .17);
  }

// this is content area
  buildBodyContent(BuildContext context) {
    return const SizedBox();
  }

  buildBodyScreen(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * .839,
      width: screenSize.width * .83,
      child: SingleChildScrollView(
          child: SizedBox(
              width: screenSize.width * .8, child: buildBodyContent(context))),
    );
  }

  buildHeader() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
    );
  }
}
