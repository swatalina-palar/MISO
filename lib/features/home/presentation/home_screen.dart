import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/miso_components.dart';

// --- Data Models ------------------------------------------------------------

class _EditorialCollection {
  final String title;
  final String subtitle;
  final String story;
  final String image;
  final String label;
  final Color accentColor;

  const _EditorialCollection({
    required this.title,
    required this.subtitle,
    required this.story,
    required this.image,
    required this.label,
    required this.accentColor,
  });
}

// --- Home Screen -------------------------------------------------------------

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<_EditorialCollection> _collections = [
    const _EditorialCollection(
      title: 'Taste of Kyoto',
      subtitle: 'Seasonal Kaiseki & Tea Ceremony',
      story:
          'Follow the ancient ritual of kaiseki through Kyoto\'s most celebrated culinary masters. Where each dish is a brushstroke of the season.',
      image:
          'https://images.unsplash.com/photo-1611143669185-af224c5e3252?auto=format&fit=crop&q=80&w=1200',
      label: 'JAPANESE · 12 EXPERIENCES',
      accentColor: Color(0xFFF2D1D1),
    ),
    const _EditorialCollection(
      title: 'Hidden Gems of Seoul',
      subtitle: 'Underground Culinary Renaissance',
      story:
          'Beyond the neon-lit streets of Gangnam lie alleyways where three-generation recipes transform humble ingredients into profound meals.',
      image:
          'https://images.unsplash.com/photo-1580651315530-69c8e0026377?auto=format&fit=crop&q=80&w=1200',
      label: 'KOREAN · 8 EXPERIENCES',
      accentColor: Color(0xFF8B9D77),
    ),
    const _EditorialCollection(
      title: 'Tokyo After Dark',
      subtitle: 'Wagyu Omakase & Night Markets',
      story:
          'As the city transforms after sunset, Tokyo\'s most exclusive dining rooms open their doors. Charcoal smoke, rare cuts, and whispered traditions.',
      image:
          'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&q=80&w=1200',
      label: 'JAPANESE · 15 EXPERIENCES',
      accentColor: Color(0xFFD6C59A),
    ),
    const _EditorialCollection(
      title: 'Michelin Collection',
      subtitle: 'Starred Experiences Across Asia',
      story:
          'Curated from the red guide\'s most celebrated kitchens in Tokyo, Hong Kong, Seoul, and Singapore. Dining as art form.',
      image:
          'https://images.unsplash.com/photo-1553621042-f6e147245754?auto=format&fit=crop&q=80&w=1200',
      label: 'PAN ASIAN · 24 EXPERIENCES',
      accentColor: Color(0xFFD6C59A),
    ),
    const _EditorialCollection(
      title: 'Tea Ceremony Collection',
      subtitle: 'The Art of Intentional Pause',
      story:
          'From matcha in Uji to pu-erh in Yunnan, discover the quiet ceremonies that have shaped Asian culture for over a thousand years.',
      image:
          'https://images.unsplash.com/photo-1556679343-c7306c1976bc?auto=format&fit=crop&q=80&w=1200',
      label: 'MULTI-CULTURAL · 9 EXPERIENCES',
      accentColor: Color(0xFF8B9D77),
    ),
    const _EditorialCollection(
      title: 'Street Food Legends',
      subtitle: 'The Soul of Asia on a Plate',
      story:
          'Hawker stalls with 50-year legacies, night markets with cult followings, and recipes that no restaurant has ever replicated.',
      image:
          'https://images.unsplash.com/photo-1559314809-0d155014e29e?auto=format&fit=crop&q=80&w=1200',
      label: 'PAN ASIAN · 31 EXPERIENCES',
      accentColor: Color(0xFF8B1E1E),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.deepIndigo,
        body: Stack(
          children: [
            // -- Ambient Background ------------------------------------------
            const Positioned.fill(
              child: Opacity(
                opacity: 0.06,
                child: MisoNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1563200787-8fb6e7191d84?auto=format&fit=crop&q=80&w=1200',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // -- Main Scroll Body --------------------------------------------
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // -- Greeting Header -----------------------------------------
                SliverToBoxAdapter(
                  child: SafeArea(
                    bottom: false,
                    child: _buildHeader(),
                  ),
                ),

                // -- Search Bar -----------------------------------------------
                SliverToBoxAdapter(
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: _HomeSearchBar(),
                  ).animate().fade(delay: 200.ms),
                ),

                // -- Editorial Label ------------------------------------------
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 1,
                          color: AppColors.lotusGold.withValues(alpha: 0.5),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'CURATED COLLECTIONS',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: AppColors.lotusGold,
                            letterSpacing: 3.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fade(delay: 400.ms),
                ),

                // -- Editorial Collections ------------------------------------
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final collection = _collections[index];
                        return _EditorialCard(
                          collection: collection,
                          index: index,
                        );
                      },
                      childCount: _collections.length,
                    ),
                  ),
                ),

                // -- Passport Teaser ------------------------------------------
                SliverToBoxAdapter(
                  child: _buildPassportTeaser(),
                ),

                // -- Bottom Spacer for nav ------------------------------------
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),

            // -- Glass Navigation Bar -----------------------------------------
            _buildNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    // Greeting changes based on time
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'GOOD MORNING'
        : hour < 17
            ? 'GOOD AFTERNOON'
            : 'GOOD EVENING';

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Avatar + Greeting
          Row(
            children: [
              GestureDetector(
                onTap: () => context.push('/profile'),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.lotusGold.withValues(alpha: 0.4),
                      width: 1,
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: AppColors.lotusGold,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Lily Chen',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 22,
                      color: AppColors.softIvory,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // AI Concierge Button
          GestureDetector(
            onTap: () => context.push('/concierge'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColors.lotusGold.withValues(alpha: 0.3),
                ),
                color: AppColors.darkSlate.withValues(alpha: 0.4),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: AppColors.lotusGold,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Concierge',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.lotusGold,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 800.ms).slideY(begin: -0.05, end: 0);
  }

  Widget _buildPassportTeaser() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: GestureDetector(
        onTap: () => context.push('/passport'),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.lotusGold.withValues(alpha: 0.15),
                AppColors.deepIndigo.withValues(alpha: 0.8),
              ],
            ),
            border: Border.all(
              color: AppColors.lotusGold.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_stories_outlined,
                    color: AppColors.lotusGold,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'YOUR CULINARY PASSPORT',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: AppColors.lotusGold,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '3 Countries\nExplored',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 32,
                  color: AppColors.softIvory,
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your journey through Asia has just begun. Seven more destinations await your discovery.',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.softIvory.withValues(alpha: 0.5),
                  height: 1.6,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const _PassportStamp(country: '🇯🇵', visited: true),
                  const SizedBox(width: 8),
                  const _PassportStamp(country: '🇰🇷', visited: true),
                  const SizedBox(width: 8),
                  const _PassportStamp(country: '🇨🇳', visited: true),
                  const SizedBox(width: 8),
                  const _PassportStamp(country: '🇹🇭', visited: false),
                  const SizedBox(width: 8),
                  const _PassportStamp(country: '🇻🇳', visited: false),
                  const SizedBox(width: 8),
                  const _PassportStamp(country: '🇮🇳', visited: false),
                  const SizedBox(width: 8),
                  Text(
                    '+4',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.softIvory.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'VIEW MY PASSPORT',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: AppColors.lotusGold,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    color: AppColors.lotusGold,
                    size: 12,
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().fade(delay: 600.ms, duration: 800.ms).slideY(
            begin: 0.05,
            end: 0,
            curve: Curves.easeOutCubic,
          ),
    );
  }

  Widget _buildNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.deepIndigo.withValues(alpha: 0.85),
                border: Border(
                  top: BorderSide(
                    color: AppColors.softIvory.withValues(alpha: 0.06),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavItem(
                    index: 0,
                    current: _currentIndex,
                    icon: Icons.explore_outlined,
                    selectedIcon: Icons.explore,
                    label: 'Explore',
                    onTap: () => setState(() => _currentIndex = 0),
                  ),
                  _NavItem(
                    index: 1,
                    current: _currentIndex,
                    icon: Icons.auto_stories_outlined,
                    selectedIcon: Icons.auto_stories,
                    label: 'Passport',
                    onTap: () {
                      setState(() => _currentIndex = 1);
                      context.push('/passport');
                    },
                  ),
                  _NavItem(
                    index: 2,
                    current: _currentIndex,
                    icon: Icons.auto_awesome,
                    selectedIcon: Icons.auto_awesome,
                    label: 'Concierge',
                    onTap: () {
                      setState(() => _currentIndex = 2);
                      context.push('/concierge');
                    },
                  ),
                  _NavItem(
                    index: 3,
                    current: _currentIndex,
                    icon: Icons.bookmark_outline,
                    selectedIcon: Icons.bookmark,
                    label: 'Reservations',
                    onTap: () {
                      setState(() => _currentIndex = 3);
                      context.push('/reservation');
                    },
                  ),
                  _NavItem(
                    index: 4,
                    current: _currentIndex,
                    icon: Icons.person_outline,
                    selectedIcon: Icons.person,
                    label: 'Profile',
                    onTap: () {
                      setState(() => _currentIndex = 4);
                      context.push('/profile');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- Editorial Card -----------------------------------------------------------

class _EditorialCard extends StatefulWidget {
  final _EditorialCollection collection;
  final int index;

  const _EditorialCard({required this.collection, required this.index});

  @override
  State<_EditorialCard> createState() => _EditorialCardState();
}

class _EditorialCardState extends State<_EditorialCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.collection;
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          context.push('/restaurant/kyoto_kaiseki');
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.98 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 30,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -- Cinematic Image ----------------------------------------
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: MisoNetworkImage(
                            imageUrl: c.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Top gradient fade
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.1),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Collection label badge
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: c.accentColor.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Text(
                              c.label,
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                color: c.accentColor,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // -- Editorial Text -----------------------------------------
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.darkSlate,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.subtitle.toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          color: c.accentColor.withValues(alpha: 0.8),
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        c.title,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 30,
                          color: AppColors.softIvory,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.5,
                          height: 1.05,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        c.story,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.softIvory.withValues(alpha: 0.55),
                          height: 1.65,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EXPLORE COLLECTION',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              color: AppColors.lotusGold,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.lotusGold.withValues(alpha: 0.3),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: AppColors.lotusGold,
                              size: 12,
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
        ),
      )
          .animate()
          .fade(
            delay: Duration(milliseconds: 300 + widget.index * 120),
            duration: 700.ms,
          )
          .slideY(
            begin: 0.08,
            end: 0,
            curve: Curves.easeOutCubic,
          ),
    );
  }
}

// --- Passport Stamp Widget ----------------------------------------------------

class _PassportStamp extends StatelessWidget {
  final String country;
  final bool visited;

  const _PassportStamp({required this.country, required this.visited});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: visited
            ? AppColors.lotusGold.withValues(alpha: 0.15)
            : AppColors.darkSlate,
        border: Border.all(
          color: visited
              ? AppColors.lotusGold.withValues(alpha: 0.4)
              : AppColors.softIvory.withValues(alpha: 0.1),
        ),
      ),
      child: Center(
        child: Opacity(
          opacity: visited ? 1.0 : 0.3,
          child: Text(
            country,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

// --- Navigation Item ----------------------------------------------------------

class _NavItem extends StatelessWidget {
  final int index;
  final int current;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.current,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == current;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? selectedIcon : icon,
                key: ValueKey(isSelected),
                color: isSelected
                    ? AppColors.lotusGold
                    : AppColors.softIvory.withValues(alpha: 0.35),
                size: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 9,
                color: isSelected
                    ? AppColors.lotusGold
                    : AppColors.softIvory.withValues(alpha: 0.35),
                fontWeight:
                    isSelected ? FontWeight.w500 : FontWeight.w400,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Search Bar ---------------------------------------------------------------

class _HomeSearchBar extends StatefulWidget {
  const _HomeSearchBar();

  @override
  State<_HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<_HomeSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isFocused = false;

  void _startVoiceSearch() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _VoiceSearchSheet(
        onResult: (query) {
          _controller.text = query;
          setState(() {});
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.darkSlate.withValues(alpha: 0.6),
        border: Border.all(
          color: _isFocused
              ? AppColors.lotusGold.withValues(alpha: 0.4)
              : AppColors.softIvory.withValues(alpha: 0.08),
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: AppColors.lotusGold.withValues(alpha: 0.06),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.softIvory.withValues(alpha: 0.3),
                  size: 18,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Focus(
                    onFocusChange: (hasFocus) =>
                        setState(() => _isFocused = hasFocus),
                    child: TextField(
                      controller: _controller,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.softIvory,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Discover an experience...',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.softIvory.withValues(alpha: 0.3),
                          fontWeight: FontWeight.w300,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      cursorColor: AppColors.lotusGold,
                      cursorWidth: 1,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _startVoiceSearch,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppColors.sakuraPink.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mic_none,
                      color: AppColors.sakuraPink,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Voice Search Sheet -------------------------------------------------------

class _VoiceSearchSheet extends StatefulWidget {
  final ValueChanged<String> onResult;

  const _VoiceSearchSheet({required this.onResult});

  @override
  State<_VoiceSearchSheet> createState() => _VoiceSearchSheetState();
}

class _VoiceSearchSheetState extends State<_VoiceSearchSheet> {
  String _status = 'Listening...';

  @override
  void initState() {
    super.initState();
    _simulateListening();
  }

  Future<void> _simulateListening() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _status = 'Processing...');
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      widget.onResult('Authentic Omakase in Tokyo');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: const BoxDecoration(
        color: AppColors.charcoalBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.softIvory.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.sakuraPink.withValues(alpha: 0.1),
              border: Border.all(color: AppColors.sakuraPink.withValues(alpha: 0.2)),
            ),
            child: const Icon(Icons.mic, size: 36, color: AppColors.sakuraPink)
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.15, 1.15),
                  duration: 900.ms,
                  curve: Curves.easeInOut,
                ),
          ),
          const SizedBox(height: 28),
          Text(
            _status,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 22,
              color: AppColors.softIvory,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
            ),
          ).animate().fade(duration: 400.ms),
        ],
      ),
    );
  }
}
