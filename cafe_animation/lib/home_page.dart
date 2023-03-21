import 'package:cafe_animation/coffee_detail_page.dart';
import 'package:cafe_animation/constant/service_locater.dart';
import 'package:cafe_animation/model/coffee_items.dart';
import 'package:cafe_animation/model/dessert_items.dart';
import 'package:cafe_animation/service/navigation_service.dart';
import 'package:cafe_animation/widgets/checkout_widget.dart';
import 'package:cafe_animation/widgets/coffee_list_widget.dart';
import 'package:cafe_animation/widgets/dessert_widget.dart';
import 'package:cafe_animation/widgets/intro_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                locator
                    .get<NavigationService>()
                    .navigatorKey
                    .currentState!
                    .pop();
              },
              icon: const Icon(
                FeatherIcons.chevronLeft,
                color: Colors.black,
                size: 30,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FeatherIcons.shoppingBag,
                  color: Colors.black,
                  size: 30,
                ))
          ]),
      body: Container(
        clipBehavior: Clip.none,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Navigator(
              key: locator.get<NavigationService>().navigatorKey,
              observers: [locator.get<NavigationService>().heroController],
              onGenerateRoute: (settings) {
                NavigationArguments? args =
                    settings.arguments as NavigationArguments?;
                late Widget currentPage;
                bool toHome = false;
                // ignore: unnecessary_null_comparison
                if (args == null) {
                  if (settings.name == 'home') {
                    toHome = true;
                  }
                  currentPage = settings.name == 'home'
                      ? const CoffeeListWidget()
                      : const IntroWidget();
                } else {
                  currentPage =
                      DetailedCoffee(coffee: CoffeeItems.coffee[args.coffee]);
                  if (args.isSweet) {
                    currentPage =
                        DessertWidget(coffee: CoffeeItems.coffee[args.coffee]);
                  }
                  if (args.isCheckout) {
                    currentPage = CheckOutWidget(
                      coffee: CoffeeItems.coffee[args.coffee],
                      dessert: args.dessert != null? DessertItems.dessert[args.dessert!]: null,
                    );
                  }
                }

                return PageRouteBuilder(
                    transitionDuration:
                        Duration(milliseconds: toHome ? 800 : 300),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child:
                            Container(color: Colors.white, child: currentPage),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
