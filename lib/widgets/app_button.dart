import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color_path.dart';

class AppPrimaryButton extends StatelessWidget {
  final String? label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final Function()? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const AppPrimaryButton({
    this.onTap,
    this.label,
    this.textColor = Colors.white,
    this.backgroundColor = ColorPath.blue,
    this.borderColor,
    this.child,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Material(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: borderColor ?? backgroundColor,
                width: 1.0,
              )
          ),
          child: MaterialButton(
            splashColor: backgroundColor.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: onTap,
            minWidth: double.infinity,
            height: 48,
            child: child ?? Text(
              label ?? '',
              style: GoogleFonts.redHatDisplay(
                  color: ColorPath.primaryTextDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}