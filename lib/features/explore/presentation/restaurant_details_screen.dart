import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String restaurantId;
  
  const RestaurantDetailsScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF2C4C3B);
    const goldAccent = Color(0xFFC6A25A);
    const textPrimary = Color(0xFFE8D8A7);
    const textSecondary = Color(0xFF8B8A87);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Parallax Hero Image
              SliverAppBar(
                expandedHeight: 400.0,
                pinned: true,
                backgroundColor: bgColor,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Cinematic interior image
                      Image.asset(
                        'assets/images/restaurant_interior.png',
                        fit: BoxFit.cover,
                      ),
                      // Dark gradient at bottom for text readability
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, bgColor],
                            stops: [0.6, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Restaurant Info & Editorial
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kyoto Kaiseki',
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 36,
                                    color: textPrimary,
                                    fontWeight: FontWeight.w600,
                                    height: 1.1,
                                  ),
                                ).animate().fade(duration: 400.ms),
                                const SizedBox(height: 8),
                                Text(
                                  'Japanese • Omakase • \$\$\$\$',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Restaurant Logo Placeholder
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: goldAccent.withValues(alpha: 0.3)),
                              color: const Color(0xFF161616),
                            ),
                            child: Center(
                              child: Text(
                                'K',
                                style: GoogleFonts.zeyada(
                                  fontSize: 32,
                                  color: goldAccent,
                                ),
                              ),
                            ),
                          ).animate().scale(delay: 200.ms),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Ratings & Awards
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: goldAccent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: goldAccent.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star, color: goldAccent, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  '4.9 (120 Reviews)',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: goldAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8A1C1C).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF8A1C1C).withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              'MICHELIN 2 Stars',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: const Color(0xFFE89090),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ).animate().fade(delay: 300.ms),
                      
                      const SizedBox(height: 32),
                      const Divider(color: Color(0xFF222222)),
                      const SizedBox(height: 32),
                      
                      // Philosophy Section
                      Text(
                        'THE PHILOSOPHY',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          letterSpacing: 2.0,
                          color: goldAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ).animate().fade(delay: 400.ms),
                      const SizedBox(height: 16),
                      Text(
                        'Rooted in the ancient traditions of Kyoto, our culinary journey celebrates the subtle beauty of seasonal transitions. Every ingredient is sourced with profound respect for nature, transforming fleeting moments of the season into timeless culinary poetry on your plate.',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 20,
                          color: textPrimary.withValues(alpha: 0.9),
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ).animate().fade(delay: 500.ms),
                      
                      const SizedBox(height: 48),
                      
                      // View Menu Button (Navigates to Menu Screen)
                      GestureDetector(
                        onTap: () => context.push('/restaurant/$restaurantId/menu'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: goldAccent.withValues(alpha: 0.5)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Explore the Menu',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                letterSpacing: 1.5,
                                color: goldAccent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ).animate().fade(delay: 600.ms),
                      
                      const SizedBox(height: 48),
                      
                      // Chef Story
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF1E1E1E), // Placeholder for Chef Portrait
                            ),
                            child: const Icon(Icons.person, color: Color(0xFF333333), size: 40),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CHEF\'s STORY',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    letterSpacing: 2.0,
                                    color: textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Kenjiro Tanaka',
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 28,
                                    color: textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'A third-generation sushi master who brings decades of relentless pursuit of perfection to modern interpretations.',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: textSecondary,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).animate().fade(delay: 700.ms).slideY(begin: 0.1, end: 0),
                      
                      const SizedBox(height: 48),
                      const Divider(color: Color(0xFF222222)),
                      const SizedBox(height: 32),
                      
                      // Operating Hours & Location
                      _buildInfoRow(Icons.access_time, 'Tue - Sun: 17:30 - 22:30\nClosed on Mondays'),
                      const SizedBox(height: 24),
                      _buildInfoRow(Icons.location_on_outlined, '124 Ginza District, Tokyo\nValet parking available'),
                      
                      const SizedBox(height: 140), // Space for sticky button
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Sticky Reserve Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 24, bottom: 48, left: 24, right: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    bgColor,
                    bgColor.withValues(alpha: 0.9),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 64,
                decoration: BoxDecoration(
                  color: textPrimary,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: textPrimary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Reserve a Table',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFFC6A25A), size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFFE8D8A7).withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
