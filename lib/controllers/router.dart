import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:justeprix2/views/accueil.dart';
import 'package:justeprix2/views/classement.dart';
import 'package:justeprix2/views/jeu.dart';
import 'package:justeprix2/views/regles.dart';

class NavigationHelper {
  static late final GoRouter router;
  static final NavigationHelper _instance = NavigationHelper._internal();
  static NavigationHelper get instance => _instance;

  factory NavigationHelper(){
    return _instance;
  }

  static final GlobalKey<NavigatorState> parentNavigatorKey =
  GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
  GlobalKey<NavigatorState>();

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  NavigationHelper._internal(){
    final routes = [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => getPage(child: const AccueilPage(), state: state),
      ),
      GoRoute(
        name: 'accueil',
        path: '/accueil',
        pageBuilder: (context, state) => getPage(child: const AccueilPage(), state: state),
      ),
      GoRoute(
        name: 'jeu',
        path: '/jeu/:nom/:difficulty',
        pageBuilder: (context, state) => getPage(child:  JeuPage(nom: state.pathParameters['nom'] ?? '', difficulty: state.pathParameters['difficulty'] ?? ''), state: state),
      ),
      GoRoute(
        name: 'classement',
        path: '/classement/:nom',
        pageBuilder: (context, state) => getPage(child: ClassementPage(nom: state.pathParameters['nom'] ?? ''), state: state),
      ),
      GoRoute(
        name: 'regles',
        path: '/regles',
        pageBuilder: (context, state) => getPage(child: const ReglesPage(), state: state),
      ),
    ];
    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: '/',
      routes: routes,
    );
  }
}