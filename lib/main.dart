import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsa_app/screens/loading.dart';
import 'package:nsa_app/screens/loginUser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/dashboard.dart';
import 'pages/library/view_models/app.dart';
import 'pages/library/view_models/details_provider.dart';
import 'pages/library/view_models/favorites_provider.dart';
import 'pages/library/view_models/genre_provider.dart';
import 'pages/library/view_models/home_provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => GenreProvider()),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    @override
  void initState() {
    super.initState();
    getData();
  }

  String userName;

  Future getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = _prefs.getString('userLastName');
    });
    print(userName);
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
initialRoute: '/loadingScreen',
      routes: {
        '/loadingScreen': (context) => SplashScreen(),
      },
      theme: CupertinoThemeData(
        primaryContrastingColor: Colors.blue,
      ),
      builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: userName == null? AlreadyUser() : DashBoard(),
      
    );
  }
}

