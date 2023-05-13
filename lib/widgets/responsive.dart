import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive(
      {Key key,
      @required this.mobile,
      @required this.desktop,
      // ignore: avoid_init_to_null
      this.tablet = null})
      : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 800;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 800 &&
      MediaQuery.of(context).size.width <= 1200;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1200;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth > 1200) return desktop;
      if (constraint.maxWidth >= 800) return tablet ?? mobile;
      return mobile;
    });
  }
}
