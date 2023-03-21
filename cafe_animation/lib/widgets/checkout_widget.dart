import 'package:cafe_animation/constant/color_costants.dart';
import 'package:cafe_animation/model/coffee_items.dart';
import 'package:cafe_animation/model/dessert_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutWidget extends StatelessWidget {
  final CoffeeItems coffee;
  final DessertItems? dessert;
  const CheckOutWidget({super.key, required this.coffee, this.dessert});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        buildBackground(),
        Hero(
            tag: "coffee_${coffee.id}",
            child: Image.asset(
              coffee.image,
              fit: BoxFit.contain,
            )),
        if (dessert != null)
          Align(
            alignment: const Alignment(2, 0.5),
            child: SizedBox(
              width: size.width * 0.8,
              child: Hero(
                tag: "dessert_${dessert!.id}",
                child: Image.asset(
                  dessert!.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'My Order',
                  style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 1,
                      color: kTitleColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      coffee.name,
                      style: GoogleFonts.questrial(
                          fontSize: 18,
                          height: 1,
                          fontWeight: FontWeight.w500,
                          color: kTitleColor),
                    ),
                    Text(
                      "\$${coffee.price}",
                      style: GoogleFonts.questrial(
                          fontSize: 18,
                          height: 1,
                          fontWeight: FontWeight.w700,
                          color: kTitleColor.withOpacity(.7)),
                    )
                  ],
                ),
                if (dessert != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dessert!.name,
                          style: GoogleFonts.questrial(
                              fontSize: 18,
                              height: 1,
                              fontWeight: FontWeight.w500,
                              color: kTitleColor),
                        ),
                        Text(
                          "\$${dessert!.price}",
                          style: GoogleFonts.questrial(
                              fontSize: 18,
                              height: 1,
                              fontWeight: FontWeight.w700,
                              color: kTitleColor.withOpacity(.7)),
                        )
                      ],
                    ),
                  ),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kTitleColor,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {},
                    child: Text(
                        "Checkout (\$${(coffee.price + (dessert?.price ?? 0)).toStringAsFixed(2)})"))
              ],
            ),
          ),
        )
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
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
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
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
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
