import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: isOutlined
          ? BoxDecoration(
              borderRadius: AppTheme.mediumRadius,
              border: Border.all(
                color: backgroundColor ?? AppTheme.primaryColor,
                width: 2,
              ),
            )
          : BoxDecoration(
              gradient: backgroundColor != null
                  ? LinearGradient(
                      colors: [backgroundColor!, backgroundColor!],
                    )
                  : AppTheme.primaryGradient,
              borderRadius: AppTheme.mediumRadius,
              boxShadow: [AppTheme.primaryShadow],
            ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: AppTheme.mediumRadius,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: textColor ?? Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        text,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor ?? Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class AppTheme {
  static var mediumRadius;

  static var primaryColor;

  static var primaryGradient;

  static var primaryShadow;
}
