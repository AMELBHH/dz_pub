import 'package:flutter/material.dart';

myPopUntilRouteName(BuildContext context, String routeName) {
  Navigator.of(context).popUntil((route) => route.settings.name == routeName);
}

// myPopUntilIsFirst(BuildContext context, String routeName) {
//   Navigator.of(context).popUntil((route) => route.isFirst);
// }

// myPopUntilIsCurrent(BuildContext context, String routeName) {
//   Navigator.of(context).popUntil((route) => route.isCurrent);
// }

// myPopUntilIsActive(BuildContext context, String routeName) {
//   Navigator.of(context).popUntil((route) => route.isActive);
// }

mypopAndPushNamed(BuildContext context, String routeName) {
  Navigator.of(context).popAndPushNamed(routeName);
}
