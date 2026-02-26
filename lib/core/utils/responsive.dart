import 'package:flutter/material.dart';

class Responsive {
  static const double compactWidth = 600;
  static const double mediumWidth = 840;
  static const double expandedWidth = 1200;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < compactWidth;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= compactWidth && width < mediumWidth;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= mediumWidth;
  }

  static int getGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < compactWidth) {
      return 2;
    } else if (width < mediumWidth) {
      return 3;
    } else if (width < expandedWidth) {
      return 4;
    } else {
      return 6;
    }
  }

  static double getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < compactWidth) {
      return 8.0;
    } else if (width < mediumWidth) {
      return 16.0;
    } else {
      return 24.0;
    }
  }

  static double getGridSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < compactWidth) {
      return 8.0;
    } else if (width < mediumWidth) {
      return 12.0;
    } else {
      return 16.0;
    }
  }

  static double getMaxContentWidth(BuildContext context) {
    return expandedWidth;
  }
}
