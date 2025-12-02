import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class AppDimension {

  //if an Image child of Flexible this method will be called
  Widget makeImageMoreSmall(BuildContext context) {
    return MediaQuery.sizeOf(context).height <= 600
        ? const Flexible(flex: 2, child: SizedBox())
        : const SizedBox();
  }

  //mkate a listTile margin dynamically according to screen height
  double marginInsideListTile(BuildContext context) {
    if (isSmallScreen(context)) {
      return 2;
    } else if (isMediumScreen(context)) {
      return 3;
    } else {
      return 4;
    }
  }

  // if a screen height under or equal 600dp give true else give false
  // bool isSmallScreen(BuildContext context) {
  //   return MediaQuery.of(context).size.height <= 600;
  // }

  bool isMediumScreen(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    // debugPrint("screen width -> $screenWidth");
    // debugPrint("screen haight - > $screenHeight");
    double diagonalPixels = sqrt(pow(screenWidth, 2) + pow(screenHeight, 2));
    double screenInch = 550;
    if (screenHeight < 750) {
      screenInch = diagonalPixels / 116 + 10;
    } else if (screenHeight < 850) {
      screenInch = diagonalPixels / 116 + 15;
    } else if (screenHeight < 950) {
      screenInch = diagonalPixels / 116 + 20;
    }
    // debugPrint("the inch of screen is $screenInch");
    return screenInch > 6 || screenInch < 6.5;
  }

  bool isSmallScreen(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    double diagonalPixels = sqrt(pow(screenWidth, 2) + pow(screenHeight, 2));
    double screenInch = 550;
    if (screenHeight < 550) {
      screenInch = diagonalPixels / 116;
    } else if (screenHeight < 690) {
      if (Platform.isIOS) {
        screenInch = diagonalPixels / 160 ;
        // debugPrint("the inch of iOS  screen is $screenInch");
      }else {
        // debugPrint("the inch of screen is $screenInch");
        screenInch = diagonalPixels / 160 ;

      }
    } else if (screenHeight < 780) {
      screenInch = diagonalPixels / 137;
    } else if (screenHeight < 880) {
      screenInch = diagonalPixels / 160;
    } else if (screenHeight < 980) {
      screenInch = diagonalPixels / 165;
    }
    /*
    import 'dart:io';

void main() {
  if (Platform.isAndroid) {
    print('Running on Android');
  } else if (Platform.isIOS) {
    print('Running on iOS');
  }
}

     */

    return screenInch < 5.5;
  }

  bool isSmallScreenToAppBar(BuildContext context) {
    return MediaQuery.sizeOf(context).height <= 765;
  }
}
