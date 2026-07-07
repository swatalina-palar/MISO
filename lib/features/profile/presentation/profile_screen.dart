import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/miso_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.deepIndigo,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // -- Cinematic Header -----------------------------------------
            SliverToBoxAdapter(child: _buildHeader(context)),

            // -- Passport Preview -----------------------------------------
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              sliver: SliverToBoxAdapter(
                child: _buildPassportPreview(context),
              ),
            ),

            // -- Journey Stats --------------------------------------------
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              sliver: SliverToBoxAdapter(child: _buildJourneyStats()),
            ),

            // -- Dining Journal -------------------------------------------
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              sliver: SliverToBoxAdapter(child: _buildDiningJournal()),
            ),

            // -- Settings Section -----------------------------------------
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              sliver: SliverToBoxAdapter(child: _buildSettings(context)),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        // Background image
        const SizedBox(
          height: 300,
          width: double.infinity,
          child: MisoNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&q=80&w=1200',
            fit: BoxFit.cover,
          ),
        ),
        // Gradient overlay
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.2),
                AppColors.deepIndigo,
              ],
              stops: const [0.3, 1.0],
            ),
          ),
        ),
        // Back button
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.3),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        // Profile info
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.lotusGold.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MISO SOCIETY · GOLD',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          color: AppColors.lotusGold,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Lily Chen',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 30,
                          color: AppColors.softIvory,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.darkSlate.withValues(alpha: 0.5),
                    border: Border.all(
                      color: AppColors.softIvory.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    color: AppColors.softIvory.withValues(alpha: 0.5),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate().fade(duration: 700.ms);
  }

  Widget _buildPassportPreview(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/passport'),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.lotusGold.withValues(alpha: 0.18),
              AppColors.darkSlate,
            ],
          ),
          border: Border.all(
            color: AppColors.lotusGold.withValues(alpha: 0.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.auto_stories,
                      color: AppColors.lotusGold,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'CULINARY PASSPORT',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: AppColors.lotusGold,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  'VIEW ALL -',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: AppColors.lotusGold.withValues(alpha: 0.6),
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 52,
                          color: AppColors.softIvory,
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                      ),
                      Text(
                        'Countries Explored',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.softIvory.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 50,
                  color: AppColors.softIvory.withValues(alpha: 0.08),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '18',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 52,
                          color: AppColors.softIvory,
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                      ),
                      Text(
                        'Stamps Collected',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.softIvory.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Country stamps row
            Row(
              children: [
                _buildCountryStamp('🇯🇵', 'Japan', true),
                const SizedBox(width: 10),
                _buildCountryStamp('🇰🇷', 'Korea', true),
                const SizedBox(width: 10),
                _buildCountryStamp('🇨🇳', 'China', true),
                const SizedBox(width: 10),
                _buildCountryStamp('🇹🇭', 'Thailand', false),
                const SizedBox(width: 10),
                _buildCountryStamp('🇻🇳', 'Vietnam', false),
              ],
            ),
          ],
        ),
      ).animate().fade(delay: 200.ms, duration: 700.ms).slideY(
            begin: 0.05,
            end: 0,
            curve: Curves.easeOutCubic,
          ),
    );
  }

  Widget _buildCountryStamp(String flag, String name, bool visited) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: visited
                ? AppColors.lotusGold.withValues(alpha: 0.12)
                : AppColors.darkSlate.withValues(alpha: 0.5),
            border: Border.all(
              color: visited
                  ? AppColors.lotusGold.withValues(alpha: 0.4)
                  : AppColors.softIvory.withValues(alpha: 0.06),
            ),
          ),
          child: Center(
            child: Opacity(
              opacity: visited ? 1.0 : 0.2,
              child: Text(flag, style: const TextStyle(fontSize: 22)),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 9,
            color: visited
                ? AppColors.softIvory.withValues(alpha: 0.6)
                : AppColors.softIvory.withValues(alpha: 0.2),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('DINING JOURNAL'),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                value: '42',
                label: 'Restaurants\nVisited',
                icon: Icons.restaurant_outlined,
                color: AppColors.sakuraPink,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                value: '7',
                label: 'Michelin\nExperiences',
                icon: Icons.star_outline,
                color: AppColors.lotusGold,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                value: '156',
                label: 'Dishes\nDiscovered',
                icon: Icons.set_meal_outlined,
                color: AppColors.teaBrown,
              ),
            ),
          ],
        ),
      ],
    ).animate().fade(delay: 400.ms, duration: 700.ms);
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSlate,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 32,
              color: AppColors.softIvory,
              fontWeight: FontWeight.w300,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
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

  Widget _buildDiningJournal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('RECENT EXPERIENCES'),
        const SizedBox(height: 20),
        _buildJournalEntry(
          restaurant: 'Kyoto Kaiseki',
          date: 'June 14, 2025',
          cuisine: 'Japanese · Kaiseki',
          image:
              'https://images.unsplash.com/photo-1611143669185-af224c5e3252?auto=format&fit=crop&q=80&w=400',
          rating: 5,
        ),
        const SizedBox(height: 12),
        _buildJournalEntry(
          restaurant: 'Jungsik Seoul',
          date: 'May 28, 2025',
          cuisine: 'Korean · Modern',
          image:
              'https://images.unsplash.com/photo-1580651315530-69c8e0026377?auto=format&fit=crop&q=80&w=400',
          rating: 5,
        ),
        const SizedBox(height: 12),
        _buildJournalEntry(
          restaurant: 'Imperial Garden',
          date: 'May 10, 2025',
          cuisine: 'Chinese · Cantonese',
          image:
              'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf?auto=format&fit=crop&q=80&w=400',
          rating: 4,
        ),
      ],
    ).animate().fade(delay: 500.ms, duration: 700.ms);
  }

  Widget _buildJournalEntry({
    required String restaurant,
    required String date,
    required String cuisine,
    required String image,
    required int rating,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSlate,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.softIvory.withValues(alpha: 0.04)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 60,
              height: 60,
              child: MisoNetworkImage(imageUrl: image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 18,
                    color: AppColors.softIvory,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cuisine,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.softIvory.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: AppColors.lotusGold.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(
              5,
              (i) => Icon(
                i < rating ? Icons.star : Icons.star_outline,
                color: i < rating
                    ? AppColors.lotusGold
                    : AppColors.softIvory.withValues(alpha: 0.2),
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('ACCOUNT'),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkSlate,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.softIvory.withValues(alpha: 0.04)),
          ),
          child: Column(
            children: [
              _buildSettingsRow(
                context,
                icon: Icons.bookmark_outline,
                label: 'Saved Collections',
                route: null,
              ),
              _buildDivider(),
              _buildSettingsRow(
                context,
                icon: Icons.card_membership_outlined,
                label: 'MISO Society Rewards',
                route: '/rewards',
              ),
              _buildDivider(),
              _buildSettingsRow(
                context,
                icon: Icons.credit_card_outlined,
                label: 'Payment Methods',
                route: null,
              ),
              _buildDivider(),
              _buildSettingsRow(
                context,
                icon: Icons.settings_outlined,
                label: 'Preferences & Settings',
                route: '/settings',
              ),
              _buildDivider(),
              _buildSettingsRow(
                context,
                icon: Icons.help_outline,
                label: 'Help & Support',
                route: null,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Center(
          child: GestureDetector(
            onTap: () {},
            child: Text(
              'Sign Out',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.crimsonRed.withValues(alpha: 0.7),
                letterSpacing: 0.5,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    ).animate().fade(delay: 600.ms, duration: 700.ms);
  }

  Widget _buildSectionLabel(String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 1,
          color: AppColors.lotusGold.withValues(alpha: 0.4),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9,
            color: AppColors.lotusGold,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String? route,
  }) {
    return GestureDetector(
      onTap: () => route != null ? context.push(route) : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.softIvory.withValues(alpha: 0.4), size: 18),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.softIvory.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.softIvory.withValues(alpha: 0.2),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 1,
        color: AppColors.softIvory.withValues(alpha: 0.05),
      ),
    );
  }
}
