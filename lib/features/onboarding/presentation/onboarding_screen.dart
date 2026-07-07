import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _bgAnimController;

  @override
  void initState() {
    super.initState();
    _bgAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalBlack,
      body: Stack(
        children: [
          // Slow Cinematic Zoom (Ken Burns Effect)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _bgAnimController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_bgAnimController.value * 0.15),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1580822184713-fc5400e7fe10?auto=format&fit=crop&q=80&w=1200',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ).animate().fadeIn(duration: 2000.ms),
          ),
          
          // Ultra-Premium Dark Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.charcoalBlack.withValues(alpha: 0.0),
                    AppColors.charcoalBlack.withValues(alpha: 0.3),
                    AppColors.charcoalBlack.withValues(alpha: 0.8),
                    AppColors.charcoalBlack.withValues(alpha: 1.0),
                  ],
                  stops: const [0.0, 0.5, 0.85, 1.0],
                ),
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  
                  // Top Brand Mark
                  Center(
                    child: Text(
                      'MISO',
                      style: GoogleFonts.cinzel(
                        fontSize: 18,
                        color: AppColors.lotusGold,
                        letterSpacing: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                    .animate()
                    .fade(duration: 1200.ms, delay: 500.ms)
                    .slideY(begin: -0.2, end: 0, curve: Curves.easeOutCubic)
                    .blurXY(begin: 4, end: 0, duration: 1200.ms),
                  ),
                  
                  const Spacer(),
                  
                  // Staggered Cinematic Text
                  Text(
                    'The Art of',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 48,
                      color: AppColors.softIvory.withValues(alpha: 0.9),
                      height: 1.1,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -0.5,
                    ),
                  )
                  .animate()
                  .fade(delay: 1000.ms, duration: 1200.ms)
                  .slideX(begin: -0.05, end: 0, curve: Curves.easeOutCubic)
                  .blurXY(begin: 8, end: 0, duration: 1200.ms),
                  
                  Text(
                    'Asian Dining',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 56,
                      color: AppColors.softIvory,
                      height: 1.1,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.0,
                    ),
                  )
                  .animate()
                  .fade(delay: 1200.ms, duration: 1200.ms)
                  .slideX(begin: -0.05, end: 0, curve: Curves.easeOutCubic)
                  .blurXY(begin: 8, end: 0, duration: 1200.ms),
                  
                  const SizedBox(height: 32),
                  
                  // Elegant Golden Line
                  Container(
                    width: 60,
                    height: 1.5,
                    color: AppColors.lotusGold,
                  )
                  .animate()
                  .scaleX(delay: 1600.ms, duration: 1000.ms, alignment: Alignment.centerLeft, curve: Curves.easeOutCubic),
                  
                  const SizedBox(height: 32),
                  
                  Text(
                    'Experience a curated journey through Asia\'s finest cuisines, crafted by celebrated chefs and timeless traditions.',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppColors.softIvory.withValues(alpha: 0.6),
                      height: 1.8,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.2,
                    ),
                  )
                  .animate()
                  .fade(delay: 1800.ms, duration: 1200.ms)
                  .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
                  
                  const SizedBox(height: 64),
                  
                  // Ultra Premium Blur Button
                  Center(
                    child: GestureDetector(
                      onTap: () => context.go('/home'),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                            decoration: BoxDecoration(
                              color: AppColors.lotusGold.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: AppColors.lotusGold.withValues(alpha: 0.5),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'BEGIN JOURNEY',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: AppColors.softIvory,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.lotusGold,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fade(delay: 2200.ms, duration: 1000.ms)
                    .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
