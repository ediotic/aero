import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppDimens {
  AppDimens._();

  static const double pagePadding = 16;
  static const double screenPadding = 20;
  static const double cardRadius = 26;
  static const double sheetRadius = 30;
  static const double headerRadius = 32;
  static const double buttonHeight = 56;
  static const double chipRadius = 14;
  static const double iconTile = 42;
  static const double circleButton = 44;

  // Floating bottom navigation
  static const double navBarHeight = 68;
  static const double navTotalHeight = 100;
  static const double navBottomMargin = 20;
  static const double navScrollSpace = 140;
}

class AppShadows {
  AppShadows._();

  static final List<BoxShadow> card = <BoxShadow>[
    const BoxShadow(
      color: Color.fromRGBO(18, 24, 80, 0.07),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  static final List<BoxShadow> soft = <BoxShadow>[
    const BoxShadow(
      color: Color.fromRGBO(18, 24, 80, 0.06),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];

  static final List<BoxShadow> raised = <BoxShadow>[
    const BoxShadow(
      color: Color.fromRGBO(18, 24, 80, 0.16),
      blurRadius: 40,
      offset: Offset(0, 18),
    ),
  ];

  static final List<BoxShadow> bar = <BoxShadow>[
    const BoxShadow(
      color: Color.fromRGBO(18, 24, 80, 0.10),
      blurRadius: 30,
      offset: Offset(0, -10),
    ),
  ];

  static List<BoxShadow> glow(Color color, {double opacity = 0.4}) => <BoxShadow>[
        BoxShadow(
          color: AppColors.alpha(color, opacity),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ];
}
