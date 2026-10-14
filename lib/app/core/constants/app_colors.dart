import 'package:flutter/material.dart';

/// Every colour used by the app lives here. Nothing in the UI should use a
/// raw hex value.
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF5B35E8);
  static const Color primaryLight = Color(0xFF8A3FFC);
  static const Color primaryDeep = Color(0xFF3A2BB8);
  static const Color primarySoft = Color(0xFFEEE9FF);
  static const Color primaryBorder = Color(0xFFC9BDFB);
  static const Color primaryGlow = Color(0xFFB58CFF);

  // Navy scale
  static const Color navy900 = Color(0xFF070D2E);
  static const Color navy800 = Color(0xFF0B1440);
  static const Color navy700 = Color(0xFF1A1A78);
  static const Color navy600 = Color(0xFF1B1F6B);
  static const Color navy500 = Color(0xFF25188A);
  static const Color indigo = Color(0xFF3B2AB5);
  static const Color mapLand = Color(0xFF1B2680);

  // Surfaces and text
  static const Color background = Color(0xFFF3F4FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF0F1535);
  static const Color muted = Color(0xFF5E6490);
  static const Color mutedLight = Color(0xFF7A80A6);
  static const Color navInactive = Color(0xFF666C94);
  static const Color border = Color(0xFFE3E5F2);
  static const Color divider = Color(0xFFF0F1F8);
  static const Color dash = Color(0xFFC9CCE6);
  static const Color radioIdle = Color(0xFFA7ABC9);
  static const Color toggleOff = Color(0xFFC9CCE6);

  // Seats
  static const Color seatTaken = Color(0xFFD9DCEE);
  static const Color seatTakenIcon = Color(0xFF8A8FB0);
  static const Color seatPremiumBorder = Color(0xFFF5A524);

  // Status
  static const Color successSoft = Color(0xFFDCFAE6);
  static const Color successSofter = Color(0xFFECFDF3);
  static const Color success = Color(0xFF067647);
  static const Color successDot = Color(0xFF12B76A);
  static const Color successLive = Color(0xFF32D583);
  static const Color amber = Color(0xFFFFB020);
  static const Color warningSoft = Color(0xFFFEF0C7);
  static const Color warningSofter = Color(0xFFFFFAEB);
  static const Color warning = Color(0xFFB54708);
  static const Color warningText = Color(0xFF93370D);
  static const Color warningDot = Color(0xFFF79009);
  static const Color dangerSoft = Color(0xFFFEE4E2);
  static const Color dangerSofter = Color(0xFFFEF3F2);
  static const Color danger = Color(0xFFB42318);
  static const Color dangerDot = Color(0xFFF04438);
  static const Color infoSoft = Color(0xFFE0F2FE);
  static const Color info = Color(0xFF0369A1);

  // Airlines (demo brands)
  static const Color airlineAv = Color(0xFF5B35E8);
  static const Color airlineSl = Color(0xFF0369A1);
  static const Color airlineNb = Color(0xFF0F766E);
  static const Color airlineJs = Color(0xFFB45309);

  // Food / destination accents
  static const Color sunsetStart = Color(0xFFFFB36B);
  static const Color sunsetEnd = Color(0xFFFF5E8A);
  static const Color teal = Color(0xFF14B8A6);

  /// White with a given opacity, handy on gradients.
  static Color white(double opacity) => Color.fromRGBO(255, 255, 255, opacity);

  /// Any colour with a given opacity (avoids the deprecated withOpacity).
  // ignore: deprecated_member_use
  static Color alpha(Color c, double opacity) => c.withOpacity(opacity);

  /// Brand colour for an airline code.
  static Color airline(String code) {
    switch (code) {
      case 'SL':
        return airlineSl;
      case 'NB':
        return airlineNb;
      case 'JS':
        return airlineJs;
      case 'AV':
      default:
        return airlineAv;
    }
  }
}
