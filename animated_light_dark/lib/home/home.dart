import 'package:animate_do/animate_do.dart';
import 'package:animated_light_dark/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isDay = true;
  double chainHeight = chainInitialHeight;
  bool isHoldingHandle = false;
  String textContent = 'Discipline is key to mastery';
  double textOpacity = 1.0;

  void updateAllState() => {
    setState(() {
      if (isHoldingHandle) isHoldingHandle = false;
      if (chainHeight > chainInitialHeight * 1.5) {
        isDay = !isDay;
        textContent =
            isDay
                ? 'Discipline is key to mastery'
                : 'Mastery is key to discipline';
      }

      chainHeight = chainInitialHeight;
      textOpacity = 1.0;
    }),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        decoration: BoxDecoration(
          color: isDay ? dayBGColor : nightBGColor,
          image: DecorationImage(
            image: NetworkImage(
              isDay
                  ? 'https://i.pinimg.com/564x/d8/e8/da/d8e8dae6acd6917ec6187a1af0915225.jpg'
                  : 'https://i.pinimg.com/564x/95/fb/b2/95fbb29f122e531eafbb022fb5934359.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        duration: animationDuration,
        curve: animationCurve,
        padding: const EdgeInsets.only(top: 100, right: 30),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            AnimatedContainer(
              duration: animationDuration,
              curve: animationCurve,
              width: circleRadius,
              height: circleRadius,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDay ? sunColor : moonColor,
              ),
            ),
            Transform.translate(
              offset: const Offset(-15, -20),
              child: AnimatedContainer(
                duration: animationDuration,
                curve: animationCurve,
                width: isDay ? 0 : circleRadius,
                height: isDay ? 0 : circleRadius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDay ? dayBGColor : nightBGColor,
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.12,
              top: MediaQuery.of(context).size.height / 18 + (circleRadius / 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  AnimatedContainer(
                    duration:
                        isHoldingHandle
                            ? chainHandleHoldDuration
                            : chainHandleHoldDuration,
                    curve: animationCurve,
                    height: chainHeight,
                    child: VerticalDivider(
                      color: isDay ? sunColor : moonColor,
                      thickness: chainThickness,
                      width: chainThickness,
                    ),
                  ),
                  GestureDetector(
                    onVerticalDragUpdate: (dragDetail) {
                      setState(() {
                        isHoldingHandle = true;
                        chainHeight += dragDetail.primaryDelta ?? 0;
                        textOpacity = 0.5;
                      });
                    },
                    onVerticalDragEnd: (_) => updateAllState(),
                    onVerticalDragCancel: () => updateAllState(),
                    child: Container(
                      width: chainHandleRadius,
                      height: chainHandleRadius,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDay ? sunColor : moonColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(
            top:    isDay
                      ? MediaQuery.of(context).size.height * .4
                      : MediaQuery.of(context).size.height * .55),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isDay
                      ? FadeInLeft(
                        delay: Duration(milliseconds: 300),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: textOpacity,
                          child: Text(
                            textContent,
                            style: GoogleFonts.salsa(
                              color: Colors.white,
                              fontSize: 30,
                              
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      )
                      : BounceInUp(
                         delay: Duration(milliseconds: 900),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: textOpacity,
                          child: Text(
                            textContent,
                            style: GoogleFonts.salsa(
                              color: Colors.amber,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
