import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starterapp/services/locale_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:starterapp/starter_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set only portrait orientation
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(
    MultiProvider(
      providers: [
        //Add here the providers
        ChangeNotifierProvider(create: (context) => LocaleServiceProvider()),
      ],
      child: const StarterApp(),
    ),
  );
}
