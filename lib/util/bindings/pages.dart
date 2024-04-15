import 'package:get/get.dart';
import 'package:some_ride/features/authentication/presentation/export.dart';
import 'package:some_ride/features/home/presentation/home_land.dart';
import 'package:some_ride/features/home/presentation/available.dart';
import 'package:some_ride/features/location/presentation/location.dart';
import 'package:some_ride/features/profile/presentation/profile.dart';
import 'package:some_ride/features/welcome/presentation/onboarding.dart';
import 'package:some_ride/util/bindings/export.dart';

List<GetPage> getpages = [
  GetPage(
    name: '/',
    page: () => const OnBoarding(),
  ),
  GetPage(
    name: '/home',
    page: () => HomeLanding(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: '/location',
    page: () => const EnableLocation(),
  ),
  GetPage(
    name: '/login',
    page: () => const LoginPage(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: '/available-cars',
    page: () => const AvailableCars(isBackAvailable: true),
  ),
  GetPage(
    name: '/signup',
    page: () => const SignUpPage(),
    binding: SignUpBinding(),
  ),
  GetPage(
    name: '/welcome',
    page: () => const Welcome(),
  ),
  GetPage(
    name: '/profile',
    page: () => const Profile(),
  ),
];
