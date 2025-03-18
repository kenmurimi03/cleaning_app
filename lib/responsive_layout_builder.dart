import 'package:cleansafi/breakpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    required this.small,
    required this.large,
    super.key,
    this.medium,
    this.xLarge,
    this.child,
  });

  final ResponsiveLayoutWidgetBuilder small;

  final ResponsiveLayoutWidgetBuilder? medium;

  final ResponsiveLayoutWidgetBuilder large;

  final ResponsiveLayoutWidgetBuilder? xLarge;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!kIsWeb) {
          return small(context, child);
        } else {
          if (constraints.maxWidth <= Breakpoints.small) {
            return small(context, child);
          }
          if (constraints.maxWidth <= Breakpoints.medium) {
            return (medium ?? large).call(context, child);
          }
          if (constraints.maxWidth <= Breakpoints.large) {
            return large(context, child);
          }

          return (xLarge ?? large).call(context, child);
        }
      },
    );
  }
}
