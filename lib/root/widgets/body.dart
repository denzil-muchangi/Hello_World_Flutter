import 'package:flutter/material.dart';
import 'package:hello_world/root/widgets/body_desktop.dart';
import 'package:hello_world/root/widgets/body_mobile.dart';
import 'package:hello_world/root/widgets/body_tablet.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveBreakpoints.of(context).isDesktop) {
          return const BodyDesktop();
        }
        if (ResponsiveBreakpoints.of(context).isTablet) {
          return const BodyTablet();
        }
        if (ResponsiveBreakpoints.of(context).isMobile) {
          return const BodyMobile();
        }
        return const BodyMobile();
      },
    );
  }
}
