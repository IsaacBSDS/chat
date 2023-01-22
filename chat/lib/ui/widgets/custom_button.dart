import 'package:chat/ui/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({
    super.key,
    required this.child,
    this.color,
    this.borderColor,
    this.onTap,
    this.splashColor,
    this.borderRadius,
  });

  final Widget child;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Color? splashColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(20),
              side: BorderSide(color: borderColor ?? color ?? Colors.white),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            splashColor ?? CustomColors.purple.withOpacity(0.2),
          ),
          backgroundColor:
              MaterialStateProperty.all<Color>(color ?? Colors.white)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: child,
      ),
    );
  }
}
