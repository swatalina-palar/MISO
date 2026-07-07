import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF2C4C3B);
    const goldAccent = Color(0xFFC6A25A);
    const textPrimary = Color(0xFFE8D8A7);
    const textSecondary = Color(0xFF8B8A87);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          'MISO Society',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 28,
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Luxury Membership Card
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE8D8A7),
                    Color(0xFFC6A25A),
                    Color(0xFF8A6C2F),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: goldAccent.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Embossed pattern simulation
                  Positioned(
                    right: -50,
                    bottom: -50,
                    child: Icon(
                      Icons.soup_kitchen,
                      size: 200,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'miso',
                              style: GoogleFonts.zeyada(
                                fontSize: 32,
                                color: Colors.black87,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              'GOLD TIER',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lily Chen',
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'MEMBER SINCE 2024',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                letterSpacing: 1.5,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Points Progress
            Center(
              child: Column(
                children: [
                  Text(
                    '2,450',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 48,
                      color: goldAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'SOCIETY POINTS',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      letterSpacing: 2.0,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 4,
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFF222222),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.65,
                      child: Container(
                        decoration: BoxDecoration(
                          color: goldAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '550 points until Platinum Tier',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 48),
            
            // Exclusive Experiences
            Text(
              'EXCLUSIVE EXPERIENCES',
              style: GoogleFonts.inter(
                fontSize: 12,
                letterSpacing: 2.0,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _buildExperienceCard('Chef\'s Table Omakase', 'Redeem for 1,500 points', Icons.restaurant),
            const SizedBox(height: 12),
            _buildExperienceCard('Private Sake Tasting', 'Redeem for 800 points', Icons.wine_bar),
            
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF222222),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFFC6A25A)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 18,
                    color: const Color(0xFFE8D8A7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF8B8A87),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF8B8A87)),
        ],
      ),
    );
  }
}
