// import 'package:flutter/material.dart';

// class OnspaceRouteObserver extends NavigatorObserver {
//   static bool canPopSubmitForm = false;
//   static bool canPopEditForm = false;
//   static bool canPopSubformEdit = false;
// }

// class OnspaceRouter {
//   static final _routeObserver = OnspaceRouteObserver();

//   static GoRouter get router => _router;
//   static GlobalKey<NavigatorState> get navigator =>
//       _webOnBoardingRootNavigatorKey;

//   static const String decision = '/';

//   static const String signIn = '/signIn';
//   static const String socialAuthSignIn = '/signIn/:userDetails';
//   static const String resetPassword = '/resetPassword';

//   static final GlobalKey<NavigatorState> _webOnBoardingRootNavigatorKey =
//       GlobalKey<NavigatorState>();

//   static final _router = GoRouter(
//       observers: [_routeObserver],
//       initialLocation: '/',
//       navigatorKey: _webOnBoardingRootNavigatorKey,
//       routes: [
//         GoRoute(
//           path: decision,
//           name: decision,
//           builder: (context, state) => const DecisionPage(),
//         ),
//         GoRoute(
//           path: signIn,
//           name: signIn,
//           builder: (context, state) => const SignInPage(),
//         )
//       ]);
// }
