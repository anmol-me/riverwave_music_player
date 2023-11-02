import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OutlinedCard extends HookWidget {
  const OutlinedCard({
    super.key,
    required this.child,
    this.clickable = true,
  });

  final Widget child;
  final bool clickable;

  @override
  Widget build(BuildContext context) {
    final hovered = useState(false);

    const animationCurve = Curves.easeInOut;
    final borderRadius = BorderRadius.circular(hovered.value ? 20 : 8);

    return MouseRegion(
      onEnter: (_) {
        if (!clickable) return;
        hovered.value = true;
      },
      onExit: (_) {
        if (!clickable) return;
        hovered.value = false;
      },
      cursor: clickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        curve: animationCurve,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
          borderRadius: borderRadius,
        ),
        foregroundDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(
                hovered.value ? 0.12 : 0,
              ),
          borderRadius: borderRadius,
        ),
        child: TweenAnimationBuilder<BorderRadius>(
          tween: Tween(begin: BorderRadius.zero, end: borderRadius),
          curve: animationCurve,
          duration: kThemeAnimationDuration,
          builder: (context, borderRadius, Widget? child) => ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: borderRadius,
            child: child,
          ),
          child: child,
        ),
      ),
    );
  }
}
