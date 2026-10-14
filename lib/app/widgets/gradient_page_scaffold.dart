import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/core.dart';
import 'floating_bottom_nav.dart';

/// Page layout used by most screens: a navy-purple gradient header that
/// scrolls with the content, cards that overlap its bottom edge, an optional
/// floating nav and an optional pinned bottom bar.
///
/// [headerHeight] is the height of [header] itself. [overlap] is how far the
/// gradient continues underneath the first card.
class GradientPageScaffold extends StatelessWidget {
  const GradientPageScaffold({
    super.key,
    required this.header,
    required this.headerHeight,
    this.overlap = 40,
    this.children = const <Widget>[],
    this.nav,
    this.bottomBar,
    this.padding = const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
    this.onRefresh,
  });

  final Widget header;
  final double headerHeight;
  final double overlap;
  final List<Widget> children;

  /// Shows the floating bottom nav with this tab highlighted.
  final NavTab? nav;
  final Widget? bottomBar;
  final EdgeInsetsGeometry padding;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double top = media.padding.top;
    final double bottomInset = media.padding.bottom;

    Widget scroll = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.only(
        bottom: nav != null ? AppDimens.navScrollSpace + bottomInset : 24,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: top + headerHeight + overlap,
            child: const _GradientBackdrop(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: top + headerHeight,
                child: Padding(padding: EdgeInsets.only(top: top), child: header),
              ),
              Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (onRefresh != null) {
      scroll = RefreshIndicator(onRefresh: onRefresh!, color: AppColors.primary, child: scroll);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: scroll),
                  if (nav != null)
                    Positioned(
                      left: AppDimens.pagePadding,
                      right: AppDimens.pagePadding,
                      bottom: AppDimens.navBottomMargin + bottomInset,
                      child: FloatingBottomNav(active: nav!),
                    ),
                ],
              ),
            ),
            if (bottomBar != null) bottomBar!,
          ],
        ),
      ),
    );
  }
}

class _GradientBackdrop extends StatelessWidget {
  const _GradientBackdrop();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.header,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppDimens.headerRadius)),
      ),
    );
  }
}
