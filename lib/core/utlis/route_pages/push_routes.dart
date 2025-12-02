import 'package:flutter/material.dart';

myPush({required BuildContext context, required Widget ui, String ?
routeName}) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (ctx) {
      return ui;
    },
    settings: RouteSettings(name: routeName),
  ));
}

//push and replace current screen
myPushReplace(BuildContext context, Widget page, String routeName) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (ctx) {
        return page;
      },
      settings: RouteSettings(name: routeName)));
}
Future<void> myPushReplaceFuture(BuildContext context,Widget page, String
routeName)async {
 await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (ctx) {
        return page;
      },
      settings: RouteSettings(name: routeName)));
}

//push and remove all screen until first screen
myPushAndRemoveUntilIsFirst(
    BuildContext context, Widget page, String routeName) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (ctx) {
        return page;
      },
      settings: RouteSettings(name: routeName),
    ),
    (route) => route.isFirst,
  );
}

//push and remove all screen until current screen
myPushAndRemoveUntilIsCurrent(
    BuildContext context, Widget page, String routeName) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (ctx) {
        return page;
      },
      settings: RouteSettings(name: routeName),
    ),
    (route) => route.isCurrent,
  );
}

//push and remove until screen is active
myPushAndRemoveUntilIsActive(
    BuildContext context, Widget page, String routeName) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (ctx) {
        return page;
      },
      settings: RouteSettings(name: routeName),
    ),
    (route) => route.isActive,
  );
}

myPushAndRemoveUntilName(BuildContext context, Widget page, String routeName) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (ctx) {
        return page;
      },
      settings: RouteSettings(name: routeName),
    ),
    (route) => route.settings.name == routeName,
  );
}

Future<void>myPushName(BuildContext context, String routeName,{Object ?
arguments})
async {
await  Navigator.of(context).pushNamed(routeName,arguments: arguments);

}

/*
//remove all the routes until screen you chosen
Ongoing gestures within the current route are canceled when a new route is pushed.
 */
myPushNameAndRemoveUntil(BuildContext context, String routeName,
    RoutePredicate predicate, String predicateRouteName) {
  if (predicateRouteName == "") {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  } else {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName,
        (Route<dynamic> route) => route.settings.name == predicateRouteName);
  }
}

//push and replacement Named
myPushReplacementNamed( String routeName,{BuildContext ? context}) {
  Navigator.of(context!).pushReplacementNamed(routeName);
}

 Future<void> myPushReplacementNamedFuture(String routeName,BuildContext
 context)async {
 await Navigator.pushReplacementNamed(context, routeName );
}



//testing animation screen navigation

// Future<void> myPushNameAnimation(BuildContext context) async {
//   await Navigator.of(context).pushReplacement(
//     PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) {
//         return const SplashScreenUi(); // Replace YourDestinationScreen with your actual destination screen
//       },
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0);
//         const end = Offset.zero;
//         const curve = Curves.fastEaseInToSlowEaseOut;
//         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//         var offsetAnimation = animation.drive(tween);
//
//         return SlideTransition(
//           position: offsetAnimation,
//           child: child,
//         );
//       },
//     ),
//   );
// }


// Example usage:
// Call myPushNameAnimation(context, 'destination_route_name'); where you want to navigate with animation
