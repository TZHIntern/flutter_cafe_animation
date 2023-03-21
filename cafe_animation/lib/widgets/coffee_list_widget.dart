import 'package:cafe_animation/constant/color_costants.dart';
import 'package:cafe_animation/constant/scroll_config.dart';
import 'package:cafe_animation/constant/service_locater.dart';
import 'package:cafe_animation/model/coffee_items.dart';
import 'package:cafe_animation/service/navigation_service.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoffeeListWidget extends StatefulWidget {
  const CoffeeListWidget({super.key});

  @override
  State<CoffeeListWidget> createState() => _CoffeeListWidgetState();
}

class _CoffeeListWidgetState extends State<CoffeeListWidget> {
  late final PageController coffeeController;
  late final PageController headingController;
  late double currentPosition;
  late int currentHeading;

  // ignore: non_constant_identifier_names
  void NavigationListener() {
    setState(() {
      currentPosition = coffeeController.page!;
      if (currentPosition.round() != currentHeading) {
        currentHeading = currentPosition.round();
        headingController.animateToPage(currentHeading,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    coffeeController = PageController(viewportFraction: 0.4, initialPage: 4);
    headingController = PageController(viewportFraction: 1, initialPage: 4);
    currentPosition = PageController().initialPage.toDouble();
    currentHeading = PageController().initialPage;
    coffeeController.addListener(NavigationListener);
  }

  @override
  void dispose() {
    coffeeController.removeListener(NavigationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...buildBackground(),
        Transform.scale(
          alignment: Alignment.bottomCenter,
          scale: 2.3,
          child: PageView.builder(
            controller: coffeeController,
            clipBehavior: Clip.none,
            scrollBehavior: WindowScrollBehavior(),
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox.shrink();
              }
              final double distance = (currentPosition - index + 1).abs();
              final isNotOnScreen = (currentPosition - index + 1) > 0;
              final double scale =
                  1 - distance * .345 * (isNotOnScreen ? 1 : -1);
              final double translateY =
                  (1 - scale).abs() * MediaQuery.of(context).size.height / 1.5 +
                      20 * (distance - 1).clamp(0.0, 1);
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .1),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(0.0, !isNotOnScreen ? 0.0 : translateY)
                    ..scale(scale),
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      locator<NavigationService>()
                          .NavigateTo(NavigationArguments(coffee: index - 1));
                    },
                    child: Hero(
                      tag: 'coffee_${CoffeeItems.coffee[index - 1].id}',
                      flightShuttleBuilder: ((BuildContext flightContext,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext) {
                        late Widget hero;
                        if (flightDirection == HeroFlightDirection.push) {
                          hero = fromHeroContext.widget;
                        } else {
                          hero = toHeroContext.widget;
                        }
                        return hero;
                      }),
                      child: Image.asset(
                        CoffeeItems.coffee[index - 1].image,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          height: 180,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [.6, 1],
                  colors: [Colors.white, Colors.white.withOpacity(0.0)])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
                child: PageView.builder(
                  controller: headingController,
                  itemCount: CoffeeItems.coffee.length,
                  scrollBehavior: WindowScrollBehavior(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final CoffeeItems coffee = CoffeeItems.coffee[index];
                    final TextStyle titleStyle = GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 1,
                      color: kTitleColor,
                    );
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Center(
                        child: Hero(
                          tag: "coffee_${coffee.id}_name",
                          child: Text(
                            coffee.name,
                            style: titleStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Center(
                  child: Text(
                    '\$${CoffeeItems.coffee[currentHeading.clamp(0, CoffeeItems.coffee.length - 1)].price.toStringAsFixed(2)} ',
                    style: GoogleFonts.montserrat(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        color: kTitleColor),
                  ),
                ),
              )
            ],
          ),
        ),
        ...buildOverlays(),
      ],
    );
  }

  List<Widget> buildBackground() {
    return [
      Align(
        alignment: Alignment.bottomCenter + const Alignment(0, .7),
        child: Container(
          width: MediaQuery.of(context).size.width * .5,
          height: MediaQuery.of(context).size.width * .5,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: kBrowColor,
              blurRadius: 90,
              spreadRadius: 90,
              offset: Offset.zero,
            )
          ], shape: BoxShape.circle),
        ),
      ),
      Align(
          alignment: Alignment.centerLeft + const Alignment(-0.35, -.5),
          child: Container(
            width: 60,
            height: 200,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kBrowColor,
                  blurRadius: 50,
                  spreadRadius: 20,
                  offset: Offset(5, 0),
                )
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
          )),
      Align(
        alignment: Alignment.bottomRight + const Alignment(5.8, -0.45),
        child: SizedBox(
          width: 350,
          height: 350,
          child: DecoratedBox(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: kBrowColor.withOpacity(0.4),
                blurRadius: 60,
                spreadRadius: 20,
                offset: const Offset(5, 0),
              )
            ], shape: BoxShape.circle),
          ),
        ),
      )
    ];
  }

  List<Widget> buildOverlays() {
    return [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 115,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                kBrowColor.withRed(170).withOpacity(.6),
                kBrowColor.withOpacity(0.0)
              ])),
        ),
      )
    ];
  }
}
