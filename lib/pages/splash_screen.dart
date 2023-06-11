import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:starterapp/constants/ui/style_constants.dart';
import 'package:starterapp/routes/routes_constants.dart';
import 'package:starterapp/services/locale_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> loadCall() async {
    // Wait delay
    if (context.mounted) {
      await context.read<LocaleProvider>().initLocale(context);
    }
    await Future.delayed(const Duration(seconds: 3), () {});
    redirectPage();
  }

  Future<void> redirectPage() async {
    if (!await InternetConnectionChecker().hasConnection) {
      if (context.mounted) {
        Navigator.of(context).popAndPushNamed(RoutesConstants.noInternetRoute);
      }
    } else {
      if (context.mounted) {
        Navigator.of(context).popAndPushNamed(RoutesConstants.landingRoute);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadCall());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 200,
            left: 0,
            child: CustomPaint(
              painter: Circle(size.width - size.width / 5, 0, size.width,
                  StyleConstants.colorOfApp),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CustomPaint(
              painter: Circle(0, 0, size.width - 100, Colors.white),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                FittedBox(
                  child: Text(
                    "StarterApp",
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                Text(
                  "Your splashscreen!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Circle extends CustomPainter {
  final double offsetX;
  final double offsetY;
  final double radius;
  final Color color;
  Circle(this.offsetX, this.offsetY, this.radius, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset(offsetX, offsetY), radius, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
