import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class DustParticle {
  double x;
  double y;
  double vx;
  double vy;
  double size;
  double maxOpacity;
  double swayFrequency;
  double swayAmplitude;
  double phase;

  DustParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.maxOpacity,
    required this.swayFrequency,
    required this.swayAmplitude,
    required this.phase,
  });

  void update(double dt, double width, double height, double time) {
    y -= vy * dt;
    x += vx * dt + math.sin(time * swayFrequency + phase) * swayAmplitude * dt;

    if (y < -20) {
      y = height + 20;
      x = math.Random().nextDouble() * width;
    }
    if (x < -20) {
      x = width + 20;
    } else if (x > width + 20) {
      x = -20;
    }
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _bgAnimationController;
  final List<DustParticle> _particles = [];
  double _lastTick = 0.0;

  @override
  void initState() {
    super.initState();

    _bgAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _bgAnimationController.addListener(_updateParticles);

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  void _updateParticles() {
    if (!mounted) return;
    final double elapsed = _bgAnimationController.value * 10.0;
    double dt = elapsed - _lastTick;
    if (dt < 0) dt += 10.0;
    _lastTick = elapsed;

    final size = MediaQuery.maybeSizeOf(context);
    final double w = size != null ? size.width : 375.0;
    final double h = size != null ? size.height : 812.0;

    if (_particles.isEmpty) {
      final rand = math.Random();
      for (int i = 0; i < 20; i++) {
        _particles.add(DustParticle(
          x: rand.nextDouble() * w,
          y: rand.nextDouble() * h,
          vx: 4.0 + rand.nextDouble() * 12.0,
          vy: 10.0 + rand.nextDouble() * 18.0,
          size: 1.2 + rand.nextDouble() * 2.2,
          maxOpacity: 0.06 + rand.nextDouble() * 0.12,
          swayFrequency: 0.8 + rand.nextDouble() * 1.5,
          swayAmplitude: 3.0 + rand.nextDouble() * 5.0,
          phase: rand.nextDouble() * math.pi * 2,
        ));
      }
    }

    for (final p in _particles) {
      p.update(dt, w, h, elapsed);
    }
  }

  @override
  void dispose() {
    _bgAnimationController.removeListener(_updateParticles);
    _bgAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepEmerald,
      body: Stack(
        children: [
          // 1. Atmosphere and Particle Background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _bgAnimationController,
              builder: (context, child) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: AtmosphericBackgroundPainter(
                    particles: _particles,
                    time: _bgAnimationController.value * 10.0,
                  ),
                );
              },
            ),
          ),

          // 2. Central Branding Composition
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 7),

                // MISO Calligraphic Logo Row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'M',
                      style: GoogleFonts.cinzel(
                        fontSize: 54,
                        color: AppColors.champagneGold,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Text(
                      'I',
                      style: GoogleFonts.cinzel(
                        fontSize: 54,
                        color: AppColors.champagneGold,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Text(
                      'S',
                      style: GoogleFonts.cinzel(
                        fontSize: 54,
                        color: AppColors.champagneGold,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 22),
                    // Enso custom O painter
                    CustomPaint(
                      size: const Size(50, 50),
                      painter: EnsoOPathPainter(),
                    ),
                    const SizedBox(width: 14),
                    // Traditional red seal stamp
                    const RedSealStamp(),
                  ],
                )
                .animate()
                .fadeIn(duration: 1500.ms, curve: Curves.easeOutCubic)
                .scale(begin: const Offset(0.95, 0.95), duration: 2500.ms),

                const SizedBox(height: 8),

                // Underline gold brush stroke
                CustomPaint(
                  size: const Size(190, 8),
                  painter: GoldBrushStrokePainter(),
                )
                .animate()
                .fadeIn(delay: 600.ms, duration: 1500.ms)
                .scaleX(begin: 0.1, end: 1.0, delay: 600.ms, duration: 1200.ms, curve: Curves.easeOutCubic),

                const SizedBox(height: 32),

                // Spaced Tagline
                Text(
                  'A JOURNEY THROUGH ASIA',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: AppColors.champagneGold.withValues(alpha: 0.60),
                    letterSpacing: 9.0,
                    fontWeight: FontWeight.w300,
                  ),
                )
                .animate()
                .fadeIn(delay: 1500.ms, duration: 1800.ms)
                .slideY(begin: 0.3, end: 0.0, delay: 1500.ms, duration: 1800.ms, curve: Curves.easeOutCubic),

                const Spacer(flex: 6),

                // Bottom loading water ripples & ceramic bowl
                const LuxuryLoadingIndicator(),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AtmosphericBackgroundPainter extends CustomPainter {
  final List<DustParticle> particles;
  final double time;

  AtmosphericBackgroundPainter({
    required this.particles,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 1. Base Deep Emerald Green & Subtle Vignette
    final basePaint = Paint()..color = AppColors.deepEmerald;
    canvas.drawRect(rect, basePaint);

    final vignettePaint = Paint()
      ..shader = ui.Gradient.radial(
        size.center(Offset.zero),
        size.shortestSide * 0.9,
        [
          Colors.transparent,
          AppColors.forestGreen.withValues(alpha: 0.85),
        ],
        [0.0, 1.0],
      );
    canvas.drawRect(rect, vignettePaint);

    // 2. Rice Paper Fibers & Grain (Deterministic using fixed seed Random)
    final rand = math.Random(12345);
    final fiberPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = AppColors.champagneGold.withValues(alpha: 0.04);

    for (int i = 0; i < 40; i++) {
      final p1 = Offset(rand.nextDouble() * size.width, rand.nextDouble() * size.height);
      final p2 = p1 + Offset((rand.nextDouble() - 0.5) * 60, (rand.nextDouble() - 0.5) * 60);
      final cp = p1 + Offset((rand.nextDouble() - 0.5) * 30, (rand.nextDouble() - 0.5) * 30);
      final path = Path()
        ..moveTo(p1.dx, p1.dy)
        ..quadraticBezierTo(cp.dx, cp.dy, p2.dx, p2.dy);
      canvas.drawPath(path, fiberPaint);
    }

    final grainPaint = Paint()
      ..color = AppColors.softIvory.withValues(alpha: 0.015);
    for (int i = 0; i < 300; i++) {
      final pos = Offset(rand.nextDouble() * size.width, rand.nextDouble() * size.height);
      canvas.drawCircle(pos, rand.nextDouble() * 1.5, grainPaint);
    }

    // 3. Traditional Shippo Motif behind Logo
    final logoCenter = Offset(size.width / 2, size.height * 0.45);
    const double patternRadius = 140.0;
    const double circleR = 25.0;
    const double step = circleR * 1.414;

    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: logoCenter, radius: patternRadius)));

    final motifPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final int gridHalf = (patternRadius / step).ceil() + 2;
    for (int x = -gridHalf; x <= gridHalf; x++) {
      for (int y = -gridHalf; y <= gridHalf; y++) {
        final circleCenter = logoCenter + Offset(x * step, y * step);
        final double distance = (circleCenter - logoCenter).distance;
        if (distance < patternRadius + circleR) {
          final double opacity = (1.0 - (distance / (patternRadius + circleR))).clamp(0.0, 1.0) * 0.06;
          motifPaint.color = AppColors.antiqueBrass.withValues(alpha: opacity);
          canvas.drawCircle(circleCenter, circleR, motifPaint);
        }
      }
    }
    canvas.restore();

    // 4. Shoji Screen Shadows (Diagonal light screen overlay)
    final shadowPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        [
          Colors.black.withValues(alpha: 0.0),
          Colors.black.withValues(alpha: 0.06),
          Colors.black.withValues(alpha: 0.0),
          Colors.black.withValues(alpha: 0.05),
          Colors.black.withValues(alpha: 0.0),
          Colors.black.withValues(alpha: 0.07),
          Colors.black.withValues(alpha: 0.0),
        ],
        [0.0, 0.25, 0.35, 0.55, 0.65, 0.85, 1.0],
      );
    canvas.drawRect(rect, shadowPaint);

    // 5. Atmospheric Decorations (Mountains & Pagoda)
    // Mountain Layer 1 (Back)
    final path1 = Path();
    path1.moveTo(0, size.height);
    path1.lineTo(0, size.height * 0.85);
    path1.quadraticBezierTo(size.width * 0.3, size.height * 0.82, size.width * 0.65, size.height * 0.89);
    path1.quadraticBezierTo(size.width * 0.85, size.height * 0.92, size.width, size.height * 0.86);
    path1.lineTo(size.width, size.height);
    path1.close();
    canvas.drawPath(path1, Paint()..color = AppColors.forestGreen.withValues(alpha: 0.08));

    // Pagoda Silhouette on the back peak
    final pagodaCenter = Offset(size.width * 0.65, size.height * 0.88);
    final pagodaPaint = Paint()..color = AppColors.mutedStone.withValues(alpha: 0.06);
    final pagodaPath = Path();
    // Tier 3
    pagodaPath.moveTo(pagodaCenter.dx - 3, pagodaCenter.dy - 12);
    pagodaPath.lineTo(pagodaCenter.dx + 3, pagodaCenter.dy - 12);
    pagodaPath.lineTo(pagodaCenter.dx + 2, pagodaCenter.dy - 8);
    pagodaPath.lineTo(pagodaCenter.dx - 2, pagodaCenter.dy - 8);
    pagodaPath.close();
    // Roof 3
    pagodaPath.moveTo(pagodaCenter.dx - 5, pagodaCenter.dy - 8);
    pagodaPath.quadraticBezierTo(pagodaCenter.dx, pagodaCenter.dy - 9, pagodaCenter.dx + 5, pagodaCenter.dy - 8);
    pagodaPath.lineTo(pagodaCenter.dx + 3, pagodaCenter.dy - 6);
    pagodaPath.lineTo(pagodaCenter.dx - 3, pagodaCenter.dy - 6);
    pagodaPath.close();
    // Tier 2
    pagodaPath.moveTo(pagodaCenter.dx - 4, pagodaCenter.dy - 6);
    pagodaPath.lineTo(pagodaCenter.dx + 4, pagodaCenter.dy - 6);
    pagodaPath.lineTo(pagodaCenter.dx + 3, pagodaCenter.dy - 2);
    pagodaPath.lineTo(pagodaCenter.dx - 3, pagodaCenter.dy - 2);
    pagodaPath.close();
    // Roof 2
    pagodaPath.moveTo(pagodaCenter.dx - 7, pagodaCenter.dy - 2);
    pagodaPath.quadraticBezierTo(pagodaCenter.dx, pagodaCenter.dy - 3, pagodaCenter.dx + 7, pagodaCenter.dy - 2);
    pagodaPath.lineTo(pagodaCenter.dx + 5, pagodaCenter.dy);
    pagodaPath.lineTo(pagodaCenter.dx - 5, pagodaCenter.dy);
    pagodaPath.close();
    // Tier 1
    pagodaPath.moveTo(pagodaCenter.dx - 5, pagodaCenter.dy);
    pagodaPath.lineTo(pagodaCenter.dx + 5, pagodaCenter.dy);
    pagodaPath.lineTo(pagodaCenter.dx + 4, pagodaCenter.dy + 5);
    pagodaPath.lineTo(pagodaCenter.dx - 4, pagodaCenter.dy + 5);
    pagodaPath.close();
    // Roof 1
    pagodaPath.moveTo(pagodaCenter.dx - 9, pagodaCenter.dy + 5);
    pagodaPath.quadraticBezierTo(pagodaCenter.dx, pagodaCenter.dy + 4, pagodaCenter.dx + 9, pagodaCenter.dy + 5);
    pagodaPath.lineTo(pagodaCenter.dx + 7, pagodaCenter.dy + 7);
    pagodaPath.lineTo(pagodaCenter.dx - 7, pagodaCenter.dy + 7);
    pagodaPath.close();
    // Spire
    pagodaPath.moveTo(pagodaCenter.dx - 0.5, pagodaCenter.dy - 12);
    pagodaPath.lineTo(pagodaCenter.dx + 0.5, pagodaCenter.dy - 12);
    pagodaPath.lineTo(pagodaCenter.dx, pagodaCenter.dy - 17);
    pagodaPath.close();
    canvas.drawPath(pagodaPath, pagodaPaint);

    // Mountain Layer 2 (Front)
    final path2 = Path();
    path2.moveTo(0, size.height);
    path2.lineTo(0, size.height * 0.91);
    path2.quadraticBezierTo(size.width * 0.4, size.height * 0.86, size.width * 0.75, size.height * 0.93);
    path2.quadraticBezierTo(size.width * 0.9, size.height * 0.95, size.width, size.height * 0.90);
    path2.lineTo(size.width, size.height);
    path2.close();
    canvas.drawPath(path2, Paint()..color = AppColors.deepEmerald.withValues(alpha: 0.1));

    // Bottom Mist Overlay
    final mistPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, size.height * 0.8),
        Offset(0, size.height),
        [
          AppColors.deepEmerald.withValues(alpha: 0.0),
          AppColors.deepEmerald.withValues(alpha: 0.65),
          AppColors.deepEmerald.withValues(alpha: 0.95),
        ],
        [0.0, 0.7, 1.0],
      );
    canvas.drawRect(Rect.fromLTRB(0, size.height * 0.8, size.width, size.height), mistPaint);

    // Top Bamboo Leaves
    final bambooPaint = Paint()
      ..color = AppColors.jadeGreen.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final bambooPath1 = Path();
    bambooPath1.moveTo(0, 0);
    bambooPath1.quadraticBezierTo(50, 40, 90, 60);
    bambooPath1.quadraticBezierTo(50, 55, 0, 0);
    bambooPath1.moveTo(0, 0);
    bambooPath1.quadraticBezierTo(40, 80, 70, 110);
    bambooPath1.quadraticBezierTo(35, 90, 0, 0);
    bambooPath1.moveTo(30, 20);
    bambooPath1.quadraticBezierTo(80, 50, 120, 55);
    bambooPath1.quadraticBezierTo(75, 45, 30, 20);
    canvas.drawPath(bambooPath1, bambooPaint);

    final bambooPath2 = Path();
    bambooPath2.moveTo(size.width, 0);
    bambooPath2.quadraticBezierTo(size.width - 50, 40, size.width - 90, 70);
    bambooPath2.quadraticBezierTo(size.width - 45, 50, size.width, 0);
    bambooPath2.moveTo(size.width, 0);
    bambooPath2.quadraticBezierTo(size.width - 30, 60, size.width - 50, 100);
    bambooPath2.quadraticBezierTo(size.width - 25, 75, size.width, 0);
    canvas.drawPath(bambooPath2, bambooPaint);

    // 6. Draw floating dust particles
    final particlePaint = Paint()..style = PaintingStyle.fill;
    for (final p in particles) {
      particlePaint.color = AppColors.champagneGold.withValues(alpha: p.maxOpacity);
      canvas.drawCircle(Offset(p.x, p.y), p.size, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant AtmosphericBackgroundPainter oldDelegate) {
    return oldDelegate.time != time || oldDelegate.particles != particles;
  }
}

class EnsoOPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final R = size.width * 0.35;

    final goldGradient = ui.Gradient.linear(
      Offset.zero,
      Offset(size.width, size.height),
      [
        AppColors.antiqueBrass,
        AppColors.champagneGold,
        AppColors.lotusGold,
        AppColors.antiqueBrass,
      ],
      [0.0, 0.4, 0.7, 1.0],
    );

    final paint = Paint()
      ..shader = goldGradient
      ..style = PaintingStyle.fill;

    final path = Path();
    const double thetaStart = -1.35;
    const double thetaEnd = 4.45;
    const int segments = 100;

    final List<Offset> outerPoints = [];
    final List<Offset> innerPoints = [];

    for (int i = 0; i <= segments; i++) {
      final double t = i / segments;
      final double theta = thetaStart + (thetaEnd - thetaStart) * t;

      final double widthMultiplier = math.sin(t * math.pi);
      final double w = 8.5 * math.pow(widthMultiplier, 0.4);

      final double organicRipple = 1.8 * math.sin(t * 5 * math.pi) + 1.2 * math.cos(t * 3 * math.pi);
      final double r = R + organicRipple;

      final double ox = center.dx + (r + w / 2) * math.cos(theta);
      final double oy = center.dy + (r + w / 2) * math.sin(theta);
      outerPoints.add(Offset(ox, oy));

      final double ix = center.dx + (r - w / 2) * math.cos(theta);
      final double iy = center.dy + (r - w / 2) * math.sin(theta);
      innerPoints.add(Offset(ix, iy));
    }

    path.moveTo(outerPoints.first.dx, outerPoints.first.dy);
    for (int i = 1; i < outerPoints.length; i++) {
      path.lineTo(outerPoints[i].dx, outerPoints[i].dy);
    }
    path.lineTo(innerPoints.last.dx, innerPoints.last.dy);
    for (int i = innerPoints.length - 2; i >= 0; i--) {
      path.lineTo(innerPoints[i].dx, innerPoints[i].dy);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GoldBrushStrokePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final goldGradient = ui.Gradient.linear(
      Offset.zero,
      Offset(size.width, size.height),
      [
        AppColors.antiqueBrass,
        AppColors.champagneGold,
        AppColors.lotusGold,
        AppColors.antiqueBrass,
      ],
      [0.0, 0.3, 0.7, 1.0],
    );

    final paint = Paint()
      ..shader = goldGradient
      ..style = PaintingStyle.fill;

    final path = Path();
    final double W = size.width;
    final double H = size.height;

    const int segments = 50;
    final List<Offset> topPoints = [];
    final List<Offset> bottomPoints = [];

    for (int i = 0; i <= segments; i++) {
      final double t = i / segments;
      final double x = t * W;

      final double widthMultiplier = math.sin(t * math.pi);
      final double thickness = 2.0 * math.pow(widthMultiplier, 0.4);
      final double dy = 1.2 * math.sin(t * math.pi) + 0.5 * math.sin(t * 3 * math.pi);

      topPoints.add(Offset(x, H / 2 + dy - thickness / 2));
      bottomPoints.add(Offset(x, H / 2 + dy + thickness / 2));
    }

    path.moveTo(topPoints.first.dx, topPoints.first.dy);
    for (int i = 1; i < topPoints.length; i++) {
      path.lineTo(topPoints[i].dx, topPoints[i].dy);
    }
    path.lineTo(bottomPoints.last.dx, bottomPoints.last.dy);
    for (int i = bottomPoints.length - 2; i >= 0; i--) {
      path.lineTo(bottomPoints[i].dx, bottomPoints[i].dy);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RedSealStamp extends StatelessWidget {
  const RedSealStamp({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(26, 26),
      painter: _SealStampPainter(),
    );
  }
}

class _SealStampPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rand = math.Random(5678);

    final sealPaint = Paint()
      ..color = AppColors.cinnabarRed
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(rect.left + rand.nextDouble() * 1.5, rect.top + rand.nextDouble() * 1.5);
    path.lineTo(rect.right - rand.nextDouble() * 1.5, rect.top + rand.nextDouble() * 1.5);
    path.lineTo(rect.right - rand.nextDouble() * 1.5, rect.bottom - rand.nextDouble() * 1.5);
    path.lineTo(rect.left + rand.nextDouble() * 1.5, rect.bottom - rand.nextDouble() * 1.5);
    path.close();

    canvas.drawPath(path, sealPaint);

    final monogramPaint = Paint()
      ..color = AppColors.champagneGold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.square;

    final monoPath = Path();
    const double pad = 5.0;
    monoPath.addRect(Rect.fromLTRB(pad - 1, pad - 1, size.width - pad + 1, size.height - pad + 1));
    canvas.drawPath(monoPath, Paint()..color = AppColors.cinnabarRed);

    final mPath = Path()
      ..moveTo(pad + 3, size.height - pad - 2)
      ..lineTo(pad + 3, pad + 2)
      ..moveTo(pad + 3, pad + 2)
      ..lineTo(size.width / 2, size.height / 2 + 1)
      ..lineTo(size.width - pad - 3, pad + 2)
      ..moveTo(size.width - pad - 3, pad + 2)
      ..lineTo(size.width - pad - 3, size.height - pad - 2);

    canvas.drawPath(mPath, monogramPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LuxuryLoadingIndicator extends StatefulWidget {
  const LuxuryLoadingIndicator({super.key});

  @override
  State<LuxuryLoadingIndicator> createState() => _LuxuryLoadingIndicatorState();
}

class _LuxuryLoadingIndicatorState extends State<LuxuryLoadingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(200, 100),
          painter: _LoadingIndicatorPainter(progress: _controller.value),
        );
      },
    );
  }
}

class _LoadingIndicatorPainter extends CustomPainter {
  final double progress;
  _LoadingIndicatorPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.7);
    final goldGradient = ui.Gradient.linear(
      Offset.zero,
      Offset(size.width, size.height),
      [
        AppColors.antiqueBrass,
        AppColors.champagneGold,
        AppColors.lotusGold,
        AppColors.antiqueBrass,
      ],
      [0.0, 0.3, 0.7, 1.0],
    );

    // 1. Concentric Water Ripples
    final ripplePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const double maxRippleRadius = 80.0;
    for (int i = 0; i < 3; i++) {
      final double delay = i / 3.0;
      final double rippleProgress = (progress + delay) % 1.0;
      final double radius = maxRippleRadius * rippleProgress;
      final double opacity = (1.0 - rippleProgress).clamp(0.0, 1.0) * 0.35;
      ripplePaint.color = AppColors.champagneGold.withValues(alpha: opacity);

      canvas.drawOval(
        Rect.fromCenter(center: center + const Offset(0, 12), width: radius * 2, height: radius * 0.5),
        ripplePaint,
      );
    }

    // 2. Rising Steam
    final steamPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    final double steamBaseY = center.dy - 14;
    for (int i = 0; i < 3; i++) {
      final double strandOffset = (i - 1) * 10.0;
      final double phase = i * math.pi / 1.5;
      final double timeFactor = progress * 2 * math.pi;

      final double startY = steamBaseY;
      final double endY = steamBaseY - 35;

      for (double y = startY; y > endY; y -= 2) {
        final double t = (startY - y) / (startY - endY);
        final double opacity = (1.0 - t).clamp(0.0, 1.0) * 0.35;
        final double xOffset = 3.0 * math.sin(timeFactor - (t * 2 * math.pi) + phase);

        steamPaint.color = AppColors.softIvory.withValues(alpha: opacity);

        final Offset p1 = Offset(center.dx + strandOffset + xOffset, y);
        final double nextY = y - 2;
        final double nextT = (startY - nextY) / (startY - endY);
        final double nextXOffset = 3.0 * math.sin(timeFactor - (nextT * 2 * math.pi) + phase);
        final Offset p2 = Offset(center.dx + strandOffset + nextXOffset, nextY);

        canvas.drawLine(p1, p2, steamPaint);
      }
    }

    // 3. Minimalist Gold Ceramic Bowl
    final bowlPaint = Paint()
      ..color = AppColors.forestGreen
      ..style = PaintingStyle.fill;

    final bowlOutlinePaint = Paint()
      ..shader = goldGradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final bowlPath = Path();
    bowlPath.moveTo(center.dx - 18, center.dy - 10);
    bowlPath.quadraticBezierTo(center.dx - 18, center.dy + 8, center.dx - 8, center.dy + 12);
    bowlPath.lineTo(center.dx + 8, center.dy + 12);
    bowlPath.quadraticBezierTo(center.dx + 18, center.dy + 8, center.dx + 18, center.dy - 10);
    bowlPath.close();
    canvas.drawPath(bowlPath, bowlPaint);
    canvas.drawPath(bowlPath, bowlOutlinePaint);

    final footPath = Path();
    footPath.moveTo(center.dx - 7, center.dy + 12);
    footPath.lineTo(center.dx - 5, center.dy + 15);
    footPath.lineTo(center.dx + 5, center.dy + 15);
    footPath.lineTo(center.dx + 7, center.dy + 12);
    canvas.drawPath(footPath, bowlOutlinePaint);

    final rimPaint = Paint()
      ..shader = goldGradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawOval(
      Rect.fromCenter(center: center - const Offset(0, 10), width: 36, height: 4),
      rimPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _LoadingIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
