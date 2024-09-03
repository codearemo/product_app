import 'package:flutter/material.dart';

class RevealPageRoute extends PageRouteBuilder {
  final Widget page;

  RevealPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var beginOffset = const Offset(1.0, 1.0); // Start from bottom-right
            var endOffset = Offset.zero;
            var tween = Tween(begin: beginOffset, end: endOffset)
                .chain(CurveTween(curve: Curves.easeInOut));
            var offsetAnimation = animation.drive(tween);

            var scaleTween = Tween(begin: 0.0, end: 1.0);
            var scaleAnimation = animation.drive(scaleTween);

            return ScaleTransition(
              scale: scaleAnimation,
              alignment: Alignment.bottomRight,
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
        );
}
