import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'models/models.dart';
import 'navigator/app_route_parser.dart';
import 'screens/screens.dart';
// TODO: Import app_router

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appStateManager = AppStateManager();
  await appStateManager.initializeApp();
  runApp(Fooderlich(appStateManager: appStateManager));
}

class Fooderlich extends StatefulWidget {
  final AppStateManager appStateManager;

  const Fooderlich({super.key, required this.appStateManager});

  @override
  FooderlichState createState() => FooderlichState();
}

class FooderlichState extends State<Fooderlich> {
  late final _groceryManager = GroceryManager();
  late final _profileManager = ProfileManager();
  // TODO: Initialize AppRouter
  // final _appRouter = AppRouter();
  final routerParser = AppRouteParser();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider(
          create: (context) => widget.appStateManager,
        ),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          // TODO: Replace with Router
          return MaterialApp.router(
            theme: theme,
            title: 'Fooderlich',
            backButtonDispatcher: RootBackButtonDispatcher(),
            routeInformationParser: routerParser,
            routerDelegate: _appRouter,
            // home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
