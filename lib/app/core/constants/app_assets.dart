/// Asset paths. Files are grouped in one folder per screen under assets/svg.
class AppAssets {
  AppAssets._();

  static const String _svg = 'assets/svg';

  // common
  static const String plane = '$_svg/common/plane.svg';
  static const String logoMark = '$_svg/common/logo_mark.svg';

  // splash
  static const String splashOrbits = '$_svg/splash/splash_orbits.svg';

  // onboarding
  static const String onboarding1 = '$_svg/onboarding/onboarding_search.svg';
  static const String onboarding2 = '$_svg/onboarding/onboarding_seat_pay.svg';
  static const String onboarding3 = '$_svg/onboarding/onboarding_track.svg';

  // home
  static const String destGoa = '$_svg/home/dest_goa.svg';
  static const String destJaipur = '$_svg/home/dest_jaipur.svg';
  static const String destDubai = '$_svg/home/dest_dubai.svg';

  // live map
  static const String mapLand = '$_svg/live_map/map_land.svg';
}
