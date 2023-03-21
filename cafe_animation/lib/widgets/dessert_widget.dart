import 'package:cafe_animation/constant/color_costants.dart';
import 'package:cafe_animation/constant/service_locater.dart';
import 'package:cafe_animation/model/coffee_items.dart';
import 'package:cafe_animation/service/navigation_service.dart';
import 'package:cafe_animation/widgets/dessert_list.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class DessertWidget extends StatefulWidget {
  final CoffeeItems coffee;
  const DessertWidget({super.key, required this.coffee});

  @override
  State<DessertWidget> createState() => _DessertWidgetState();
}

class _DessertWidgetState extends State<DessertWidget> {
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
      children: [
        buildBackground(),
        DessertList(coffee: widget.coffee),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: size.width * 0.55,
                  child: Column(
                    children: [
                      Hero(
                        tag: "coffee_${widget.coffee.id}_name",
                        child: Text(widget.coffee.name,
                            style: textStyle, textAlign: TextAlign.right),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Would you like to add sweet treats?',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.questrial(
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                          color: kTitleColor.withOpacity(.5),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kTitleColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 15),
                              alignment: Alignment.centerLeft,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          onPressed: () {
                            locator<NavigationService>().NavigateTo(
                                NavigationArguments(
                                    coffee: CoffeeItems.coffee
                                        .indexOf(widget.coffee),
                                    isCheckout: true));
                          },
                          child: const Text("No, Thanks!"),
                        ),
                      )
                    ],
                  ),
                )
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
