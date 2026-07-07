import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

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
          // Minimalist Dark Map Placeholder
          Positioned.fill(
            child: Container(
              color: const Color(0xFF0A0A0A),
              child: Stack(
                children: [
                  // Map grid lines simulation
                  ...List.generate(10, (index) => Positioned(
                    top: index * 80.0,
                    left: 0, right: 0,
                    child: Container(height: 1, color: Colors.white.withValues(alpha: 0.02)),
                  )),
                  ...List.generate(5, (index) => Positioned(
                    left: index * 80.0,
                    top: 0, bottom: 0,
                    child: Container(width: 1, color: Colors.white.withValues(alpha: 0.02)),
                  )),
                  // Map Route Line Simulation
                  Positioned(
                    top: 200, left: 100, right: 100,
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: goldAccent.withValues(alpha: 0.5),
                        boxShadow: [
                          BoxShadow(color: goldAccent.withValues(alpha: 0.5), blurRadius: 10)
                        ],
                      ),
                    ),
                  ),
                  // Delivery Marker
                  const Positioned(
                    top: 180, left: 200,
                    child: Icon(Icons.directions_car, color: goldAccent, size: 32),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true)).moveX(begin: -20, end: 20, duration: 2.seconds),
                ],
              ),
            ),
          ),
          
          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.5),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: textPrimary),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ),

          // Tracking Info Panel
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.8),
                    blurRadius: 30,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Estimated Arrival',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: textSecondary,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '8:45 PM',
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 40,
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: goldAccent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: goldAccent.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            'On the way',
                            style: GoogleFonts.inter(
                              color: goldAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Preparation Timeline
                    _buildTimelineStep(Icons.receipt_long, 'Order Confirmed', '7:30 PM', true, false),
                    _buildTimelineStep(Icons.soup_kitchen, 'Preparing your meal', 'Chef Kenjiro is crafting your order', true, true),
                    _buildTimelineStep(Icons.moped, 'Out for Delivery', 'Driver is arriving soon', false, false),
                  ],
                ),
              ),
            ),
          ).animate().slideY(begin: 0.5, end: 0, duration: 500.ms, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(IconData icon, String title, String subtitle, bool isCompleted, bool isCurrent) {
    const goldAccent = Color(0xFFC6A25A);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? goldAccent : const Color(0xFF222222),
              ),
              child: Icon(icon, color: isCompleted ? Colors.black : Colors.white54, size: 20),
            ),
            if (title != 'Out for Delivery')
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? goldAccent : const Color(0xFF222222),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: isCompleted ? Colors.white : Colors.white54,
                    fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF8B8A87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
