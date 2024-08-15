import 'package:flutter/material.dart';
import '../responsive.dart';
import 'desktop_base_screen.dart';
import 'mobile_base_screen.dart';
import 'tablet_base_screen.dart';

class ResponsiveBaseScreen extends StatelessWidget {
  const ResponsiveBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
        mobileScaffold: MobilePage(),
        tabletScaffold: TabletPage(),
        desktopScaffold: DesktopPage());
  }
}

class DesktopPage extends DesktopBaseScreen {
  const DesktopPage({super.key});

  @override
  buildBodyContent(BuildContext context) {
    return const SizedBox();
  }
}

class TabletPage extends TabletBaseScreen {
  const TabletPage({super.key});
  @override
  buildBodyContent(BuildContext context) {
    // final navigationCont = Get.find<NavigationController>();
    return const SizedBox();
  }
}

class MobilePage extends MobileBaseScreen {
  const MobilePage({super.key});

  @override
  Widget buildBodyContent(BuildContext context) {
    return const SizedBox();
  }
}
