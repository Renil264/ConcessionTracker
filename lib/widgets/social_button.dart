import 'package:concession_tracker/app_theme.dart';
import 'package:flutter/material.dart';

enum SocialStyle { facebook, google, apple, email }

class SocialButton extends StatelessWidget {
  final SocialStyle style;
  final String label;
  final IconData? icon;
  final Widget? customIcon;
  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    required this.style,
    required this.label,
    this.icon,
    this.customIcon,
    this.onPressed,
  });

  Color _backgroundColor() {
    switch (style) {
      case SocialStyle.facebook:
        return const Color(0xFF1877F2);
      case SocialStyle.google:
        return Colors.white;
      case SocialStyle.apple:
        return Colors.black;
      case SocialStyle.email:
         return AppTheme.brandPurple;
    }
  }

  Color _textColor() {
    switch (style) {
      case SocialStyle.facebook:
      case SocialStyle.apple:
        return Colors.white;
      case SocialStyle.google:
        return Colors.black87;
      case SocialStyle.email:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // fixed height for consistency
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor(),
          foregroundColor: _textColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: style == SocialStyle.google
                ? const BorderSide(color: Colors.black12)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft, // ensures proper alignment
        ),
        icon: customIcon ??
            (icon != null ? Icon(icon, size: 22, color: _textColor()) : const SizedBox.shrink()),
        label: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _textColor(),
            ),
          ),
        ),
      ),
    );
  }
}
