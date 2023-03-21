import 'package:cafe_animation/constant/color_costants.dart';
import 'package:cafe_animation/constant/scroll_config.dart';
import 'package:cafe_animation/constant/service_locater.dart';
import 'package:cafe_animation/model/coffee_items.dart';
import 'package:cafe_animation/model/dessert_items.dart';
import 'package:cafe_animation/service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class DessertList extends StatefulWidget {
  final CoffeeItems coffee;
  const DessertList({super.key, required this.coffee});

  @override
  State<DessertList> createState() => _DessertListState();
}

class _DessertListState extends State<DessertList> {
  late final PageController treatController;
  late final PageController headingController;
  late double currentPosition;
  late int currentHeading;

  // ignore: non_constant_identifier_names
  void NavigationListener() {
    setState(() {
      currentPosition = treatController.page!;
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
    treatController = PageController(viewportFraction: 0.4, initialPage: 2);
    headingController = PageController(viewportFraction: 1, initialPage: 2);
    currentPosition = PageController().initialPage.toDouble();
    currentHeading = PageController().initialPage;
    treatController.addListener(NavigationListener);
  }

  @override
  void dispose() {
    treatController.removeListener(NavigationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.bottomCenter + const Alignment(0, -1.2),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      '\$${DessertItems.dessert[currentHeading.clamp(0, DessertItems.dessert.length - 1)].price.toStringAsFixed(2)} ',
                      style: GoogleFonts.montserrat(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          height: 1,
                          color: kTitleColor),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 80,
                  child: PageView.builder(
                    controller: headingController,
                    scrollBehavior: WindowScrollBehavior(),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: DessertItems.dessert.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 220, right: 20),
                        child: Text(
                          DessertItems.dessert[index].name,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: kTitleColor.withOpacity(.8)),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            left: -size.width * 0.52,
            height: size.height * 0.7,
            width: size.width,
            child: Hero(
              tag: "coffee_${widget.coffee.id}",
              child: Transform.scale(
                scale: 1.36,
                child: Image.asset(
                  widget.coffee.image,
                  fit: BoxFit.contain,
                ),
              ),
            )),
        Align(
          alignment: Alignment.bottomRight,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              DessertItems
                  .dessert[
                      currentHeading.clamp(0, DessertItems.dessert.length - 1)]
                  .calories,
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1,
                  color: kTitleColor.withOpacity(.5)),
              textAlign: TextAlign.right,
            ),
          )),
        ),
        Transform.scale(
          alignment: Alignment.bottomCenter,
          scale: 2.0,
          child: PageView.builder(
            controller: treatController,
            scrollBehavior: WindowScrollBehavior(),
            scrollDirection: Axis.vertical,
            itemCount: DessertItems.dessert.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox.shrink();
              }
              final double distance = (currentPosition - index + 1).abs();
              final isNotOnScreen = (currentPosition - index + 1) > 0;
              final double scale = 1 - distance * .38;
              final double translateY =
                  (1 - scale).abs() * MediaQuery.of(context).size.height / 1.5 +
                      25 * (distance - 1).clamp(0.0, 1);
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .1),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(0.0, !isNotOnScreen ? translateY : translateY)
                    ..scale(scale),
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    child: Hero(
                      tag: 'dessert_${DessertItems.dessert[index - 1].id}',
                      child: Image.asset(
                        DessertItems.dessert[index - 1].image,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
            right: 85,
            bottom: size.height * 0.25,
            child: ElevatedButton(
              onPressed: () {
                locator<NavigationService>().NavigateTo(NavigationArguments(
                    coffee: CoffeeItems.coffee.indexOf(widget.coffee),
                    dessert: DessertItems.dessert.indexOf(DessertItems.dessert[
                        currentHeading.clamp(
                            0, DessertItems.dessert.length - 1)]),
                    isCheckout: true));
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  elevation: 10,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(8)),
              child: const Icon(
                FeatherIcons.plus,
                color: kTitleColor,
                size: 32,
              ),
            ))
      ],
    );
  }
}
