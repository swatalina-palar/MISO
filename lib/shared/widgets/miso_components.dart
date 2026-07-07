import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class MisoGlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double blur;
  final Color? color;

  const MisoGlassCard({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(16.0),
    this.blur = 10.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class MisoButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLoading;

  const MisoButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
  });

  @override
  State<MisoButton> createState() => _MisoButtonState();
}

class _MisoButtonState extends State<MisoButton> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isPrimary ? AppColors.lotusGold : Colors.transparent;
    final textColor = widget.isPrimary ? Colors.black : AppColors.lotusGold;
    final border = widget.isPrimary ? null : Border.all(color: AppColors.lotusGold);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (!widget.isLoading) widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(_isPressed ? 0.96 : 1.0, _isPressed ? 0.96 : 1.0, 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
          border: border,
        ),
        child: Center(
          child: widget.isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              : Text(
                  widget.text,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                ),
        ),
      ),
    );
  }
}

class MisoNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;

  const MisoNetworkImage({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppColors.darkSlate,
          highlightColor: AppColors.charcoalBlack,
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: AppColors.darkSlate,
          child: const Icon(Icons.broken_image, color: AppColors.lotusGold),
        ),
      ).animate().fadeIn(duration: 600.ms, curve: Curves.easeOut),
    );
  }
}
