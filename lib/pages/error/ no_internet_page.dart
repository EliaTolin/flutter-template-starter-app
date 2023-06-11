import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starterapp/routes/routes_constants.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.error_noInternet,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text(
                AppLocalizations.of(context)!.retry,
              ),
              onPressed: () {
                Navigator.of(context)
                    .popAndPushNamed(RoutesConstants.splashScreenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
