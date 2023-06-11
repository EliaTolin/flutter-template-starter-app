import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starterapp/l10n/l10n.dart';
import 'package:starterapp/routes/routes_constants.dart';
import 'package:starterapp/services/locale_service.dart';
import 'package:starterapp/themes/themes.dart';
import 'routes/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(
    MultiProvider(
      providers: [
        //Add here the providers
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ],
      child: const StarterApp(),
    ),
  );
}

class StarterApp extends StatelessWidget {
  const StarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'StarterApp',
          theme: lightTheme,
          initialRoute: RoutesConstants.splashScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: L10n.allLanguagesSupported,
          onGenerateRoute: router.generateRoute,
        );
      },
    );
  }
}
