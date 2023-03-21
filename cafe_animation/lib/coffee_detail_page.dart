import 'package:cafe_animation/constant/color_costants.dart';
import 'package:cafe_animation/constant/service_locater.dart';
import 'package:cafe_animation/model/coffee_items.dart';
import 'package:cafe_animation/service/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailedCoffee extends StatefulWidget {
  final CoffeeItems coffee;
  const DetailedCoffee({super.key, required this.coffee});

  @override
  State<DetailedCoffee> createState() => _DetailedCoffeeState();
}

class _DetailedCoffeeState extends State<DetailedCoffee> {
  late String sizeCoffee;

  @override
  void initState() {
    super.initState();
    sizeCoffee = 'M';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle textStyle = GoogleFonts.montserrat(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      height: 1,
      color: kTitleColor,
    );
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        buildBackground(),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              verticalDirection: VerticalDirection.up,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center + const Alignment(-.9, -0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 32),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          locator<NavigationService>().NavigateTo(
                              NavigationArguments(
                                  coffee:
                                      CoffeeItems.coffee.indexOf(widget.coffee),
                                  isSweet: true));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kTitleColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Row(
                          children: [
                            Text(
                              'Add to cart',
                              style: GoogleFonts.questrial(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          FeatherIcons.coffee,
                          color: kTitleColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          sizeCoffee == 'M'
                              ? "Basic"
                              : sizeCoffee == 'L'
                                  ? "Large"
                                  : "Small",
                          style: GoogleFonts.questrial(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: kTitleColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: ['S', 'M', 'L']
                          .map((sizeOfCoffee) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sizeCoffee = sizeOfCoffee;
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: sizeCoffee == sizeOfCoffee
                                          ? kTitleColor
                                          : Colors.transparent,
                                      border: Border.all(
                                          color: sizeCoffee != sizeOfCoffee
                                              ? kTitleColor
                                              : Colors.transparent,
                                          width: 2)),
                                  child: AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 300),
                                    style: GoogleFonts.questrial(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: sizeCoffee != sizeOfCoffee
                                            ? kTitleColor
                                            : Colors.white),
                                    child: Text(sizeOfCoffee),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '\$ ${(widget.coffee.price + (sizeCoffee == "M" ? 0 : (sizeCoffee == "L" ? 1.2 : -.8))).toStringAsFixed(2)}',
                    style: textStyle,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.coffee.description,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.questrial(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: kTitleColor.withOpacity(0.5)),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: Hero(
                    tag: "coffee_${widget.coffee.id}_name",
                    child: Text(
                      widget.coffee.name,
                      style: textStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            left: size.width * 0.38,
            right: -size.height * 0.15,
            bottom: -size.height * 0.14,
            //width: size.width,
            height: size.height * 0.7,
            child: IgnorePointer(
              child: Hero(
                tag: "coffee_${widget.coffee.id}",
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 400),
                  scale: sizeCoffee == 'M'
                      ? 1.36
                      : sizeCoffee == 'L'
                          ? 1.5
                          : 1.2,
                  curve: Curves.easeOutBack,
                  alignment: Alignment.center,
                  child: Image.asset(
                    widget.coffee.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ))
      ],
    );
  }

  buildBackground() {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: const [
                    0.0,
                    .50
                  ],
                      colors: [
                    kBrowColor.withOpacity(.7),
                    kBrowColor.withOpacity(0.0)
                  ])),
            )),
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [
                    0.0,
                    .4
                  ],
                      colors: [
                    kBrowColor.withOpacity(.5),
                    kBrowColor.withOpacity(0.0)
                  ])),
            ))
      ],
    );
  }
}
