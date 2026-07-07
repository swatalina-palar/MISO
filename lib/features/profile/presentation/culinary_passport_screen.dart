import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/miso_components.dart';

// --- Passport Data Model -----------------------------------------------------

class _PassportCountry {
  final String flag;
  final String name;
  final String description;
  final String accentHex;
  final bool visited;
  final String? visitedDate;
  final int stamps;
  final String heroImage;
  final List<String> achievements;

  const _PassportCountry({
    required this.flag,
    required this.name,
    required this.description,
    required this.accentHex,
    required this.visited,
    this.visitedDate,
    required this.stamps,
    required this.heroImage,
    required this.achievements,
  });
}

// --- Culinary Passport Screen -------------------------------------------------

class CulinaryPassportScreen extends StatefulWidget {
  const CulinaryPassportScreen({super.key});

  @override
  State<CulinaryPassportScreen> createState() => _CulinaryPassportScreenState();
}

class _CulinaryPassportScreenState extends State<CulinaryPassportScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<_PassportCountry> _countries = [
    const _PassportCountry(
      flag: '🇯🇵',
      name: 'Japan',
      description:
          'From the ancient tea ceremony halls of Kyoto to the izakayas of Osaka, Japan\'s culinary heritage spans over a thousand years of refined technique and seasonal devotion.',
      accentHex: 'F2D1D1',
      visited: true,
      visitedDate: 'October 2024',
      stamps: 8,
      heroImage:
          'https://images.unsplash.com/photo-1611143669185-af224c5e3252?auto=format&fit=crop&q=80&w=1200',
      achievements: [
        'First Kaiseki Experience',
        'Sushi Counter Initiate',
        'Ramen Heritage Discovery',
        'Tea Ceremony Participant',
      ],
    ),
    const _PassportCountry(
      flag: '🇰🇷',
      name: 'Korea',
      description:
          'A nation where fermentation is philosophy and communal dining is love. Discover centuries of kimchi culture, royal cuisine, and the modern Seoul culinary renaissance.',
      accentHex: '8B9D77',
      visited: true,
      visitedDate: 'November 2024',
      stamps: 5,
      heroImage:
          'https://images.unsplash.com/photo-1580651315530-69c8e0026377?auto=format&fit=crop&q=80&w=1200',
      achievements: [
        'Hansik Initiate',
        'Banchan Collector',
        'Makgeolli Evening',
      ],
    ),
    const _PassportCountry(
      flag: '🇨🇳',
      name: 'China',
      description:
          'Eight great culinary traditions spanning a continent. From Sichuan\'s volcanic heat to the gentle precision of Cantonese dim sum and the imperial elegance of Peking.',
      accentHex: 'D6C59A',
      visited: true,
      visitedDate: 'December 2024',
      stamps: 5,
      heroImage:
          'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf?auto=format&fit=crop&q=80&w=1200',
      achievements: [
        'Dim Sum Sunday',
        'Peking Duck Master',
        'Sichuan Fire Taster',
      ],
    ),
    const _PassportCountry(
      flag: '🇹🇭',
      name: 'Thailand',
      description:
          'A cuisine of extraordinary balance. Sweet, sour, salty, spicy -- Thai food is a meditation on harmony. From royal palace recipes to street market wonders.',
      accentHex: 'D6A962',
      visited: false,
      stamps: 0,
      heroImage:
          'https://images.unsplash.com/photo-1559314809-0d155014e29e?auto=format&fit=crop&q=80&w=1200',
      achievements: [],
    ),
    const _PassportCountry(
      flag: '🇻🇳',
      name: 'Vietnam',
      description:
          'Pho at dawn in Hanoi, banh mi in a Saigon alley, fresh spring rolls by the Mekong. Vietnamese cuisine is poetry written in broth, herbs, and perfectly balanced flavors.',
      accentHex: '8B9D77',
      visited: false,
      stamps: 0,
      heroImage:
          'https://images.unsplash.com/photo-1503764654157-72d979d9af2f?auto=format&fit=crop&q=80&w=1200',
      achievements: [],
    ),
    const _PassportCountry(
      flag: '🇮🇳',
      name: 'India',
      description:
          'A subcontinent of flavors that defies categorization. Saffron biryani from Lucknow, spiced coastal curries from Kerala, Mughal feasts from Delhi -- infinite stories in every spice.',
      accentHex: 'C4956A',
      visited: false,
      stamps: 0,
      heroImage:
          'https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&q=80&w=1200',
      achievements: [],
    ),
    const _PassportCountry(
      flag: '🇸🇬',
      name: 'Singapore',
      description:
          'The world\'s greatest hawker culture elevated to Michelin-starred heights. A melting pot where Malay, Chinese, Indian, and Peranakan traditions create something entirely unique.',
      accentHex: 'F2D1D1',
      visited: false,
      stamps: 0,
      heroImage:
          'https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&q=80&w=1200',
      achievements: [],
    ),
    const _PassportCountry(
      flag: '🇲🇾',
      name: 'Malaysia',
      description:
          'Nasi lemak for breakfast, laksa for lunch, satay at sunset. Malaysia\'s food culture is a loving collision of Malay, Chinese, Indian, and indigenous influences.',
      accentHex: '8B1E1E',
      visited: false,
      stamps: 0,
      heroImage:
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&q=80&w=1200',
      achievements: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.deepIndigo,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // -- Passport Header ------------------------------------------
            SliverToBoxAdapter(child: _buildHeader(context)),

            // -- Journey Summary ------------------------------------------
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              sliver: SliverToBoxAdapter(child: _buildJourneySummary()),
            ),

            // -- Section Label --------------------------------------------
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 1,
                      color: AppColors.lotusGold.withValues(alpha: 0.4),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'DESTINATIONS',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: AppColors.lotusGold,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // -- Country Cards Carousel -----------------------------------
            SliverToBoxAdapter(
              child: SizedBox(
                height: 420,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      setState(() => _selectedIndex = index),
                  itemCount: _countries.length,
                  itemBuilder: (context, index) {
                    return _PassportCountryCard(
                      country: _countries[index],
                      isActive: index == _selectedIndex,
                    );
                  },
                ),
              ),
            ),

            // -- Page Indicator -------------------------------------------
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_countries.length, (index) {
                    final isActive = index == _selectedIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 20 : 4,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: isActive
                            ? AppColors.lotusGold
                            : AppColors.softIvory.withValues(alpha: 0.15),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // -- Achievements Section (if visited) ------------------------
            if (_countries[_selectedIndex].visited)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                sliver: SliverToBoxAdapter(
                  child: _buildAchievements(_countries[_selectedIndex]),
                ),
              ),

            // -- Upcoming Discoveries -------------------------------------
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 60),
              sliver: SliverToBoxAdapter(child: _buildUpcomingDiscoveries()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        // Ambient background
        Container(
          height: 200,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E3328),
                AppColors.deepIndigo,
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back + title row
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.softIvory.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.softIvory.withValues(alpha: 0.6),
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'CULINARY PASSPORT',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: AppColors.lotusGold,
                        letterSpacing: 3.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Your Journey\nThrough Asia',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 38,
                    color: AppColors.softIvory,
                    fontWeight: FontWeight.w300,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Every reservation earns a stamp. Every stamp tells a story.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.softIvory.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate().fade(duration: 700.ms);
  }

  Widget _buildJourneySummary() {
    final visitedCount = _countries.where((c) => c.visited).length;
    final totalStamps = _countries.fold<int>(0, (sum, c) => sum + c.stamps);

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            value: '$visitedCount',
            label: 'Countries\nExplored',
            color: AppColors.sakuraPink,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            value: '$totalStamps',
            label: 'Stamps\nCollected',
            color: AppColors.lotusGold,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            value: '${_countries.length - visitedCount}',
            label: 'Destinations\nAwaiting',
            color: AppColors.teaBrown,
          ),
        ),
      ],
    ).animate().fade(delay: 200.ms, duration: 700.ms);
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSlate,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 36,
              color: color,
              fontWeight: FontWeight.w300,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: AppColors.softIvory.withValues(alpha: 0.4),
              height: 1.4,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements(_PassportCountry country) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 1,
              color: AppColors.lotusGold.withValues(alpha: 0.4),
            ),
            const SizedBox(width: 10),
            Text(
              'ACHIEVEMENTS UNLOCKED',
              style: GoogleFonts.inter(
                fontSize: 9,
                color: AppColors.lotusGold,
                letterSpacing: 2.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: country.achievements.map((achievement) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.darkSlate,
                border: Border.all(
                  color: AppColors.lotusGold.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 10,
                    color: AppColors.lotusGold.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    achievement,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.softIvory.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fade(delay: 100.ms, duration: 600.ms);
  }

  Widget _buildUpcomingDiscoveries() {
    final undiscovered = _countries.where((c) => !c.visited).take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 1,
              color: AppColors.lotusGold.withValues(alpha: 0.4),
            ),
            const SizedBox(width: 10),
            Text(
              'AWAITING DISCOVERY',
              style: GoogleFonts.inter(
                fontSize: 9,
                color: AppColors.lotusGold,
                letterSpacing: 2.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...undiscovered.map((country) => _buildUndiscoveredRow(country)),
      ],
    );
  }

  Widget _buildUndiscoveredRow(_PassportCountry country) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSlate,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.softIvory.withValues(alpha: 0.04)),
      ),
      child: Row(
        children: [
          Text(country.flag, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  country.name,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 20,
                    color: AppColors.softIvory.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Make a reservation to unlock',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.softIvory.withValues(alpha: 0.25),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.lock_outline,
            color: AppColors.softIvory.withValues(alpha: 0.15),
            size: 16,
          ),
        ],
      ),
    );
  }
}

// --- Passport Country Card ----------------------------------------------------

class _PassportCountryCard extends StatelessWidget {
  final _PassportCountry country;
  final bool isActive;

  const _PassportCountryCard({
    required this.country,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = Color(int.parse('0xFF${country.accentHex}'));

    return AnimatedScale(
      scale: isActive ? 1.0 : 0.94,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: accentColor.withValues(alpha: 0.12),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              MisoNetworkImage(
                imageUrl: country.heroImage,
                fit: BoxFit.cover,
              ),

              // Gradient overlay
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.5),
                      Colors.black.withValues(alpha: 0.92),
                    ],
                    stops: const [0.3, 0.65, 1.0],
                  ),
                ),
              ),

              // If not visited: frosted lock overlay
              if (!country.visited)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                ),

              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Flag + status badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          country.flag,
                          style: const TextStyle(fontSize: 32),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: country.visited
                                ? accentColor.withValues(alpha: 0.2)
                                : Colors.black.withValues(alpha: 0.3),
                            border: Border.all(
                              color: country.visited
                                  ? accentColor.withValues(alpha: 0.5)
                                  : AppColors.softIvory.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Text(
                            country.visited
                                ? '${country.stamps} STAMPS'
                                : 'UNDISCOVERED',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              color: country.visited
                                  ? accentColor
                                  : AppColors.softIvory.withValues(alpha: 0.35),
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Country info
                    if (country.visited && country.visitedDate != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'First visited ${country.visitedDate!}'.toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            color: accentColor.withValues(alpha: 0.7),
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    Text(
                      country.name,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 34,
                        color: AppColors.softIvory,
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      country.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.softIvory.withValues(alpha: 0.55),
                        height: 1.55,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    if (!country.visited) ...[
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(
                            Icons.explore_outlined,
                            color: AppColors.lotusGold,
                            size: 12,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'RESERVE TO UNLOCK THIS CHAPTER',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              color: AppColors.lotusGold,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
