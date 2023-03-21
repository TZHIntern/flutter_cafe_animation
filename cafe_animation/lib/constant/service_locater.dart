import 'package:cafe_animation/service/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void initServiceLocator() {
  locator.registerSingleton<NavigationService>(NavigationService());
}
