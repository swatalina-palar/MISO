import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConciergeScreen extends StatelessWidget {
  const ConciergeScreen({super.key});

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
          'Culinary Concierge',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 28,
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  const SizedBox(height: 32),
                  // AI Avatar
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: goldAccent.withValues(alpha: 0.1),
                        border: Border.all(color: goldAccent.withValues(alpha: 0.3)),
                      ),
                      child: const Icon(Icons.auto_awesome, color: goldAccent, size: 40),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'What are you craving today, Lily?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 36,
                      color: textPrimary,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Allow me to curate the perfect dining experience for your mood.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: textSecondary,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Suggestion Cards Grid
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildSuggestionChip('Spicy Adventure', Icons.whatshot),
                      _buildSuggestionChip('Comfort Food', Icons.soup_kitchen),
                      _buildSuggestionChip('Fine Dining', Icons.restaurant_menu),
                      _buildSuggestionChip('Date Night', Icons.favorite_border),
                      _buildSuggestionChip('Vegetarian', Icons.eco_outlined),
                      _buildSuggestionChip('Chef\'s Recommendation', Icons.star_border),
                    ],
                  ),
                ],
              ),
            ),
            
            // Text Input Area
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF222222),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                      ),
                      child: TextField(
                        style: GoogleFonts.inter(color: textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Describe your perfect meal...',
                          hintStyle: GoogleFonts.inter(color: textSecondary),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: goldAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_upward, color: Colors.black, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFC6A25A), size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFFE8D8A7),
            ),
          ),
        ],
      ),
    );
  }
}
