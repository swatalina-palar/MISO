import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../shared/widgets/miso_components.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF2C4C3B);
    const goldAccent = Color(0xFFC6A25A);
    const textPrimary = Color(0xFFE8D8A7);
    const textSecondary = Color(0xFF8B8A87);

    final List<String> countries = [
      'Japan', 'Korea', 'China', 'Thailand', 'Vietnam', 
      'India', 'Nepal', 'Sri Lanka', 'Malaysia', 'Singapore', 'Indonesia', 'Philippines'
    ];

    final List<String> collections = [
      'Hidden Gems', 'Michelin Experiences', 'Chef\'s Choice', 
      'Street Food Icons', 'Fine Dining', 'Tea Culture', 
      'Regional Specialties', 'Seasonal Festivals'
    ];

    final List<String> collectionImages = [
      'https://images.unsplash.com/photo-1512132411229-c303c124aed0?auto=format&fit=crop&q=80&w=800',
      'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&q=80&w=800',
      'https://images.unsplash.com/photo-1555126634-323283e090fa?auto=format&fit=crop&q=80&w=800',
      'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&q=80&w=800',
      'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf?auto=format&fit=crop&q=80&w=800',
      'https://images.unsplash.com/photo-1576092762791-dd9e2220afa1?auto=format&fit=crop&q=80&w=800',
      'https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&q=80&w=800',
      'https://images.unsplash.com/photo-1611143669185-af224c5e3252?auto=format&fit=crop&q=80&w=800',
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: bgColor,
              floating: true,
              pinned: true,
              elevation: 0,
              title: Text(
                'Discover',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 28,
                  color: textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            
            // Search & Filters
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Premium Search Field with Voice
                    const _DiscoverSearchBar().animate().fade(duration: 400.ms),
                    
                    const SizedBox(height: 24),
                    
                    // Country Filter Chips
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: countries.length,
                        itemBuilder: (context, index) {
                          final isSelected = index == 0;
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: isSelected ? goldAccent : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? goldAccent : Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                countries[index],
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  color: isSelected ? Colors.black : textPrimary,
                                ),
                              ),
                            ),
                          ).animate().fade(delay: (200 + (index * 50)).ms);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Immersive Collections
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final collection = collections[index];
                    final imgUrl = collectionImages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xFF161616),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.6),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: MisoNetworkImage(
                                  imageUrl: imgUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Luxury Gradient Overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.4),
                                      Colors.black.withValues(alpha: 0.95),
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                  ),
                                ),
                              ),
                            ),
                            // Editorial Content
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: goldAccent.withValues(alpha: 0.3)),
                                    ),
                                    child: Text(
                                      'FEATURED COLLECTION',
                                      style: GoogleFonts.inter(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: goldAccent,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    collection,
                                    style: GoogleFonts.cormorantGaramond(
                                      fontSize: 32,
                                      color: textPrimary,
                                      fontWeight: FontWeight.w600,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Discover handpicked venues curated by our experts for an unforgettable dining experience.',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: textSecondary,
                                      height: 1.5,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).animate().fade(delay: (400 + (index * 150)).ms).slideY(begin: 0.1, end: 0),
                    );
                  },
                  childCount: collections.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscoverSearchBar extends StatefulWidget {
  const _DiscoverSearchBar();

  @override
  State<_DiscoverSearchBar> createState() => _DiscoverSearchBarState();
}

class _DiscoverSearchBarState extends State<_DiscoverSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _startVoiceSearch() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _DiscoverVoiceSearchSheet(
        onResult: (text) {
          setState(() {
            _controller.text = text;
          });
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
    // We recreate the premium search field styling but wrapped in state
    // with a text controller and voice search capability.
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.3)), // goldAccent
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.search, color: Color(0xFFD4AF37), size: 24),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Search destinations or cuisines',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white70,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              cursorColor: const Color(0xFFD4AF37),
            ),
          ),
          GestureDetector(
            onTap: _startVoiceSearch,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.mic, color: Colors.white70, size: 22),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8, left: 4),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD4AF37),
            ),
            child: const Icon(Icons.tune, color: Colors.black, size: 18),
          ),
        ],
      ),
    );
  }
}

class _DiscoverVoiceSearchSheet extends StatefulWidget {
  final ValueChanged<String> onResult;

  const _DiscoverVoiceSearchSheet({required this.onResult});

  @override
  State<_DiscoverVoiceSearchSheet> createState() => _DiscoverVoiceSearchSheetState();
}

class _DiscoverVoiceSearchSheetState extends State<_DiscoverVoiceSearchSheet> {
  String _status = "Listening...";
  
  @override
  void initState() {
    super.initState();
    _simulateListening();
  }

  Future<void> _simulateListening() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _status = "Processing...");
    }
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      widget.onResult("Michelin Star Sushi in Ginza");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
            ),
            child: const Icon(Icons.mic, size: 48, color: Color(0xFFD4AF37))
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 800.ms)
                .fade(begin: 0.6, end: 1.0, duration: 800.ms),
          ),
          const SizedBox(height: 32),
          Text(
            _status,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 24,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ).animate().fade(duration: 400.ms),
        ],
      ),
    );
  }
}
