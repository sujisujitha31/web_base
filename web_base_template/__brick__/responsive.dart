import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget tabletScaffold;
  final Widget desktopScaffold;

  const Responsive({
    super.key,
    required this.mobileScaffold,
    required this.tabletScaffold,
    required this.desktopScaffold,
  });

  static const kMobileSizeThreshold = 650;
  static const kTabletSizeThreshold = 1100;

  static bool isMobileScreen(double width) => width < kMobileSizeThreshold;

  static bool isTabletScreen(double width) =>
      width >= kMobileSizeThreshold && width < kTabletSizeThreshold;

  static bool isDesktopScreen(double width) => width >= kTabletSizeThreshold;

  static bool isMobile(BuildContext context) =>
      isMobileScreen(MediaQuery.of(context).size.width);

  static bool isTablet(BuildContext context) =>
      isTabletScreen(MediaQuery.of(context).size.width);

  static bool isDesktop(BuildContext context) =>
      isDesktopScreen(MediaQuery.of(context).size.width);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isDesktopScreen(constraints.maxWidth)) {
          return desktopScaffold;
        } else if (isTabletScreen(constraints.maxWidth)) {
          return tabletScaffold;
        } else {
          return mobileScaffold;
        }

        /*if (constraints.maxWidth >= kTabletSizeThreshold) {
          return desktopScaffold;
        } else if (constraints.maxWidth >= kMobileSizeThreshold &&
            constraints.maxWidth < kTabletSizeThreshold) {
          return tabletScaffold;
        } else {
          return mobileScaffold;
        }*/
      },
    );
  }
}
