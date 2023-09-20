import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_task/constants/color_path.dart';
import '../route_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          height: height,
          width: width,
          color: Colors.black,
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          child: Center(
            child: FadeOutParticle(
              disappear: true,
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 3000),
              child: Text(
                  "Fridge",
                style: GoogleFonts.redHatDisplay(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  color: ColorPath.blue
                ),
              ),
              onAnimationEnd: (){
                Navigator.pushReplacementNamed(
                  context,
                  RouteHandler.home,
                );
              },
            ),
          )
      ),
    );
  }

}
