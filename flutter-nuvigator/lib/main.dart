import 'package:flutter/material.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/models/producer_model.dart';
import 'package:proj/screens/favorites_screen.dart';
import 'package:proj/screens/home_screen.dart';
import 'package:proj/screens/login_screen.dart';
import 'package:proj/screens/package_details_screen.dart';
import 'package:proj/screens/payment_screen.dart';
import 'package:proj/screens/producer_details_screen.dart';
import 'package:proj/screens/profile_screen.dart';
import 'package:proj/screens/singup_screen.dart';

import 'models/package_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: Nuvigator.routes(
        screenType: materialScreenType,
        initialRoute: 'home',
        routes: [
          NuRouteBuilder(path: 'home', builder: (_, __, ___) => HomeScreen()),
          NuRouteBuilder(path: 'login', builder: (_, __, ___) => LoginScreen()),
          NuRouteBuilder(
              path: 'sing-up', builder: (_, __, ___) => SingupScreen()),
          NuRouteBuilder(
              path: 'favorites', builder: (_, __, ___) => FavoritesScreen()),
          NuRouteBuilder(
              path: 'profile', builder: (_, __, ___) => ProfileScreen()),
          NuRouteBuilder(
              path: 'payment', builder: (_, __, ___) => PaymentScreen()),
          NuRouteBuilder(
              path: 'producer-details',
              builder: (_, __, NuRouteSettings args) {
                Producer producer = args.rawParameters["producer"];
                return ProducerDetailsScreen(producer: producer);
              }),
          NuRouteBuilder(
              path: 'package-details',
              builder: (_, __, NuRouteSettings args) {
                final Producer producer = args.rawParameters["producer"];
                final Package package = args.rawParameters["package"];
                return PackageDetailsScreen(
                    package: package, producer: producer);
              }),
        ],
      ),
    );
  }
}
